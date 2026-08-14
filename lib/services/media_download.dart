import 'dart:async';
import 'dart:typed_data';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:dio/dio.dart';
import 'package:flutter_taglib/flutter_taglib.dart';
import 'package:path/path.dart' as p;
import 'package:pool/pool.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../database/database.dart' hide Download;
import '../log.dart';
import '../models/download.dart';
import '../models/music.dart';
import '../models/remote_query.dart';
import '../services/settings.dart';
import '../state/server.dart';
import 'filename_policy.dart';
import 'network/client.dart';
import 'network/storage.dart';

part 'media_download.g.dart';

const kCoverFileName = 'cover.jpg';

/// Resolved folder (+ optional cover art id) for a single album during a
/// playlist download.
class _AlbumFolderInfo {
  const _AlbumFolderInfo({required this.folder, this.coverArt});

  final String folder;
  final String? coverArt;
}

@Riverpod(keepAlive: true)
class MediaDownloadService extends _$MediaDownloadService {
  static const _concurrency = 3;
  static const _completedTtl = Duration(minutes: 2);
  static const _sweepInterval = Duration(seconds: 30);

  final Map<String, CancelToken> _tokens = {};

  /// Per-session `albumId -> AlbumDetail` memo so loose song downloads and
  /// retries of the same album share a single `getAlbum` (rule 2: don't call
  /// the server when the answer is already known).
  final Map<String, AlbumDetail> _albumDetailMemo = {};

  Timer? _completedSweepTimer;

  @override
  DownloadState build() {
    _completedSweepTimer = Timer.periodic(
      _sweepInterval,
      (_) => _pruneCompleted(),
    );
    ref.onDispose(() => _completedSweepTimer?.cancel());
    return const DownloadState();
  }

  /// Drops `completed` jobs older than the TTL so a successful group's card
  /// auto-clears. Only rewrites state when it actually prunes.
  void _pruneCompleted() {
    final cutoff = DateTime.now().subtract(_completedTtl);
    final downloads = state.downloads.where((d) {
      if (d.status != DownloadStatus.completed) return true;
      final t = d.completedAt;
      if (t == null) return true;
      return !t.isBefore(cutoff);
    }).toIList();
    if (downloads.length != state.downloads.length) {
      state = state.copyWith(downloads: downloads);
    }
  }

  /// Immediately removes every `completed` job (manual "Clear completed").
  void clearCompleted() {
    state = state.copyWith(
      downloads: state.downloads
          .where((d) => d.status != DownloadStatus.completed)
          .toIList(),
    );
  }

  // -- public API ---------------------------------------------------------

  Future<void> downloadAlbum(AlbumDetail detail) {
    return _downloadList(detail.album.id, () async {
      final songs = await _excludeCompleted(detail.songs.toList());
      if (songs.isEmpty) {
        throw StateError(
          'No tracks left to download for "${detail.album.name}".',
        );
      }

      final folder = _albumFolder(detail);
      try {
        await _ensureCover(
          albumId: detail.album.id,
          coverArt: detail.album.coverArt,
          folder: folder,
        );
      } catch (e, st) {
        log.severe('Cover download failed for ${detail.album.id}', e, st);
      }
      await _downloadSongs(songs, {for (final s in songs) s.id: folder});
    });
  }

  Future<void> downloadPlaylist(PlaylistDetail detail) {
    return _downloadList(detail.playlist.id, () async {
      final songs = await _excludeCompleted(detail.songs.toList());
      if (songs.isEmpty) {
        throw StateError(
          'No tracks left to download for "${detail.playlist.name}".',
        );
      }

      final albumFolders = await _albumFoldersFor(songs);
      final folderBySong = <String, String?>{};
      for (final song in songs) {
        final info = song.albumId != null
            ? albumFolders[song.albumId]
            : null;
        if (info != null) {
          folderBySong[song.id] = info.folder;
          if (info.coverArt != null) {
            try {
              await _ensureCover(
                albumId: song.albumId!,
                coverArt: info.coverArt,
                folder: info.folder,
              );
            } catch (e) {
              log.severe('Cover download failed for ${song.albumId}', e);
            }
          }
        } else {
          folderBySong[song.id] = sanitizePathSegment(
            song.artist ?? 'Unknown Artist',
          );
        }
      }

      await _downloadSongs(songs, folderBySong);
    });
  }

