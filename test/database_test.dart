import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:subsynic/database/database.dart';
import 'package:subsynic/models/download.dart';

void main() {
  late SyncDatabase db;

  setUp(() {
    db = SyncDatabase.connection(NativeDatabase.memory());
  });

  tearDown(() async {
    await db.close();
  });

  group('presence CRUD', () {
    test('upsert + status transitions', () async {
      await db.setSongDownloadStatus('s1', DownloadStatus.queued,
          albumId: 'a1');
      await db.setSongDownloadStatus('s1', DownloadStatus.downloading,
          albumId: 'a1', progress: 50);

      final row = (await db.songDownloadById('s1').getSingle());
      expect(row.albumId, 'a1');
      expect(row.downloadStatus, DownloadStatus.downloading);
      expect(row.downloadProgress, 50);

      await db.completeSongDownload('s1', 'Artist/Album/01 - Song.opus',
          albumId: 'a1', coverEmbedded: true);
      final done = (await db.songDownloadById('s1').getSingle());
      expect(done.downloadStatus, DownloadStatus.completed);
      expect(done.localPath, 'Artist/Album/01 - Song.opus');
      expect(done.downloadProgress, 100);
      expect(done.coverEmbedded, isTrue);
    });

    test('clearSongDownload removes the row', () async {
      await db.completeSongDownload('s1', 'p.opus', albumId: 'a1');
      await db.clearSongDownload('s1');

      expect(await db.songDownloadById('s1').getSingleOrNull(), isNull);
    });

    test('removeSongDownload marks removed but keeps the row', () async {
      await db.completeSongDownload('s1', 'p.opus', albumId: 'a1');
      await db.removeSongDownload('s1');

      final row = (await db.songDownloadById('s1').getSingle());
      expect(row.downloadStatus, DownloadStatus.removed);
      expect(row.localPath, 'p.opus');
    });

    test('downloadsByAlbum groups by album', () async {
      await db.completeSongDownload('s1', 'p1.opus', albumId: 'a1');
      await db.completeSongDownload('s2', 'p2.opus', albumId: 'a1');
      await db.completeSongDownload('s3', 'p3.opus', albumId: 'a2');

      final rows = await db.downloadsByAlbum('a1').get();
      expect(rows.map((r) => r.songId), ['s1', 's2']);
    });

    test('deleteDownloadsByAlbum removes only that album', () async {
      await db.completeSongDownload('s1', 'p1.opus', albumId: 'a1');
      await db.completeSongDownload('s2', 'p2.opus', albumId: 'a2');

      await db.deleteDownloadsByAlbum('a1');

      expect(await db.songDownloadById('s1').getSingleOrNull(), isNull);
      expect(await db.songDownloadById('s2').getSingleOrNull(), isNotNull);
    });
  });

  group('album covers', () {
    test('upsert + delete', () async {
      await db.upsertAlbumCover('a1', 'Artist/Album/cover.jpg');
      final row = (await db.albumCoverByAlbum('a1').getSingleOrNull())!;
      expect(row.coverPath, 'Artist/Album/cover.jpg');

      await db.deleteAlbumCover('a1');
      expect(await db.albumCoverByAlbum('a1').getSingleOrNull(), isNull);
    });
  });

  group('downloadCountsByAlbum', () {
    test('groups completed vs downloading per album', () async {
      await db.setSongDownloadStatus('s1', DownloadStatus.completed,
          albumId: 'a1');
      await db.setSongDownloadStatus('s2', DownloadStatus.downloading,
          albumId: 'a1', progress: 30);
      await db.setSongDownloadStatus('s3', DownloadStatus.queued,
          albumId: 'a1');
      await db.setSongDownloadStatus('s4', DownloadStatus.completed,
          albumId: 'a2');
      await db.setSongDownloadStatus('s5', DownloadStatus.failed,
          albumId: 'a1');

      final rows = await db.downloadCountsByAlbum().get();
      final a1 = rows.singleWhere((r) => r.albumId == 'a1');
      final a2 = rows.singleWhere((r) => r.albumId == 'a2');

      expect(a1.downloaded, 1);
      expect(a1.downloading, 2);
      expect(a2.downloaded, 1);
      expect(a2.downloading, 0);
    });

    test('skips rows without an album', () async {
      await db.completeSongDownload('s1', 'p1.opus');
      final rows = await db.downloadCountsByAlbum().get();
      expect(rows, isEmpty);
    });
  });

  group('prune helpers', () {
    test('deleteDownloadsNotInAlbums keeps null-album rows', () async {
      await db.completeSongDownload('s1', 'p1.opus', albumId: 'a1');
      await db.completeSongDownload('s2', 'p2.opus', albumId: 'a2');
      await db.completeSongDownload('s3', 'p3.opus');

      await db.deleteDownloadsNotInAlbums(['a1']);

      expect(await db.songDownloadById('s1').getSingleOrNull(), isNotNull);
      expect(await db.songDownloadById('s2').getSingleOrNull(), isNull);
      expect(await db.songDownloadById('s3').getSingleOrNull(), isNotNull);
    });

    test('deleteAlbumCoversNotIn prunes unseen albums', () async {
      await db.upsertAlbumCover('a1', 'c1.jpg');
      await db.upsertAlbumCover('a2', 'c2.jpg');

      await db.deleteAlbumCoversNotIn(['a1']);

      expect(await db.albumCoverByAlbum('a1').getSingleOrNull(), isNotNull);
      expect(await db.albumCoverByAlbum('a2').getSingleOrNull(), isNull);
    });
  });
}
