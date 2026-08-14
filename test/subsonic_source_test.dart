import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:subsynic/models/query.dart';
import 'package:subsynic/models/remote_query.dart';
import 'package:subsynic/models/settings.dart';
import 'package:subsynic/sources/subsonic/source.dart';

const _ok = 'status="ok" version="1.13.0"';

String _wrap(String body) =>
    '<subsonic-response $_ok>$body</subsonic-response>';

final _albumListXml = _wrap('''
<albumList2>
  <album id="a1" name="Alpha" artist="Artist A" artistId="ar1" coverArt="cov1" songCount="3" created="2020-01-01T00:00:00Z" year="2010"/>
  <album id="a2" name="Beta" artist="Artist B" songCount="2" created="2021-01-01T00:00:00Z"/>
</albumList2>''');

final _searchXml = _wrap('''
<searchResult3>
  <artist id="ar1" name="Artist A" albumCount="1"/>
  <album id="a1" name="Alpha" artist="Artist A" coverArt="cov1" songCount="3" created="2020-01-01T00:00:00Z"/>
  <song id="s1" title="Song 1" albumId="a1" artistId="ar1" artist="Artist A" album="Alpha" coverArt="cov1" duration="180"/>
</searchResult3>''');

final _albumXml = _wrap('''
<album id="a1" name="Alpha" artist="Artist A" artistId="ar1" coverArt="cov1" songCount="1" created="2020-01-01T00:00:00Z">
  <song id="s1" title="Song 1" albumId="a1" artistId="ar1" artist="Artist A" album="Alpha" coverArt="cov1" duration="180" track="1" discNumber="1"/>
</album>''');

final _playlistXml = _wrap('''
<playlist id="p1" name="Mix" comment="c" coverArt="covp" songCount="2" created="2020-01-01T00:00:00Z">
  <entry id="s1" title="Song 1" albumId="a1" artist="Artist A" album="Alpha" coverArt="cov1" duration="180"/>
  <entry id="s2" title="Song 2" albumId="a1" artist="Artist A" album="Alpha" duration="200"/>
</playlist>''');

final _artistXml = _wrap('''
<artist id="ar1" name="Artist A" albumCount="1">
  <album id="a1" name="Alpha" coverArt="cov1" songCount="3" created="2020-01-01T00:00:00Z"/>
</artist>''');

final _artistsXml = _wrap('''
<artists>
  <index name="A">
    <artist id="ar1" name="Artist A" albumCount="1"/>
  </index>
</artists>''');

final _playlistsXml = _wrap('''
<playlists>
  <playlist id="p1" name="Mix" songCount="2" created="2020-01-01T00:00:00Z"/>
</playlists>''');

class _RecordingAdapter implements HttpClientAdapter {
  final List<String> requests = [];
  String Function(String path)? responder;

  @override
  Future<ResponseBody> fetch(RequestOptions options,
      Stream<Uint8List>? requestStream, Future<void>? cancelFuture) async {
    requests.add(options.path);
    final xml = responder?.call(options.path) ??
        '<subsonic-response $_ok></subsonic-response>';
    return ResponseBody.fromString(
      xml,
      200,
      headers: {Headers.contentTypeHeader: ['application/xml']},
    );
  }

  @override
  void close({bool force = false}) {}
}

ServerSettings _settings() => ServerSettings(
      address: Uri.parse('https://server.example/sub'),
      username: 'alice',
      password: 'secret',
    );

void main() {
  late _RecordingAdapter adapter;
  late SubsonicSource source;

  setUp(() {
    adapter = _RecordingAdapter();
    source = SubsonicSource(
      opt: _settings(),
      dio: Dio()..httpClientAdapter = adapter,
    );
  });

  Map<String, String> paramsOf(int index) {
    final uri = Uri.parse(adapter.requests[index]);
    return uri.queryParameters;
  }

  group('albums (getAlbumList2)', () {
    test('encodes type/size/offset and maps DTOs', () async {
      adapter.responder = (_) => _albumListXml;
      final albums = await source.albums(const AlbumListRequest(
        type: AlbumListType.alphabeticalByName,
        page: Pagination(limit: 60, offset: 120),
      ));

      final params = paramsOf(0);
      expect(params['type'], 'alphabeticalByName');
      expect(params['size'], '60');
      expect(params['offset'], '120');

      expect(albums, hasLength(2));
      expect(albums.first.id, 'a1');
      expect(albums.first.name, 'Alpha');
      expect(albums.first.albumArtist, 'Artist A');
      expect(albums.first.coverArt, 'cov1');
      expect(albums.first.songCount, 3);
      expect(albums.first.year, 2010);
      expect(albums[1].coverArt, isNull);
    });

    test('byYear emits fromYear/toYear', () async {
      adapter.responder = (_) => _albumListXml;
      await source.albums(const AlbumListRequest(
        type: AlbumListType.byYear,
        page: Pagination(limit: 60, offset: 0),
        fromYear: 1,
        toYear: 9999,
      ));

      final params = paramsOf(0);
      expect(params['type'], 'byYear');
      expect(params['fromYear'], '1');
      expect(params['toYear'], '9999');
    });
  });

  group('search3', () {
    test('searchAlbums encodes albumCount/albumOffset', () async {
      adapter.responder = (_) => _searchXml;
      final albums =
          await source.searchAlbums('beat', count: 20, offset: 40);

      final params = paramsOf(0);
      expect(params['query'], 'beat');
      expect(params['albumCount'], '20');
      expect(params['albumOffset'], '40');
      expect(params['songCount'], '0');
      expect(params['artistCount'], '0');
      expect(albums.single.id, 'a1');
    });

    test('searchArtists encodes artist counts', () async {
      adapter.responder = (_) => _searchXml;
      final artists =
          await source.searchArtists('beat', count: 10, offset: 10);

      final params = paramsOf(0);
      expect(params['artistCount'], '10');
      expect(params['artistOffset'], '10');
      expect(artists.single.id, 'ar1');
    });
  });

  group('details', () {
    test('album maps album + songs with coverArt', () async {
      adapter.responder = (_) => _albumXml;
      final detail = await source.album('a1');

      final params = paramsOf(0);
      expect(params['id'], 'a1');

      expect(detail.album.id, 'a1');
      expect(detail.songs.single.id, 's1');
      expect(detail.songs.single.coverArt, 'cov1');
    });

    test('playlist entries map to songs with coverArt', () async {
      adapter.responder = (_) => _playlistXml;
      final detail = await source.playlist('p1');

      expect(detail.playlist.name, 'Mix');
      expect(detail.playlist.songCount, 2);
      expect(detail.songs, hasLength(2));
      expect(detail.songs.first.coverArt, 'cov1');
      expect(detail.songs[1].coverArt, isNull);
    });

    test('artist maps artist + albums', () async {
      adapter.responder = (_) => _artistXml;
      final detail = await source.artist('ar1');

      expect(detail.artist.name, 'Artist A');
      expect(detail.artist.albumCount, 1);
      expect(detail.albums.single.id, 'a1');
      expect(detail.albums.single.coverArt, 'cov1');
    });
  });

  group('one-shot lists', () {
    test('artists maps the whole response', () async {
      adapter.responder = (_) => _artistsXml;
      final artists = await source.artists();
      expect(artists.single.id, 'ar1');
      expect(artists.single.name, 'Artist A');
    });

    test('playlists maps the whole response', () async {
      adapter.responder = (_) => _playlistsXml;
      final playlists = await source.playlists();
      expect(playlists.single.name, 'Mix');
    });
  });
}
