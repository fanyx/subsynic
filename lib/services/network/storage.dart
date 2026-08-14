import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path/path.dart' as p;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:saf/saf.dart';

import '../../services/settings.dart';

part 'storage.g.dart';

class StorageEntry {
  final String name;
  final bool isDirectory;
  final Uri uri;

  const StorageEntry({
    required this.name,
    required this.isDirectory,
    required this.uri,
  });
}

abstract class LibraryStorage {
  bool get isConfigured;

  /// Resolves a relative path under the library root to a platform URI.
  ///
  /// Returns `null` when no file exists at [relativePath].
  Future<Uri?> resolve(String relativePath);

  Future<bool> exists(String relativePath);

  Future<void> writeFile(String relativePath, List<int> bytes);

  /// Streams [stream] straight into the file at [relativePath].
  Future<void> writeFileStream(String relativePath, Stream<List<int>> stream);

  Future<Uint8List> readFile(String relativePath);

  Future<bool> deleteFile(String relativePath);

  Future<bool> deleteDirectory(String relativePath);

  /// Whether any file exists anywhere in the [relativePath] subtree.
  Future<bool> directoryContainsFiles(String relativePath);

  Future<List<StorageEntry>> listDirectory(String relativePath);
}

/// Storage backed by the plain filesystem under [rootPath].
///
/// Kept for desktop/tests only (and as the unconfigured fallback). All writes
/// are direct `dart:io` file operations on [rootPath]; on Android this must
/// not be used for a user-picked root (scoped storage) — use
/// [SafStorageProvider] instead.
class FileStorageProvider implements LibraryStorage {
  final String rootPath;

  FileStorageProvider(this.rootPath);

  String _full(String relativePath) => p.join(rootPath, relativePath);

  @override
  bool get isConfigured => rootPath.isNotEmpty;

  @override
  Future<bool> exists(String relativePath) async {
    if (!isConfigured) return false;
    return File(_full(relativePath)).exists();
  }

  @override
  Future<bool> deleteFile(String relativePath) async {
    try {
      final file = File(_full(relativePath));
      if (await file.exists()) {
        await file.delete();
        return true;
      }
    } catch (_) {}
    return false;
  }

  @override
  Future<bool> deleteDirectory(String relativePath) async {
    try {
      final dir = Directory(_full(relativePath));
      if (await dir.exists()) {
        await dir.delete(recursive: true);
        return true;
      }
    } catch (_) {}
    return false;
  }

  @override
  Future<bool> directoryContainsFiles(String relativePath) async {
    if (!isConfigured) return false;
    final dir = Directory(_full(relativePath));
    if (!await dir.exists()) return false;
    await for (final entity in dir.list(recursive: true)) {
      if (entity is File) return true;
    }
    return false;
  }

  @override
  Future<List<StorageEntry>> listDirectory(String relativePath) async {
    if (!isConfigured) return const [];
    final dir = Directory(_full(relativePath));
    if (!await dir.exists()) return const [];

    final entries = <StorageEntry>[];
    await for (var entity in dir.list()) {
      entries.add(
        StorageEntry(
          name: p.basename(entity.path),
          isDirectory: entity is Directory,
          uri: entity.uri,
        ),
      );
    }
    return entries;
  }

  @override
  Future<Uint8List> readFile(String relativePath) async {
    return File(_full(relativePath)).readAsBytes();
  }

  @override
  Future<Uri?> resolve(String relativePath) async {
    final file = File(_full(relativePath));
    if (!await file.exists()) return null;
    return file.uri;
  }

  @override
  Future<void> writeFile(String relativePath, List<int> bytes) async {
    if (!isConfigured) {
      throw StateError('No library root configured.');
    }
    final file = File(_full(relativePath));
    await file.parent.create(recursive: true);
    await file.writeAsBytes(bytes, flush: true);
  }

  @override
  Future<void> writeFileStream(
    String relativePath,
    Stream<List<int>> stream,
  ) async {
    if (!isConfigured) {
      throw StateError('No library root configured.');
    }
    final file = File(_full(relativePath));
    await file.parent.create(recursive: true);
    final sink = file.openWrite();
    try {
      await stream.forEach(sink.add);
    } finally {
      await sink.close();
    }
  }
}

/// Storage backed by a persistable `content://` SAF tree grant via the `saf`
/// package. All operations go through `DocumentsContract`/`ContentResolver`
/// (platform channel), never `dart:io` — the only working path under Android
/// scoped storage.
class SafStorageProvider implements LibraryStorage {
  SafStorageProvider(this.treeUri, {Saf? saf}) : _saf = saf ?? Saf();

  /// The persistable tree URI (`content://.../tree/<id>`).
  final Uri treeUri;
  final Saf _saf;

  static const _imageJpeg = 'image/jpeg';
  static const _audioOgg = 'audio/ogg';

  @override
  bool get isConfigured => true;

  String get _rootUri => treeUri.toString();

  /// Splits a relative path into its segments, normalizing away `.`/`..` and
  /// leading separators so it can be handed to `child`/`mkdirp`.
  List<String> _segments(String relativePath) {
    final normalized = p.posix.normalize(relativePath);
    return normalized
        .split('/')
        .where((s) => s.isNotEmpty && s != '.' && s != '..')
        .toList();
  }

