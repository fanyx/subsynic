import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../log.dart';
import '../services/library_scan.dart';
import '../services/network/client.dart';
import '../services/settings.dart';
import '../sources/music_source.dart';
import '../sources/subsonic/source.dart';
import 'remote_library.dart';

part 'server.g.dart';

@Riverpod(keepAlive: true)
BaseMusicSource? musicSource(Ref ref) {
  final settings = ref.watch(
    settingsServiceProvider.select((value) => value.server),
  );
  if (settings == null) return null;

  return SubsonicSource(opt: settings, dio: ref.watch(dioProvider));
}

@Riverpod(keepAlive: true)
class LibraryRefresh extends _$LibraryRefresh {
  @override
  DateTime build() => DateTime.now();

  Future<void> refresh() async {
    ref.invalidate(allArtistsProvider);
    ref.invalidate(allPlaylistsProvider);
    // Invalidate the whole `remoteAlbumList` family (riverpod >= 3.0) so the
    // Albums tab refetches instead of re-reading its cached pages.
    ref.invalidate(remoteAlbumListProvider);
    ref.read(artistArtIndexProvider.notifier).clear();
    ref.read(artistBadgeIndexProvider.notifier).clear();
    ref.read(playlistDetailMemoProvider.notifier).clear();
    try {
      await ref.read(libraryScanServiceProvider.notifier).pruneStalePresence();
    } catch (e, st) {
      log.severe('Presence prune failed', e, st);
    }
    state = DateTime.now();
  }
}

@Riverpod(keepAlive: true)
String coverCacheBuster(Ref ref) {
  final server = ref.watch(settingsServiceProvider.select((s) => s.server));
  if (server == null) return 'none';
  return md5.convert(utf8.encode('${server.address}|${server.username}')).toString();
}