  Future<void> downloadSong(Song song, {AlbumDetail? detail}) async {
    final source = ref.read(musicSourceProvider);
    AlbumDetail? resolved;

    if (song.albumId != null) {
      // Prefer the detail the caller already holds (album detail page) — zero
      // `getAlbum` calls. Otherwise fall back to a per-session memo so loose
      // retries / same-album songs share a single fetch.
      resolved = detail != null && detail.album.id == song.albumId
          ? detail
          : _albumDetailMemo[song.albumId];
      if (resolved == null && source != null) {
        try {
          resolved = await source.album(song.albumId!);
          _albumDetailMemo[song.albumId!] = resolved;
        } catch (e, st) {
          log.severe('Album fetch failed for song ${song.id}', e, st);
        }
      }
    }

    final folder = resolved != null
        ? _albumFolder(resolved)
        : sanitizePathSegment(song.artist ?? 'Unknown Artist');

    if (resolved != null) {
      try {
        await _ensureCover(
          albumId: resolved.album.id,
          coverArt: resolved.album.coverArt,
          folder: folder,
        );
      } catch (e, st) {
        log.severe('Cover download failed for ${resolved.album.id}', e, st);
      }
    }

    await _downloadList(song.id, () => _downloadSong(song, folder));
  }

  Future<void> cancelAlbum(Album album) {
    return _cancelList(album.id, () async {
      final db = ref.read(databaseProvider);
      final rows = await db.downloadsByAlbum(album.id).get();
      for (final row in rows) {
        if (row.downloadStatus == DownloadStatus.downloading ||
            row.downloadStatus == DownloadStatus.queued) {
          _tokens[row.songId]?.cancel();
        }
      }
    });
  }

  Future<void> cancelPlaylist(Playlist playlist, {PlaylistDetail? detail}) {
    return _cancelList(playlist.id, () async {
      var resolved = detail;
      if (resolved == null) {
        final source = ref.read(musicSourceProvider);
        if (source == null) return;
        resolved = await source.playlist(playlist.id);
      }
      for (final song in resolved.songs) {
        _tokens[song.id]?.cancel();
      }
    });
  }

  Future<void> cancelSong(Song song) async {
    _tokens[song.id]?.cancel();
  }

  Future<void> cancelAll() async {
    for (var token in _tokens.values) {
      token.cancel();
    }
  }

  Future<void> deleteAlbum(Album album) {
    return _deleteList(album.id, () async {
      final db = ref.read(databaseProvider);
      final storage = ref.read(storageProvider);
      final rows = await db.downloadsByAlbum(album.id).get();

      String? folder;
      for (final row in rows) {
        if (row.localPath == null) continue;
        folder ??= p.dirname(row.localPath!);
        await storage.deleteFile(row.localPath!);
      }

      await db.deleteDownloadsByAlbum(album.id);

      final cover = await db.albumCoverByAlbum(album.id).getSingleOrNull();
      if (cover != null) {
        folder ??= p.dirname(cover.coverPath);
        await storage.deleteFile(cover.coverPath);
        await db.deleteAlbumCover(album.id);
      }

      if (folder != null) {
        await storage.deleteFile(p.join(folder, kCoverFileName));
        await _tryDeleteEmptyDirectory(storage, folder);
        await _removeArtistDirectoryIfEmpty(storage, folder);
      }
    });
  }

  Future<void> deletePlaylist(Playlist playlist, {PlaylistDetail? detail}) {
    return _deleteList(playlist.id, () async {
      var resolved = detail;
      if (resolved == null) {
        final source = ref.read(musicSourceProvider);
        if (source == null) {
          throw StateError('No server configured.');
        }
        resolved = await source.playlist(playlist.id);
      }
      final db = ref.read(databaseProvider);
      final storage = ref.read(storageProvider);

      final rows = await db
          .songDownloadsByIds(resolved.songs.map((s) => s.id).toList())
          .get();
      for (final row in rows) {
        if (row.localPath != null) {
          await storage.deleteFile(row.localPath!);
        }
        await db.clearSongDownload(row.songId);
      }
    });
  }

  Future<void> deleteSong(Song song) async {
    final db = ref.read(databaseProvider);
    final storage = ref.read(storageProvider);

    final presence = await db.songDownloadById(song.id).getSingleOrNull();
    if (presence?.localPath != null) {
      await storage.deleteFile(presence!.localPath!);
    }
    await db.clearSongDownload(song.id);

    if (song.albumId != null) {
      final remaining = (await db.downloadsByAlbum(song.albumId!).get())
          .where((r) => r.downloadStatus == DownloadStatus.completed)
          .toList();
      if (remaining.isEmpty) {
        final cover = await db
            .albumCoverByAlbum(song.albumId!)
            .getSingleOrNull();
        if (cover != null) {
          await storage.deleteFile(cover.coverPath);
          await db.deleteAlbumCover(song.albumId!);
          final albumFolder = p.dirname(cover.coverPath);
          await _tryDeleteEmptyDirectory(storage, albumFolder);
          await _removeArtistDirectoryIfEmpty(storage, albumFolder);
        }
      }
    }
  }

