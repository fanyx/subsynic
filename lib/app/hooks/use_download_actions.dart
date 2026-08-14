import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../models/download.dart';
import '../../models/music.dart';
import '../../models/remote_query.dart';
import '../../services/media_download.dart';
import '../../state/presence.dart';
import '../../state/remote_library.dart';
import '../ui.dart';

enum DownloadActionType {
  download,
  cancel,
  delete,
}

class DownloadAction {
  final DownloadActionType type;
  final WidgetBuilder iconBuilder;
  final FutureOr<void> Function()? action;

  const DownloadAction({
    required this.type,
    required this.iconBuilder,
    this.action,
  });
}

List<DownloadAction> useAlbumDownloadActions({
  required BuildContext context,
  required WidgetRef ref,
  required Album album,
}) {
  final status = ref.watch(albumDownloadStatusProvider(album.id)).value;

  return useListDownloadActions(
    context: context,
    ref: ref,
    listId: album.id,
    status: status,
    onDownload: () async {
      final detail =
          await ref.read(remoteAlbumDetailProvider(album.id).future);
      await ref.read(mediaDownloadServiceProvider.notifier).downloadAlbum(detail);
    },
    onDelete: () =>
        ref.read(mediaDownloadServiceProvider.notifier).deleteAlbum(album),
    onCancel: () =>
        ref.read(mediaDownloadServiceProvider.notifier).cancelAlbum(album),
  );
}

List<DownloadAction> usePlaylistDownloadActions({
  required BuildContext context,
  required WidgetRef ref,
  required Playlist playlist,
  PlaylistDetail? detail,
}) {
  final status =
      ref.watch(playlistDownloadStatusProvider(playlist.id)).value;

  return useListDownloadActions(
    context: context,
    ref: ref,
    listId: playlist.id,
    status: status,
    onDownload: () async {
      final PlaylistDetail resolved = detail ??
          await ref.read(remotePlaylistDetailProvider(playlist.id).future);
      await ref
          .read(mediaDownloadServiceProvider.notifier)
          .downloadPlaylist(resolved);
    },
    onDelete: () => ref
        .read(mediaDownloadServiceProvider.notifier)
        .deletePlaylist(playlist, detail: detail),
    onCancel: () => ref
        .read(mediaDownloadServiceProvider.notifier)
        .cancelPlaylist(playlist, detail: detail),
  );
}

List<DownloadAction> useListDownloadActions({
  required BuildContext context,
  required WidgetRef ref,
  required String listId,
  required ListDownloadStatus? status,
  required FutureOr<void> Function() onDelete,
  required FutureOr<void> Function() onCancel,
  required FutureOr<void> Function() onDownload,
}) {
  status ??= const ListDownloadStatus(total: 0, downloaded: 0, downloading: 0);

  final service = ref.watch(mediaDownloadServiceProvider);
  final listDownloadInProgress = service.listDownloads.contains(listId);
  final listDeleteInProgress = service.deletes.contains(listId);
  final listCancelInProgress = service.listCancels.contains(listId);

  DownloadAction delete() {
    return DownloadAction(
      type: DownloadActionType.delete,
      iconBuilder: (context) => const Icon(Icons.delete_forever_rounded),
      action: listDeleteInProgress
          ? null
          : () async {
              final ok = await showDialog<bool>(
                context: context,
                builder: (context) => const DeleteDialog(),
              );
              if (ok == true) {
                try {
                  await onDelete();
                } catch (e) {
                  if (context.mounted) {
                    showErrorSnackbar(context, e.toString());
                  }
                }
              }
            },
    );
  }

  DownloadAction cancel() {
    return DownloadAction(
      type: DownloadActionType.cancel,
      iconBuilder: (context) => Stack(
        alignment: Alignment.center,
        children: const [
          Icon(Icons.cancel_rounded),
          SizedBox(
            height: 32,
            width: 32,
            child: CircularProgressIndicator(
              strokeWidth: 3,
            ),
          ),
        ],
      ),
      action: listCancelInProgress
          ? null
          : () async {
              try {
                await onCancel();
              } catch (e) {
                if (context.mounted) {
                  showErrorSnackbar(context, e.toString());
                }
              }
            },
    );
  }

  DownloadAction download() {
    return DownloadAction(
      type: DownloadActionType.download,
      iconBuilder: (context) => const Icon(Icons.download_rounded),
      action: () async {
        try {
          await onDownload();
        } catch (e) {
          if (context.mounted) {
            showErrorSnackbar(context, e.toString());
          }
        }
      },
    );
  }

  if (status.total == status.downloaded) {
    return [delete()];
  } else if (status.downloading == 0 && status.downloaded > 0) {
    return [download(), delete()];
  } else if (listDownloadInProgress || status.downloading > 0) {
    return [cancel()];
  } else {
    return [download()];
  }
}

/// Single-track download actions, driven by the song's download status.
List<DownloadAction> useSongDownloadActions({
  required BuildContext context,
  required WidgetRef ref,
  required Song song,
  AlbumDetail? detail,
}) {
  final presence = ref.watch(songPresenceProvider(song.id)).value;
  final status = presence?.downloadStatus ?? DownloadStatus.none;
  final notifier = ref.read(mediaDownloadServiceProvider.notifier);

  DownloadAction download() {
    return DownloadAction(
      type: DownloadActionType.download,
      iconBuilder: (context) => const Icon(Icons.download_rounded),
      action: () async {
        try {
          await notifier.downloadSong(song, detail: detail);
        } catch (e) {
          if (context.mounted) {
            showErrorSnackbar(context, e.toString());
          }
        }
      },
    );
  }

  DownloadAction cancel() {
    return DownloadAction(
      type: DownloadActionType.cancel,
      iconBuilder: (context) => const Icon(Icons.cancel_rounded),
      action: () async {
        try {
          await notifier.cancelSong(song);
        } catch (e) {
          if (context.mounted) {
            showErrorSnackbar(context, e.toString());
          }
        }
      },
    );
  }

  DownloadAction delete() {
    return DownloadAction(
      type: DownloadActionType.delete,
      iconBuilder: (context) => const Icon(Icons.delete_forever_rounded),
      action: () async {
        try {
          await notifier.deleteSong(song);
        } catch (e) {
          if (context.mounted) {
            showErrorSnackbar(context, e.toString());
          }
        }
      },
    );
  }

  switch (status) {
    case DownloadStatus.completed:
      return [delete()];
    case DownloadStatus.downloading:
    case DownloadStatus.queued:
      return [cancel()];
    default:
      return [download()];
  }
}