  static String _mimeOf(String relativePath) {
    switch (p.extension(relativePath).toLowerCase()) {
      case '.jpg':
      case '.jpeg':
        return _imageJpeg;
      case '.png':
        return 'image/png';
      default:
        return _audioOgg;
    }
  }

  Future<String> _dirUri(String relativePath) async {
    final segs = _segments(relativePath);
    if (segs.length <= 1) return _rootUri;
    final parent = segs.sublist(0, segs.length - 1);
    return (await _saf.mkdirp(_rootUri, parent)).uri;
  }

  @override
  Future<bool> exists(String relativePath) async {
    final doc = await _saf.child(_rootUri, _segments(relativePath));
    return doc != null;
  }

  @override
  Future<bool> deleteFile(String relativePath) async {
    final uri = await resolve(relativePath);
    if (uri == null) return false;
    try {
      await _saf.delete(uri.toString());
      return true;
    } on SafNotFoundException {
      return false;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<bool> deleteDirectory(String relativePath) async {
    final uri = await resolve(relativePath);
    if (uri == null) return false;
    try {
      await _saf.delete(uri.toString());
      return true;
    } on SafNotFoundException {
      return false;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<bool> directoryContainsFiles(String relativePath) async {
    final uri = await resolve(relativePath);
    if (uri == null) return false;
    try {
      await for (final entry in _saf.walk(uri.toString())) {
        if (!entry.file.isDir) return true;
      }
    } catch (_) {}
    return false;
  }

  @override
  Future<List<StorageEntry>> listDirectory(String relativePath) async {
    final uri = await resolve(relativePath);
    if (uri == null) return const [];
    try {
      final docs = await _saf.list(uri.toString());
      return docs
          .map(
            (d) => StorageEntry(
              name: d.name,
              isDirectory: d.isDir,
              uri: Uri.parse(d.uri),
            ),
          )
          .toList();
    } catch (_) {
      return const [];
    }
  }

  @override
  Future<Uint8List> readFile(String relativePath) async {
    final uri = await resolve(relativePath);
    if (uri == null) throw StateError('No file at $relativePath');
    return _saf.readFileBytes(uri.toString());
  }

  @override
  Future<Uri?> resolve(String relativePath) async {
    final segs = _segments(relativePath);
    if (segs.isEmpty) return treeUri;
    final doc = await _saf.child(_rootUri, segs);
    if (doc == null) return null;
    return Uri.parse(doc.uri);
  }

  @override
  Future<void> writeFile(String relativePath, List<int> bytes) async {
    final segs = _segments(relativePath);
    if (segs.isEmpty) throw StateError('Invalid path: $relativePath');
    final dirUri = await _dirUri(relativePath);
    await _saf.writeFileBytes(
      dirUri,
      segs.last,
      _mimeOf(relativePath),
      Uint8List.fromList(bytes),
      overwrite: true,
    );
  }

  @override
  Future<void> writeFileStream(
    String relativePath,
    Stream<List<int>> stream,
  ) async {
    final segs = _segments(relativePath);
    if (segs.isEmpty) throw StateError('Invalid path: $relativePath');
    final dirUri = await _dirUri(relativePath);
    await _saf.writeFileStream(
      dirUri,
      segs.last,
      _mimeOf(relativePath),
      stream,
      overwrite: true,
    );
  }
}

/// Routes a stored [libraryRootUri] to a working [LibraryStorage].
///
/// - `content://` → [SafStorageProvider] (Android SAF tree grant).
/// - `file://` → [FileStorageProvider] on desktop/tests; on **Android** a
///   legacy `file://` path cannot be written under scoped storage and cannot
///   be converted back to a grant — treat it as unconfigured so the user
///   re-picks a directory.
LibraryStorage createStorage(
  Uri? libraryRootUri, {
  Saf? saf,
  TargetPlatform? platform,
}) {
  if (libraryRootUri == null) return FileStorageProvider('');

  switch (libraryRootUri.scheme) {
    case 'content':
      return SafStorageProvider(libraryRootUri, saf: saf);
    case 'file':
      final isAndroid =
          (platform ?? defaultTargetPlatform) == TargetPlatform.android;
      if (isAndroid) return FileStorageProvider('');
      return FileStorageProvider(libraryRootUri.toFilePath());
    default:
      return FileStorageProvider('');
  }
}

/// Human-readable label for a stored library root:
/// `file://` → filesystem path; `content://.../tree/<id>` → the decoded tree
/// id with the provider prefix stripped (e.g. `Music/Subsynic`); else the raw
/// string.
String humanizeLibraryRootUri(Uri? uri) {
  if (uri == null) return 'Not set';
  if (uri.scheme == 'file') return uri.toFilePath();
  if (uri.scheme == 'content') {
    final segments = uri.pathSegments;
    if (segments.isNotEmpty) {
      final treeId = Uri.decodeComponent(segments.last);
      final colon = treeId.indexOf(':');
      return colon >= 0 ? treeId.substring(colon + 1) : treeId;
    }
  }
  return uri.toString();
}

@Riverpod(keepAlive: true)
Saf saf(Ref ref) => Saf();

@Riverpod(keepAlive: true)
LibraryStorage storage(Ref ref) {
  final uri = ref.watch(
    settingsServiceProvider.select((value) => value.app.libraryRootUri),
  );
  return createStorage(uri, saf: ref.watch(safProvider));
}