  // -- internal -----------------------------------------------------------

  Future<void> _ensureCover({
    required String albumId,
    required String? coverArt,
    required String folder,
  }) async {
    if (coverArt == null) return;

    final storage = ref.read(storageProvider);
    final db = ref.read(databaseProvider);

    final relativeCover = p.join(folder, kCoverFileName);

    // Local-first: if the presence row already points at a cover file that
    // exists on disk, there is nothing to fetch. Embedding reads the same
    // local file, so it keeps working.
    final existing = await db.albumCoverByAlbum(albumId).getSingleOrNull();
    if (existing != null &&
        existing.coverPath == relativeCover &&
        await storage.exists(relativeCover)) {
      return;
    }

    final source = ref.read(musicSourceProvider);
    if (source == null) {
      throw StateError('No server configured.');
    }

    final res = await ref
        .read(dioProvider)
        .get<List<int>>(
          source.coverArtUri(coverArt).toString(),
          options: Options(responseType: ResponseType.bytes),
        );

    await storage.writeFile(relativeCover, res.data!);
    await db.upsertAlbumCover(albumId, relativeCover);
  }

  /// Resolves the download folder (and cover art id) for each distinct album
  /// in [songs].
  ///
  /// Albums that are already *partially* downloaded reuse the folder derived
  /// from an existing presence row's `local_path` (`dirname` is the album
  /// folder) — zero `getAlbum` calls for them. Everything else fetches
  /// `getAlbum` (Pool(10)); the album artist is not available from playlist
  /// entries on gonic, so the fetch cannot be replaced by entry metadata.
  Future<Map<String, _AlbumFolderInfo>> _albumFoldersFor(
    List<Song> songs,
  ) async {
    final source = ref.read(musicSourceProvider);
    if (source == null) {
      throw StateError('No server configured.');
    }
    final db = ref.read(databaseProvider);

    final albumIds = songs.map((e) => e.albumId).nonNulls.toSet();
    final result = <String, _AlbumFolderInfo>{};

    // Derive folders from existing downloads first.
    final rows = await db
        .songDownloadsByIds(songs.map((s) => s.id).toList())
        .get();
    final folderByAlbum = <String, String>{};
    for (final row in rows) {
      final localPath = row.localPath;
      if (localPath == null || row.albumId == null) continue;
      folderByAlbum.putIfAbsent(row.albumId!, () => p.dirname(localPath));
    }
    for (final entry in folderByAlbum.entries) {
      result[entry.key] = _AlbumFolderInfo(
        folder: entry.value,
        // The cover was already ensured when the album was first downloaded;
        // `_ensureCover` short-circuits on the existing file, but we have no
        // coverArt id without a `getAlbum` — so skip the fetch entirely.
        coverArt: null,
      );
    }

    final toFetch = albumIds.difference(folderByAlbum.keys.toSet());
    final pool = Pool(10, timeout: const Duration(seconds: 60));
    try {
      await pool.forEach(toFetch, (id) async {
        final detail = await source.album(id);
        result[id] = _AlbumFolderInfo(
          folder: _albumFolder(detail),
          coverArt: detail.album.coverArt,
        );
      }).drain<void>();
    } finally {
      await pool.close();
    }
    return result;
  }

  Future<List<Song>> _excludeCompleted(List<Song> songs) async {
    if (songs.isEmpty) return songs;
    final db = ref.read(databaseProvider);
    final rows = await db
        .songDownloadsByIds(songs.map((s) => s.id).toList())
        .get();
    final completed = rows
        .where((r) => r.downloadStatus == DownloadStatus.completed)
        .map((r) => r.songId)
        .toSet();
    return songs.where((s) => !completed.contains(s.id)).toList();
  }

  String _albumFolder(AlbumDetail detail) {
    return resolveAlbumFolder(
      albumArtist: detail.album.albumArtist,
      year: detail.album.year,
      albumName: detail.album.name,
      trackArtists: detail.songs.map((s) => s.artist),
    );
  }

