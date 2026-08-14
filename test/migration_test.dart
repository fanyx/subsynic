import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:subsynic/database/database.dart';
import 'package:subsynic/models/download.dart';

void _seedV1(Database db) {
  db.execute('PRAGMA user_version = 1');
  db.execute(
    'CREATE TABLE server(id INT NOT NULL PRIMARY KEY, address TEXT NOT NULL, '
    'username TEXT NOT NULL, password TEXT NOT NULL, '
    'use_token_auth BOOLEAN NOT NULL DEFAULT 1, features TEXT NOT NULL)',
  );
  db.execute(
    'CREATE TABLE app_settings(id INT NOT NULL PRIMARY KEY, '
    'library_root_uri TEXT, embed_cover BOOLEAN NOT NULL DEFAULT 0)',
  );
  db.execute(
    'CREATE TABLE last_library_state(id INT NOT NULL PRIMARY KEY, '
    'tab TEXT NOT NULL, albums_list TEXT NOT NULL, artists_list TEXT NOT NULL, '
    'playlists_list TEXT NOT NULL, songs_list TEXT NOT NULL)',
  );
  db.execute(
    'CREATE TABLE artists(id TEXT NOT NULL PRIMARY KEY, name TEXT NOT NULL, '
    'album_count INT NOT NULL, starred DATETIME, '
    'updated DATETIME NOT NULL DEFAULT (strftime(\'%s\', CURRENT_TIMESTAMP)))',
  );
  db.execute('CREATE TABLE artists_fts(name)');
  db.execute('CREATE TABLE albums(id TEXT NOT NULL PRIMARY KEY, cover_path TEXT)');
  db.execute('CREATE TABLE albums_fts(name)');
  db.execute('CREATE TABLE playlists(id TEXT NOT NULL PRIMARY KEY, name TEXT NOT NULL)');
  db.execute('CREATE TABLE playlists_fts(name)');
  db.execute(
    'CREATE TABLE playlist_songs(playlist_id TEXT NOT NULL, '
    'song_id TEXT NOT NULL, position INT NOT NULL)',
  );
  db.execute(
    'CREATE TABLE songs('
    'id TEXT NOT NULL PRIMARY KEY, '
    'album_id TEXT, artist_id TEXT, title TEXT NOT NULL, album TEXT, '
    'artist TEXT, duration INT, track INT, disc INT, starred DATETIME, '
    'genre TEXT, is_deleted BOOLEAN NOT NULL DEFAULT 0, '
    'updated DATETIME NOT NULL DEFAULT (strftime(\'%s\', CURRENT_TIMESTAMP)), '
    'local_path TEXT, '
    'download_status TEXT NOT NULL DEFAULT \'none\', '
    'download_progress INT NOT NULL DEFAULT 0, '
    'cover_embedded BOOLEAN NOT NULL DEFAULT 0)',
  );
  db.execute('CREATE TABLE songs_fts(title)');
}

void main() {
  test('v1 -> v2 seeds presence and drops metadata tables', () async {
    final sqlite = sqlite3.openInMemory();
    _seedV1(sqlite);

    sqlite.execute(
      "INSERT INTO songs(id, title, album_id, local_path, download_status) VALUES "
      "('s1', 'Song 1', 'a1', 'Artist/Album/01 - Song.opus', 'completed'), "
      "('s2', 'Song 2', 'a1', NULL, 'none')",
    );
    sqlite.execute(
      "INSERT INTO albums(id, cover_path) VALUES "
      "('a1', 'Artist/Album/cover.jpg')",
    );

    final db = SyncDatabase.connection(NativeDatabase.opened(sqlite));
    // First query triggers the migration.
    await db.getServer().getSingleOrNull();

    // Downloaded song migrated with album + status.
    final s1 = (await db.songDownloadById('s1').getSingle());
    expect(s1.localPath, 'Artist/Album/01 - Song.opus');
    expect(s1.albumId, 'a1');
    expect(s1.downloadStatus, DownloadStatus.completed);

    // Song without a local file is not migrated.
    expect(await db.songDownloadById('s2').getSingleOrNull(), isNull);

    // Album cover migrated.
    final cover = (await db.albumCoverByAlbum('a1').getSingleOrNull())!;
    expect(cover.coverPath, 'Artist/Album/cover.jpg');

    // Metadata tables gone.
    final count = await db.customSelect('SELECT COUNT(*) AS c FROM sqlite_master '
            "WHERE type='table' AND name IN "
            "('songs','albums','artists','playlists','playlist_songs','songs_fts','albums_fts','artists_fts','playlists_fts')")
        .map((r) => r.read<int>('c'))
        .getSingle();
    expect(count, 0);

    // Presence tables exist and are queryable.
    expect(await db.downloadCountsByAlbum().get(), hasLength(1));

    // v3 dropped the unused `features` column (S-1).
    final serverCols = await db
        .customSelect("SELECT name FROM pragma_table_info('server')")
        .map((r) => r.read<String>('name'))
        .get();
    expect(serverCols, isNot(contains('features')));

    await db.close();
  });
}
