import 'dart:io';

import 'package:collection/collection.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../log.dart';
import '../models/download.dart';
import '../models/query.dart';
import '../models/settings.dart';
import 'converters.dart';
import 'error_logging_database.dart';

part 'database.g.dart';

// don't exceed SQLITE_MAX_VARIABLE_NUMBER (32766 for version >= 3.32.0)
// https://www.sqlite.org/limits.html
const kSqliteMaxVariableNumber = 32766;

@DriftDatabase(include: {'tables.drift'})
class SyncDatabase extends _$SyncDatabase {
  SyncDatabase() : super(_openConnection());
  SyncDatabase.connection(super.e);

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      beforeOpen: (details) async {
        await customStatement('PRAGMA foreign_keys = ON');
      },
      onUpgrade: (m, from, to) async {
        if (from < 2) {
          await m.createTable(downloads);
          await m.createTable(albumCovers);
          await m.database.customStatement(
            'INSERT INTO downloads(song_id, album_id, local_path, '
            'download_status, download_progress, cover_embedded) '
            'SELECT id, album_id, local_path, download_status, '
            'download_progress, cover_embedded FROM songs '
            'WHERE local_path IS NOT NULL',
          );
          await m.database.customStatement(
            'INSERT INTO album_covers(album_id, cover_path) '
            'SELECT id, cover_path FROM albums WHERE cover_path IS NOT NULL',
          );
          await m.deleteTable('songs');
          await m.deleteTable('songs_fts');
          await m.deleteTable('albums');
          await m.deleteTable('albums_fts');
          await m.deleteTable('artists');
          await m.deleteTable('artists_fts');
          await m.deleteTable('playlists');
          await m.deleteTable('playlists_fts');
          await m.deleteTable('playlist_songs');
        }
        if (from < 3) {
          // The `emptyQuerySearch` feature probe was dropped; nothing reads
          // the column anymore.
          await m.database.customStatement(
            'ALTER TABLE server DROP COLUMN features',
          );
        }
      },
    );
  }

  /// Runs a database operation in a background isolate.
  ///
  /// **Only pass top-level functions to [computation]!**
  ///
  /// **Do not use non-serializable data inside [computation]!**
  Future<Ret> background<Ret>(
    FutureOr<Ret> Function(SyncDatabase) computation,
  ) async {
    return computeWithDatabase(
      connect: SyncDatabase.connection,
      computation: computation,
    );
  }

  Future<void> saveServer(ServerCompanion server) async {
    await into(this.server).insertOnConflictUpdate(server);
  }

  Future<void> updateSettings(AppSettingsCompanion settings) async {
    await into(appSettings).insertOnConflictUpdate(settings);
  }

  Selectable<LastLibraryStateData> getLastLibraryState() {
    return select(lastLibraryState)..where((tbl) => tbl.id.equals(1));
  }

  Future<void> saveLastLibraryState(LastLibraryStateData update) {
    return into(lastLibraryState).insertOnConflictUpdate(update);
  }

  Future<void> upsertSongDownload(SongDownload d) async {
    await into(downloads).insertOnConflictUpdate(
      DownloadsCompanion(
        songId: Value(d.songId),
        albumId: Value(d.albumId),
        localPath: Value(d.localPath),
        downloadStatus: Value(d.downloadStatus),
        downloadProgress: Value(d.downloadProgress),
        coverEmbedded: Value(d.coverEmbedded),
      ),
    );
  }

  Future<void> setSongDownloadStatus(String id, DownloadStatus status,
      {String? albumId, int progress = 0}) async {
    await into(downloads).insertOnConflictUpdate(
      DownloadsCompanion(
        songId: Value(id),
        albumId: Value(albumId),
        downloadStatus: Value(status),
        downloadProgress: Value(progress),
      ),
    );
  }

  Future<void> completeSongDownload(String id, String localPath,
      {String? albumId, bool coverEmbedded = false}) async {
    await into(downloads).insertOnConflictUpdate(
      DownloadsCompanion(
        songId: Value(id),
        albumId: Value(albumId),
        localPath: Value(localPath),
        downloadStatus: Value(DownloadStatus.completed),
        downloadProgress: Value(100),
        coverEmbedded: Value(coverEmbedded),
      ),
    );
  }

  Future<void> clearSongDownload(String id) async {
    await (delete(downloads)..where((tbl) => tbl.songId.equals(id))).go();
  }

  Future<void> removeSongDownload(String id) async {
    await (update(downloads)..where((tbl) => tbl.songId.equals(id))).write(
      const DownloadsCompanion(downloadStatus: Value(DownloadStatus.removed)),
    );
  }

  Future<void> deleteDownloadsByAlbum(String albumId) async {
    await (delete(downloads)..where((tbl) => tbl.albumId.equals(albumId))).go();
  }

  Future<void> upsertAlbumCover(String albumId, String coverPath) async {
    await into(albumCovers).insertOnConflictUpdate(
      AlbumCoversCompanion(
        albumId: Value(albumId),
        coverPath: Value(coverPath),
      ),
    );
  }

  Future<void> deleteAlbumCover(String albumId) async {
    await (delete(albumCovers)..where((tbl) => tbl.albumId.equals(albumId)))
        .go();
  }

  Future<void> deleteDownloadsNotInAlbums(Iterable<String> albumIds) async {
    final ids = albumIds.toSet();
    if (ids.isEmpty) {
      await (delete(downloads)..where((tbl) => tbl.albumId.isNotNull())).go();
      return;
    }

    final query = delete(downloads)..where((tbl) => tbl.albumId.isNotNull());
    for (final slice in ids.slices(kSqliteMaxVariableNumber)) {
      query.where((tbl) => tbl.albumId.isNotIn(slice.toList()));
    }
    await query.go();
  }

  Future<void> deleteAlbumCoversNotIn(Iterable<String> albumIds) async {
    final ids = albumIds.toSet();
    if (ids.isEmpty) {
      await delete(albumCovers).go();
      return;
    }

    final query = delete(albumCovers);
    for (final slice in ids.slices(kSqliteMaxVariableNumber)) {
      query.where((tbl) => tbl.albumId.isNotIn(slice.toList()));
    }
    await query.go();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'subsynic.sqlite'));

    return ErrorLoggingDatabase(
      NativeDatabase.createInBackground(file),
      (e, s) => log.severe('SQL error', e, s),
    );
  });
}

@Riverpod(keepAlive: true)
SyncDatabase database(Ref ref) {
  return SyncDatabase();
}
