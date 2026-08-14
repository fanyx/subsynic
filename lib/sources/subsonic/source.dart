import 'package:dio/dio.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:xml/xml.dart';

import '../../models/music.dart';
import '../../models/remote_query.dart';
import '../../models/settings.dart';
import '../music_source.dart';
import 'client.dart';

class SubsonicSource implements BaseMusicSource {
  final ServerSettings opt;
  final Dio dio;

  late final SubsonicClient client;

  SubsonicSource({required this.opt, required this.dio}) {
    client = SubsonicClient(opt, dio);
  }

  @override
  Future<void> ping() async {
    await client.get('ping');
  }

  @override
  Future<List<Album>> albums(AlbumListRequest request) async {
    final res = await client.get('getAlbumList2', {
      'type': request.type.name,
      'size': request.page.limit.toString(),
      'offset': request.page.offset.toString(),
      if (request.fromYear != null) 'fromYear': request.fromYear.toString(),
      if (request.toYear != null) 'toYear': request.toYear.toString(),
      if (request.genre != null) 'genre': request.genre,
      if (request.musicFolderId != null) 'musicFolderId': request.musicFolderId,
    });
    return res.xml.findAllElements('album').map(_mapAlbum).toList();
  }

  @override
  Future<List<Artist>> searchArtists(
    String query, {
    int count = 20,
    int offset = 0,
  }) async {
    final xml = await _search3(query, artistCount: count, artistOffset: offset);
    return xml.findAllElements('artist').map(_mapArtist).toList();
  }

  @override
  Future<List<Album>> searchAlbums(
    String query, {
    int count = 20,
    int offset = 0,
  }) async {
    final xml = await _search3(query, albumCount: count, albumOffset: offset);
    return xml.findAllElements('album').map(_mapAlbum).toList();
  }

  Future<XmlElement> _search3(
    String query, {
    int artistCount = 0,
    int artistOffset = 0,
    int albumCount = 0,
    int albumOffset = 0,
    int songCount = 0,
    int songOffset = 0,
  }) async {
    final res = await client.get('search3', {
      'query': query,
      'artistCount': artistCount.toString(),
      'artistOffset': artistOffset.toString(),
      'albumCount': albumCount.toString(),
      'albumOffset': albumOffset.toString(),
      'songCount': songCount.toString(),
      'songOffset': songOffset.toString(),
    });
    return res.xml;
  }

  @override
  Future<ArtistDetail> artist(String id) async {
    final res = await client.get('getArtist', {'id': id});
    return ArtistDetail(
      artist: _mapArtist(res.xml.getElement('artist')!),
      albums: res.xml.findAllElements('album').map(_mapAlbum).toIList(),
    );
  }

  @override
  Future<AlbumDetail> album(String id) async {
    final res = await client.get('getAlbum', {'id': id});
    return AlbumDetail(
      album: _mapAlbum(res.xml.getElement('album')!),
      songs: res.xml.findAllElements('song').map(_mapSong).toIList(),
    );
  }

  @override
  Future<PlaylistDetail> playlist(String id) async {
    final res = await client.get('getPlaylist', {'id': id});
    return PlaylistDetail(
      playlist: _mapPlaylist(res.xml.getElement('playlist')!),
      songs: res.xml.findAllElements('entry').map(_mapSong).toIList(),
    );
  }

  @override
  Future<List<Artist>> artists() async {
    final res = await client.get('getArtists');
    return res.xml.findAllElements('artist').map(_mapArtist).toList();
  }

  @override
  Future<List<Playlist>> playlists() async {
    final res = await client.get('getPlaylists');
    return res.xml.findAllElements('playlist').map(_mapPlaylist).toList();
  }

  // Transcode to Opus128k "only"
  // No support for other formats "yet"
  // Not really intended, if this is a personal single-purpose app
  @override
  Uri streamUri(String songId) {
    return client.uri('stream', {
      'id': songId,
      'format': 'opus',
      'maxBitRate': '128',
    });
  }

  @override
  Uri coverArtUri(String id) {
    return client.uri('getCoverArt', {'id': id, 'size': '600'});
  }

  Artist _mapArtist(XmlElement e) {
    return Artist(
      id: e.getAttribute('id')!,
      name: e.getAttribute('name') ?? 'Artist ${e.getAttribute('id')}',
      albumCount: int.tryParse(e.getAttribute('albumCount') ?? '') ?? 0,
    );
  }

  Album _mapAlbum(XmlElement e) {
    return Album(
      id: e.getAttribute('id')!,
      artistId: e.getAttribute('artistId'),
      name:
          e.getAttribute('name') ??
          e.getAttribute('title') ??
          'Album ${e.getAttribute('id')}',
      albumArtist: e.getAttribute('artist'),
      coverArt: e.getAttribute('coverArt'),
      year: e.getAttribute('year') != null
          ? int.tryParse(e.getAttribute('year')!)
          : null,
      songCount: int.tryParse(e.getAttribute('songCount') ?? '') ?? 0,
    );
  }

  Playlist _mapPlaylist(XmlElement e) {
    return Playlist(
      id: e.getAttribute('id')!,
      name: e.getAttribute('name') ?? 'Playlist ${e.getAttribute('id')}',
      coverArt: e.getAttribute('coverArt'),
      songCount: int.tryParse(e.getAttribute('songCount') ?? '') ?? 0,
    );
  }

  Song _mapSong(XmlElement e) {
    return Song(
      id: e.getAttribute('id')!,
      albumId: e.getAttribute('albumId'),
      artistId: e.getAttribute('artistId'),
      title: e.getAttribute('title') ?? 'Song ${e.getAttribute('id')}',
      album: e.getAttribute('album'),
      artist: e.getAttribute('artist'),
      albumArtist: e.getAttribute('albumArtist'),
      track: e.getAttribute('track') != null
          ? int.tryParse(e.getAttribute('track')!)
          : null,
      disc: e.getAttribute('discNumber') != null
          ? int.tryParse(e.getAttribute('discNumber')!)
          : null,
      coverArt: e.getAttribute('coverArt'),
    );
  }
}
