import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../database/database.dart';
import '../log.dart';
import '../models/download.dart';
import '../models/query.dart';
import '../models/remote_query.dart';
import '../state/server.dart';
import 'network/storage.dart';

part 'library_scan.g.dart';

@Riverpod(keepAlive: true)
class LibraryScanService extends _$LibraryScanService {
  @override
  bool build() => false;

  /// Walks [library_root] and verifies every downloaded file in the DB is
  /// still present. Files missing from disk are marked `removed` (rows are
  /// kept so the UI can offer re-download). Files never leave `library_root`
  /// (no export/move feature).
  Future<void> scan() async {
    if (state) return;
    state = true;

    try {
      final db = ref.read(databaseProvider);
      final storage = ref.read(storageProvider);

      if (!storage.isConfigured) return;

      final downloads = await db.allDownloads().get();
      for (final download in downloads) {
        final localPath = download.localPath;
        if (localPath == null) continue;

        if (!await storage.exists(localPath)) {
          log.info('Library scan: ${download.songId} missing on disk');
          await db.setSongDownloadStatus(download.songId,
              DownloadStatus.removed,
              albumId: download.albumId);
        }
      }

      final covers = await db.allAlbumCovers().get();
      for (final cover in covers) {
        if (!await storage.exists(cover.coverPath)) {
          await db.deleteAlbumCover(cover.albumId);
        }
      }
    } catch (e, st) {
      log.severe('Library scan failed', e, st);
    } finally {
      state = false;
    }
  }

  /// Deletes presence rows for albums that no longer exist on the server.
  ///
  /// Called on user-initiated pull-to-refresh. Builds the complete remote
  /// album id set (full `getAlbumList2` sweep) and drops `downloads` /
  /// `album_covers` rows whose album is not part of it. Files on disk are
  /// left untouched (the scan remains the filesystem reconciler) and rows
  /// with `album_id IS NULL` survive.
  Future<void> pruneStalePresence() async {
    final source = ref.read(musicSourceProvider);
    if (source == null) return;
    final db = ref.read(databaseProvider);

    // Nothing to prune when there is no presence yet — skip the full
    // `getAlbumList2` sweep entirely.
    if (await db.countDownloads().getSingle() == 0 &&
        await db.countAlbumCovers().getSingle() == 0) {
      return;
    }

    const size = 500;
    var offset = 0;
    final albumIds = <String>{};
    while (true) {
      final page = await source.albums(AlbumListRequest(
        type: AlbumListType.alphabeticalByName,
        page: Pagination(limit: size, offset: offset),
      ));
      albumIds.addAll(page.map((a) => a.id));
      offset += page.length;
      if (page.length < size) break;
    }

    await db.deleteAlbumCoversNotIn(albumIds);
    await db.deleteDownloadsNotInAlbums(albumIds);
  }
}