  Future<void> _downloadSongs(
    List<Song> songs,
    Map<String, String?> folderBySong,
  ) async {
    // Mark the whole queue upfront so it's visible immediately.
    final db = ref.read(databaseProvider);
    for (final song in songs) {
      await db.setSongDownloadStatus(
        song.id,
        DownloadStatus.queued,
        albumId: song.albumId,
      );
      _setJob(song, DownloadStatus.queued, 0);
    }

    final pool = Pool(_concurrency);
    try {
      await pool.forEach(songs, (song) async {
        await _downloadSong(song, folderBySong[song.id]);
      }).drain<void>();
    } finally {
      await pool.close();
    }
  }

  Future<void> _downloadSong(Song song, String? folder) async {
    final db = ref.read(databaseProvider);
    final source = ref.read(musicSourceProvider);
    if (source == null) {
      throw StateError('No server configured.');
    }
    final storage = ref.read(storageProvider);

    final relativePath = folder == null
        ? null
        : p.join(folder, trackFileName(song.disc, song.track, song.title));

    final cancelToken = CancelToken();
    _tokens[song.id] = cancelToken;

    await db.setSongDownloadStatus(
      song.id,
      DownloadStatus.downloading,
      albumId: song.albumId,
    );
    _setJob(song, DownloadStatus.downloading, 0);

    try {
      final res = await ref
          .read(dioProvider)
          .get<ResponseBody>(
            source.streamUri(song.id).toString(),
            options: Options(responseType: ResponseType.stream),
            cancelToken: cancelToken,
            onReceiveProgress: (received, total) {
              final progress = total > 0
                  ? ((received / total) * 100).round().clamp(0, 100)
                  : 0;
              db.setSongDownloadStatus(
                song.id,
                DownloadStatus.downloading,
                albumId: song.albumId,
                progress: progress,
              );
              _setJob(song, DownloadStatus.downloading, progress);
            },
          );

      final body = res.data;
      if (body == null) {
        throw StateError('No response body for ${song.title}');
      }

      final finalPath = relativePath ?? '.tmp/${song.id}.opus';
      var bytesWritten = 0;
      await storage.writeFileStream(
        finalPath,
        body.stream.map((chunk) {
          bytesWritten += chunk.length;
          return chunk;
        }),
      );

      if (bytesWritten == 0) {
        throw StateError('Empty download for ${song.title}');
      }

      var coverEmbedded = false;
      if (ref.read(settingsServiceProvider.select((s) => s.app.embedCover))) {
        coverEmbedded = await _embedCover(song, finalPath);
      }

      await db.completeSongDownload(
        song.id,
        finalPath,
        albumId: song.albumId,
        coverEmbedded: coverEmbedded,
      );
      _setJob(song, DownloadStatus.completed, 100, localPath: finalPath);
    } on DioException catch (e) {
      if (CancelToken.isCancel(e)) {
        // A user-initiated cancel is not a real failure: map it to the
        // neutral group status (`incomplete`) instead of `error`, and reset
        // the DB row so a retry does not surface a stale failure first.
        if (relativePath != null) {
          await _tryDeleteFile(storage, relativePath);
        }
        await db.clearSongDownload(song.id);
        _setJob(song, DownloadStatus.none, 0, error: e.message);
        return;
      }
      await _failJob(song, relativePath, storage, db, e);
    } catch (e) {
      await _failJob(song, relativePath, storage, db, e);
    } finally {
      _tokens.remove(song.id);
    }
  }

  Future<void> _failJob(
    Song song,
    String? relativePath,
    LibraryStorage storage,
    SyncDatabase db,
    Object e,
  ) async {
    if (relativePath != null) {
      await _tryDeleteFile(storage, relativePath);
    }
    await db.setSongDownloadStatus(
      song.id,
      DownloadStatus.failed,
      albumId: song.albumId,
    );
    _setJob(song, DownloadStatus.failed, 0, error: e.toString());
    log.severe('Download failed for song ${song.id}', e);
  }

  Future<bool> _embedCover(Song song, String relativePath) async {
    if (!TagLibFile.isSupported) return false;

    try {
      final db = ref.read(databaseProvider);
      final storage = ref.read(storageProvider);

      final cover = song.albumId != null
          ? await db.albumCoverByAlbum(song.albumId!).getSingleOrNull()
          : null;
      if (cover == null) return false;

      final coverBytes = await storage.readFile(cover.coverPath);
      final uri = await storage.resolve(relativePath);
      if (uri == null) return false;

      // SAF roots resolve to `content://` document URIs. Open a raw file
      // descriptor from the persisted tree grant and hand it to TagLib — no
      // per-file permission prompt.
      if (uri.scheme == 'content') {
        return _embedCoverViaFd(uri, relativePath, coverBytes);
      }

      final file = await TagLibFile.openAsync(
        uri.toFilePath(),
        writeAccess: true,
      );
      if (file == null) return false;
      return _writeCover(file, coverBytes);
    } catch (e, st) {
      log.severe('Embed cover failed for song ${song.id}', e, st);
      return false;
    }
  }

