import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:subsynic/app/items.dart';
import 'package:subsynic/app/pages/library_albums_page.dart';
import 'package:subsynic/database/database.dart';
import 'package:subsynic/models/music.dart';
import 'package:subsynic/models/remote_query.dart';
import 'package:subsynic/sources/music_source.dart';
import 'package:subsynic/state/server.dart';

class _FakeSource implements BaseMusicSource {
  int albumsCalls = 0;

  @override
  Future<List<Album>> albums(AlbumListRequest request) async {
    albumsCalls++;
    final start = request.page.offset;
    final end = (start + request.page.limit).clamp(0, 100);
    return [
      for (var i = start; i < end; i++)
        Album(
          id: 'a$i',
          name: 'Album ${i.toString().padLeft(3, '0')}',
          songCount: 1,
        ),
    ];
  }

  @override
  Future<void> ping() async {}

  @override
  Future<List<Album>> searchAlbums(String query,
          {int count = 20, int offset = 0}) async =>
      const [];

  @override
  Future<List<Artist>> searchArtists(String query,
          {int count = 20, int offset = 0}) async =>
      const [];

  @override
  Future<ArtistDetail> artist(String id) async =>
      throw UnimplementedError();

  @override
  Future<AlbumDetail> album(String id) async => throw UnimplementedError();

  @override
  Future<PlaylistDetail> playlist(String id) async =>
      throw UnimplementedError();

  @override
  Future<List<Artist>> artists() async => throw UnimplementedError();

  @override
  Future<List<Playlist>> playlists() async => throw UnimplementedError();

  @override
  Uri streamUri(String songId) => Uri.parse('https://x/stream?id=$songId');

  @override
  Uri coverArtUri(String coverArtId) => Uri.parse('https://x/cover?id=$coverArtId');
}

void main() {
  testWidgets('albums grid loads pages incrementally from the remote',
      (tester) async {
    final db = SyncDatabase.connection(NativeDatabase.memory());
    final source = _FakeSource();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          databaseProvider.overrideWithValue(db),
          musicSourceProvider.overrideWithValue(source),
        ],
        child: const MaterialApp(
          home: Scaffold(body: LibraryAlbumsPage()),
        ),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    // Not all 100 albums render at once.
    final initiallyBuilt = find.byType(AlbumCard).evaluate().length;
    expect(initiallyBuilt, lessThan(100));

    // Scrolling keeps growing the grid (incremental page fetches).
    var totalSeen = initiallyBuilt;
    for (var i = 0; i < 20; i++) {
      await tester.drag(find.byType(Scrollable).first,
          const Offset(0, -1200));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      final now = find.byType(AlbumCard).evaluate().length;
      expect(now, lessThan(100));
      if (now > totalSeen) totalSeen = now;
    }
    expect(totalSeen, greaterThan(initiallyBuilt));
    expect(source.albumsCalls, greaterThanOrEqualTo(2));

    await db.close();
  });
}
