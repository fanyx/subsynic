import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'download.freezed.dart';

enum DownloadStatus { none, queued, downloading, completed, failed, removed }

@freezed
abstract class SongDownload with _$SongDownload {
  const factory SongDownload({
    required String songId,
    String? albumId,
    String? localPath,
    @Default(DownloadStatus.none) DownloadStatus downloadStatus,
    @Default(0) int downloadProgress,
    @Default(false) bool coverEmbedded,
  }) = _SongDownload;
}

@freezed
abstract class Download with _$Download {
  const Download._();

  const factory Download({
    required String songId,
    String? title,
    String? artist,
    String? album,
    String? albumArtist,
    String? coverArt,
    String? albumId,
    DateTime? completedAt,
    required int progress,
    required DownloadStatus status,
    String? localPath,
    String? error,
  }) = _Download;
}

enum DownloadGroupStatus { successful, downloading, incomplete, error }

@freezed
abstract class DownloadGroup with _$DownloadGroup {
  const factory DownloadGroup({
    String? albumId,
    required IList<Download> downloads,
    required DownloadGroupStatus status,
  }) = _DownloadGroup;
}

/// Derives a group's combined status from its session jobs (requirement 4):
/// any song still working -> `downloading`; all done -> `successful`; all
/// errored -> `error`; anything else (mixed, or only none/removed) ->
/// `incomplete`.
DownloadGroupStatus downloadGroupStatus(Iterable<Download> jobs) {
  var active = false, completed = false, failed = false, other = false;
  for (final job in jobs) {
    switch (job.status) {
      case DownloadStatus.queued:
      case DownloadStatus.downloading:
        active = true;
      case DownloadStatus.completed:
        completed = true;
      case DownloadStatus.failed:
        failed = true;
      case DownloadStatus.none:
      case DownloadStatus.removed:
        other = true;
    }
  }
  if (active) return DownloadGroupStatus.downloading;
  if (completed && !failed && !other) return DownloadGroupStatus.successful;
  if (failed && !completed && !other) return DownloadGroupStatus.error;
  return DownloadGroupStatus.incomplete;
}

@freezed
abstract class DownloadState with _$DownloadState {
  const DownloadState._();

  const factory DownloadState({
    @Default(IListConst([])) IList<Download> downloads,
    @Default(IListConst([])) IList<String> listDownloads,
    @Default(IListConst([])) IList<String> listCancels,
    @Default(IListConst([])) IList<String> deletes,
  }) = _DownloadState;
}

@freezed
abstract class DownloadCounts with _$DownloadCounts {
  const factory DownloadCounts({
    @Default(0) int downloaded,
    @Default(0) int downloading,
  }) = _DownloadCounts;
}

@freezed
abstract class ListDownloadStatus with _$ListDownloadStatus {
  const factory ListDownloadStatus({
    required int total,
    required int downloaded,
    required int downloading,
  }) = _ListDownloadStatus;
}
