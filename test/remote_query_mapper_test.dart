import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:subsynic/models/music.dart';
import 'package:subsynic/models/query.dart';
import 'package:subsynic/models/remote_query.dart';
import 'package:subsynic/services/remote_query_mapper.dart';

void main() {
  group('mapAlbumsQuery', () {
    test('defaults to alphabeticalByName', () {
      final request = mapAlbumsQuery(const ListQuery());
      expect(request.type, AlbumListType.alphabeticalByName);
      expect(request.page.offset, 0);
    });

    test('maps name -> alphabeticalByName', () {
      final request = mapAlbumsQuery(
        const ListQuery(sort: SortBy(column: 'albums.name')),
      );
      expect(request.type, AlbumListType.alphabeticalByName);
    });

    test('maps year -> byYear with broad range', () {
      final request = mapAlbumsQuery(
        const ListQuery(sort: SortBy(column: 'albums.year')),
      );
      expect(request.type, AlbumListType.byYear);
      expect(request.fromYear, 1);
      expect(request.toYear, 9999);
    });

    test('maps album_artist -> alphabeticalByArtist', () {
      final request = mapAlbumsQuery(
        const ListQuery(sort: SortBy(column: 'albums.album_artist')),
      );
      expect(request.type, AlbumListType.alphabeticalByArtist);
    });

    test('year filter maps to byYear regardless of sort', () {
      final request = mapAlbumsQuery(const ListQuery(
        sort: SortBy(column: 'albums.name'),
        filters: IListConst([
          FilterWith.isNull(column: 'albums.year', invert: true),
        ]),
      ));
      expect(request.type, AlbumListType.byYear);
      expect(request.fromYear, 1);
      expect(request.toYear, 9999);
    });

    test('dropped filters (genre / album_artist is-null) are ignored', () {
      final request = mapAlbumsQuery(const ListQuery(
        sort: SortBy(column: 'albums.name'),
        filters: IListConst([
          FilterWith.isNull(column: 'albums.genre', invert: true),
          FilterWith.isNull(column: 'albums.album_artist', invert: true),
        ]),
      ));
      expect(request.type, AlbumListType.alphabeticalByName);
      expect(request.genre, isNull);
    });

    test('carries page limit/offset', () {
      final request = mapAlbumsQuery(const ListQuery(
        page: Pagination(limit: 60, offset: 60),
      ));
      expect(request.page.limit, 60);
      expect(request.page.offset, 60);
    });
  });

  group('mapArtistsQuery', () {
    final artists = [
      Artist(id: 'b', name: 'Beta', albumCount: 5),
      Artist(id: 'a', name: 'Alpha', albumCount: 2),
      Artist(id: 'c', name: 'Gamma', albumCount: 8),
    ];

    test('sorts by name asc by default', () {
      final sorted = mapArtistsQuery(
        artists,
        const ListQuery(sort: SortBy(column: 'artists.name')),
      );
      expect(sorted.map((a) => a.id), ['a', 'b', 'c']);
    });

    test('sorts by name desc', () {
      final sorted = mapArtistsQuery(
        artists,
        const ListQuery(
          sort: SortBy(column: 'artists.name', dir: SortDirection.desc),
        ),
      );
      expect(sorted.map((a) => a.id), ['c', 'b', 'a']);
    });

    test('sorts by album count', () {
      final sorted = mapArtistsQuery(
        artists,
        const ListQuery(sort: SortBy(column: 'artists.album_count')),
      );
      expect(sorted.map((a) => a.id), ['a', 'b', 'c']);
    });

    test('does not mutate the input list', () {
      final copy = List.of(artists);
      mapArtistsQuery(
        artists,
        const ListQuery(sort: SortBy(column: 'artists.name')),
      );
      expect(artists.map((a) => a.id), copy.map((a) => a.id));
    });
  });

  group('mapPlaylistsQuery', () {
    final playlists = [
      Playlist(id: 'p2', name: 'Beats', songCount: 1),
      Playlist(id: 'p1', name: 'Atmospheric', songCount: 1),
    ];

    test('sorts by name', () {
      final sorted = mapPlaylistsQuery(
        playlists,
        const ListQuery(sort: SortBy(column: 'playlists.name')),
      );
      expect(sorted.map((p) => p.id), ['p1', 'p2']);
    });
  });

  group('filterPlaylistsBySearch', () {
    test('substring match is case-insensitive', () {
      final all = [
        Playlist(id: 'p1', name: 'Morning Mix', songCount: 1),
        Playlist(id: 'p2', name: 'Road Trip', songCount: 1),
      ];
      final hits = filterPlaylistsBySearch(all, 'morning');
      expect(hits.map((p) => p.id), ['p1']);
    });
  });

  group('slice', () {
    final all = List.generate(100, (i) => 'item$i');

    test('returns the window for a page', () {
      final page = slice(all, const Pagination(limit: 30, offset: 60));
      expect(page.length, 30);
      expect(page.first, 'item60');
    });

    test('returns empty past the end', () {
      final page = slice(all, const Pagination(limit: 30, offset: 300));
      expect(page, isEmpty);
    });

    test('returns a partial final page', () {
      final page = slice(all, const Pagination(limit: 60, offset: 90));
      expect(page.length, 10);
    });

    test('returns all when limit <= 0', () {
      expect(slice(all, const Pagination(limit: -1)), hasLength(100));
    });
  });
}