  /// Embeds cover art through a SAF file descriptor opened with the persisted
  /// tree grant. The descriptor is held open for the tag write and closed
  /// afterwards; [TagLibFile.openFd] itself does not own the FD.
  Future<bool> _embedCoverViaFd(
    Uri uri,
    String relativePath,
    Uint8List coverBytes,
  ) async {
    final saf = ref.read(safProvider);
    final opened = await saf.openFileDescriptor(uri.toString(), 'rw');
    try {
      final file = TagLibFile.openFd(opened.fd, path: p.basename(relativePath));
      if (file == null) return false;
      try {
        return _writeCover(file, coverBytes);
      } finally {
        file.close();
      }
    } finally {
      try {
        await saf.closeFileDescriptor(opened.fd);
      } catch (_) {}
    }
  }

  bool _writeCover(TagLibFile file, Uint8List coverBytes) {
    file.setCover(data: coverBytes, mimeType: 'image/jpeg');
    return file.save();
  }

  Future<void> _downloadList(
    String id,
    Future<void> Function() callback,
  ) async {
    if (state.listDownloads.contains(id)) return;
    state = state.copyWith(listDownloads: state.listDownloads.add(id));

    try {
      await callback();
    } finally {
      state = state.copyWith(listDownloads: state.listDownloads.remove(id));
    }
  }

  Future<void> _cancelList(String id, Future<void> Function() callback) async {
    if (state.listCancels.contains(id)) return;
    state = state.copyWith(listCancels: state.listCancels.add(id));

    if (state.listDownloads.contains(id)) {
      var tries = 0;
      while (tries < 60 && state.listDownloads.contains(id)) {
        await Future.delayed(const Duration(milliseconds: 500));
        tries++;
      }
    }

    try {
      await callback();
    } finally {
      state = state.copyWith(listCancels: state.listCancels.remove(id));
    }
  }

  Future<void> _deleteList(String id, Future<void> Function() callback) async {
    if (state.deletes.contains(id)) return;
    state = state.copyWith(deletes: state.deletes.add(id));

    try {
      await callback();
    } finally {
      state = state.copyWith(deletes: state.deletes.remove(id));
    }
  }

  void _setJob(
    Song song,
    DownloadStatus status,
    int progress, {
    String? localPath,
    String? error,
  }) {
    final job = Download(
      songId: song.id,
      title: song.title,
      artist: song.artist,
      album: song.album,
      albumArtist: song.albumArtist,
      coverArt: song.coverArt,
      albumId: song.albumId,
      completedAt: status == DownloadStatus.completed ? DateTime.now() : null,
      progress: progress,
      status: status,
      localPath: localPath,
      error: error,
    );

    state = state.copyWith(
      downloads: state.downloads.replaceFirstWhere(
        (d) => d.songId == song.id,
        (d) => job,
        addIfNotFound: true,
      ),
    );
  }

  Future<void> _tryDeleteFile(
    LibraryStorage storage,
    String relativePath,
  ) async {
    try {
      await storage.deleteFile(relativePath);
    } catch (_) {}
  }

  Future<void> _tryDeleteEmptyDirectory(
    LibraryStorage storage,
    String relativePath,
  ) async {
    try {
      final entries = await storage.listDirectory(relativePath);
      if (entries.isEmpty) {
        await storage.deleteDirectory(relativePath);
      }
    } catch (_) {}
  }

  /// Removes the artist directory (parent of an album folder) when no files
  /// remain under it, i.e. no albums of that artist are left on device.
  Future<void> _removeArtistDirectoryIfEmpty(
    LibraryStorage storage,
    String albumFolder,
  ) async {
    final artistDir = p.dirname(albumFolder);
    if (artistDir.isEmpty || artistDir == '.' || artistDir == p.separator) {
      return;
    }
    try {
      if (!await storage.directoryContainsFiles(artistDir)) {
        await storage.deleteDirectory(artistDir);
      }
    } catch (_) {}
  }
}
