import '../models/music.dart';
import '../models/remote_query.dart';

abstract class BaseMusicSource {
  Future<void> ping();

  Future<List<Album>> albums(AlbumListRequest request);
  Future<List<Artist>> searchArtists(String query,
      {int count = 20, int offset = 0});
  Future<List<Album>> searchAlbums(String query,
      {int count = 20, int offset = 0});

  Future<ArtistDetail> artist(String id);
  Future<AlbumDetail> album(String id);
  Future<PlaylistDetail> playlist(String id);

  Future<List<Artist>> artists();
  Future<List<Playlist>> playlists();

  Uri streamUri(String songId);
  Uri coverArtUri(String coverArtId);
}
