import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../database/database.dart' as db;
import '../models/download.dart';
import '../models/remote_query.dart';

import 'remote_library.dart';

part 'presence.g.dart';

SongDownload _toSongDownload(db.Download row) {
  return SongDownload(
    songId: row.songId,
    albumId: row.albumId,
    localPath: row.localPath,
    downloadStatus: row.downloadStatus,
    downloadProgress: row.downloadProgress,
    coverEmbedded: row.coverEmbedded,
  );
}

@Riverpod(keepAlive: true)
Stream<IMap<String, DownloadCounts>> downloadCountsByAlbum(Ref ref) {
  return ref
      .watch(db.databaseProvider)
      .downloadCountsByAlbum()
      .watch()
      .map(
        (rows) => IMap({
          for (final r in rows)
            if (r.albumId != null)
              r.albumId!: DownloadCounts(
                downloaded: r.downloaded,
                downloading: r.downloading,
              ),
        }),
      );
}

@riverpod
Stream<IList<SongDownload>> songDownloadsByIds(Ref ref, IList<String> ids) {
  if (ids.isEmpty) return Stream.value(const IListConst([]));
  return ref
      .watch(db.databaseProvider)
      .songDownloadsByIds(ids.toList())
      .watch()
      .map((r) => r.map(_toSongDownload).toIList());
}

@riverpod
Stream<SongDownload?> songPresence(Ref ref, String songId) {
  return ref
      .watch(db.databaseProvider)
      .songDownloadById(songId)
      .watchSingleOrNull()
      .map((r) => r == null ? null : _toSongDownload(r));
}

@riverpod
Stream<String?> albumCoverPath(Ref ref, String albumId) {
  return ref
      .watch(db.databaseProvider)
      .albumCoverByAlbum(albumId)
      .watchSingleOrNull()
      .map((r) => r?.coverPath);
}

@riverpod
Stream<ListDownloadStatus> albumDownloadStatus(
  Ref ref,
  String albumId,
) async* {
  final detail = await ref.watch(remoteAlbumDetailProvider(albumId).future);
  final index = await ref.watch(downloadCountsByAlbumProvider.future);
  final counts = index[albumId];
  yield ListDownloadStatus(
    total: detail.songs.length,
    downloaded: counts?.downloaded ?? 0,
    downloading: counts?.downloading ?? 0,
  );
}

@riverpod
Stream<ListDownloadStatus> playlistDownloadStatus(
  Ref ref,
  String playlistId,
) async* {
  final memo = ref.watch(playlistDetailMemoProvider);
  final detail = memo[playlistId] ?? await _playlistDetail(ref, playlistId);
  final ids = detail.songs.map((s) => s.id).toIList();
  final present = await ref.watch(songDownloadsByIdsProvider(ids).future);
  yield ListDownloadStatus(
    total: detail.songs.length,
    downloaded: present
        .where((d) => d.downloadStatus == DownloadStatus.completed)
        .length,
    downloading: present
        .where((d) => d.downloadStatus == DownloadStatus.downloading)
        .length,
  );
}

/// Fetches (and memoizes) a `PlaylistDetail` so the Playlists-tab tile badge
/// survives scroll re-entry without a fresh `getPlaylist`.
Future<PlaylistDetail> _playlistDetail(Ref ref, String playlistId) async {
  final detail =
      await ref.watch(remotePlaylistDetailProvider(playlistId).future);
  ref.read(playlistDetailMemoProvider.notifier).set(playlistId, detail);
  return detail;
}

@riverpod
Stream<ListDownloadStatus> artistDownloadStatus(
  Ref ref,
  String artistId,
) async* {
  final index = await ref.watch(downloadCountsByAlbumProvider.future);
  final memo = ref.watch(artistBadgeIndexProvider);
  final badge = memo[artistId] ?? await _artistBadge(ref, artistId);
  var downloaded = 0, downloading = 0;
  for (final id in badge.albumIds) {
    final counts = index[id];
    if (counts != null) {
      downloaded += counts.downloaded;
      downloading += counts.downloading;
    }
  }
  yield ListDownloadStatus(
    total: badge.total,
    downloaded: downloaded,
    downloading: downloading,
  );
}

/// Fetches (and memoizes) the artist badge facts (Σ album song counts + the
/// album id set) so the Artists-tab tile badge survives scroll re-entry
/// without a fresh `getArtist`.
Future<ArtistBadge> _artistBadge(Ref ref, String artistId) async {
  final detail = await ref.watch(remoteArtistDetailProvider(artistId).future);
  final badge = ArtistBadge(
    total: detail.albums.fold<int>(0, (sum, a) => sum + a.songCount),
    albumIds: detail.albums.map((a) => a.id).toISet(),
  );
  ref.read(artistBadgeIndexProvider.notifier).set(artistId, badge);
  return badge;
}
