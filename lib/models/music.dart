import 'package:freezed_annotation/freezed_annotation.dart';

part 'music.freezed.dart';

@freezed
abstract class Artist with _$Artist {
  const factory Artist({
    required String id,
    required String name,
    required int albumCount,
  }) = _Artist;
}

@freezed
abstract class Album with _$Album {
  const factory Album({
    required String id,
    required String name,
    String? artistId,
    String? albumArtist,
    String? coverArt,
    int? year,
    required int songCount,
  }) = _Album;
}

@freezed
abstract class Playlist with _$Playlist {
  const factory Playlist({
    required String id,
    required String name,
    String? coverArt,
    required int songCount,
  }) = _Playlist;
}

@freezed
abstract class Song with _$Song {
  const factory Song({
    required String id,
    String? albumId,
    String? artistId,
    required String title,
    String? artist,
    String? album,
    String? albumArtist,
    int? track,
    int? disc,
    String? coverArt,
  }) = _Song;
}
