import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/music.dart';
import '../models/query.dart';
import '../models/remote_query.dart';
import '../services/remote_query_mapper.dart';
import 'server.dart';

part 'remote_library.g.dart';

final noServer = StateError('No server configured.');

@Riverpod(keepAlive: true)
class ArtistArtIndex extends _$ArtistArtIndex {
  @override
  Map<String, String?> build() => {};

  void set(String artistId, String? coverArtId) =>
      state = {...state, artistId: coverArtId};

  void clear() => state = {};
}

/// Artist badge facts (Σ album song counts + the album id set) memoized so
/// the Artists-tab tile badge survives scroll re-entry without a fresh
/// `getArtist` (the autoDispose `remoteArtistDetail` would otherwise refetch).
class ArtistBadge {
  final int total;
  final ISet<String> albumIds;

  const ArtistBadge({required this.total, required this.albumIds});
}

@Riverpod(keepAlive: true)
class ArtistBadgeIndex extends _$ArtistBadgeIndex {
  @override
  Map<String, ArtistBadge> build() => {};

  void set(String artistId, ArtistBadge badge) =>
      state = {...state, artistId: badge};

  void clear() => state = {};
}

/// Memoized `PlaylistDetail`s (small count) so the Playlists-tab tile badge
/// survives scroll re-entry without a fresh `getPlaylist`.
@Riverpod(keepAlive: true)
class PlaylistDetailMemo extends _$PlaylistDetailMemo {
  @override
  Map<String, PlaylistDetail> build() => {};

  void set(String playlistId, PlaylistDetail detail) =>
      state = {...state, playlistId: detail};

  void clear() => state = {};
}

@Riverpod(keepAlive: true)
Future<List<Album>> remoteAlbumList(Ref ref, AlbumListRequest request) async {
  final source = ref.watch(musicSourceProvider);
  if (source == null) return const [];
  return source.albums(request);
}

@Riverpod(keepAlive: true)
Future<List<Artist>> allArtists(Ref ref) async {
  final source = ref.watch(musicSourceProvider);
  if (source == null) return const [];
  return source.artists();
}

@Riverpod(keepAlive: true)
Future<List<Playlist>> allPlaylists(Ref ref) async {
  final source = ref.watch(musicSourceProvider);
  if (source == null) return const [];
  return source.playlists();
}

@riverpod
Future<List<Artist>> remoteArtistList(Ref ref, ListQuery query) async {
  final all = await ref.watch(allArtistsProvider.future);
  final sorted = mapArtistsQuery(all, query);
  return slice(sorted, query.page);
}

@riverpod
Future<List<Playlist>> remotePlaylistList(Ref ref, ListQuery query) async {
  final all = await ref.watch(allPlaylistsProvider.future);
  final sorted = mapPlaylistsQuery(all, query);
  return slice(sorted, query.page);
}

@riverpod
Future<List<Album>> remoteAlbumSearch(
  Ref ref, {
  required String query,
  required Pagination page,
}) async {
  final source = ref.watch(musicSourceProvider);
  if (source == null) return const [];
  return source.searchAlbums(query, count: page.limit, offset: page.offset);
}

@riverpod
Future<List<Artist>> remoteArtistSearch(
  Ref ref, {
  required String query,
  required Pagination page,
}) async {
  final source = ref.watch(musicSourceProvider);
  if (source == null) return const [];
  return source.searchArtists(query, count: page.limit, offset: page.offset);
}

@riverpod
Future<List<Playlist>> remotePlaylistSearch(
  Ref ref, {
  required String query,
  required Pagination page,
}) async {
  final all = await ref.watch(allPlaylistsProvider.future);
  final filtered = filterPlaylistsBySearch(all, query);
  filtered.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
  return slice(filtered, page);
}

@riverpod
Future<AlbumDetail> remoteAlbumDetail(Ref ref, String id) {
  final source = ref.watch(musicSourceProvider);
  if (source == null) throw noServer;
  return source.album(id);
}

@riverpod
Future<ArtistDetail> remoteArtistDetail(Ref ref, String id) {
  final source = ref.watch(musicSourceProvider);
  if (source == null) throw noServer;
  return source.artist(id);
}

@riverpod
Future<PlaylistDetail> remotePlaylistDetail(Ref ref, String id) {
  final source = ref.watch(musicSourceProvider);
  if (source == null) throw noServer;
  return source.playlist(id);
}

@riverpod
Future<String?> artistCoverArt(Ref ref, String artistId) async {
  final index = ref.watch(artistArtIndexProvider);
  if (index.containsKey(artistId)) return index[artistId];
  final detail = await ref.watch(remoteArtistDetailProvider(artistId).future);
  final coverArtId = detail.albums.firstOrNull?.coverArt;
  ref.read(artistArtIndexProvider.notifier).set(artistId, coverArtId);
  return coverArtId;
}

@riverpod
Future<IList<Album>> albumsByArtistId(Ref ref, String id) async {
  final detail = await ref.watch(remoteArtistDetailProvider(id).future);
  return detail.albums;
}
