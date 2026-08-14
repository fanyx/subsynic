import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'music.dart';
import 'query.dart';

part 'remote_query.freezed.dart';

enum AlbumListType {
  random,
  frequent,
  recent,
  alphabeticalByName,
  alphabeticalByArtist,
  byYear,
  byGenre,
}

@freezed
abstract class AlbumListRequest with _$AlbumListRequest {
  const factory AlbumListRequest({
    required AlbumListType type,
    @Default(Pagination(limit: 60)) Pagination page,
    int? fromYear,
    int? toYear,
    String? genre,
    String? musicFolderId,
  }) = _AlbumListRequest;
}

@freezed
abstract class ArtistDetail with _$ArtistDetail {
  const factory ArtistDetail({
    required Artist artist,
    required IList<Album> albums,
  }) = _ArtistDetail;
}

@freezed
abstract class AlbumDetail with _$AlbumDetail {
  const factory AlbumDetail({
    required Album album,
    required IList<Song> songs,
  }) = _AlbumDetail;
}

@freezed
abstract class PlaylistDetail with _$PlaylistDetail {
  const factory PlaylistDetail({
    required Playlist playlist,
    required IList<Song> songs,
  }) = _PlaylistDetail;
}
