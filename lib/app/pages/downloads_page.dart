import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../models/download.dart';
import '../../models/music.dart';
import '../../services/media_download.dart';
import '../../state/downloads.dart';
import '../../state/remote_library.dart';
import '../ui.dart';

@RoutePage()
class DownloadsPage extends HookConsumerWidget {
  const DownloadsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(downloadsProvider);
    final groups = ref.watch(downloadGroupsProvider);

    final hasActive = state.downloads.any(
      (d) =>
          d.status == DownloadStatus.downloading ||
          d.status == DownloadStatus.queued,
    );
    final hasCompleted = state.downloads.any(
      (d) => d.status == DownloadStatus.completed,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Downloads'),
        actions: [
          if (hasCompleted)
            TextButton(
              onPressed: () => ref
                  .read(mediaDownloadServiceProvider.notifier)
                  .clearCompleted(),
              child: const Text('Clear completed'),
            ),
          if (hasActive)
            TextButton(
              onPressed: () =>
                  ref.read(mediaDownloadServiceProvider.notifier).cancelAll(),
              child: const Text('Cancel all'),
            ),
        ],
      ),
      body: groups.isEmpty
          ? const _EmptyDownloads()
          : ListView.builder(
              padding: const EdgeInsets.only(bottom: 24),
              itemCount: groups.length,
              itemBuilder: (context, index) =>
                  _AlbumDownloadCard(group: groups[index]),
            ),
    );
  }
}

class _EmptyDownloads extends StatelessWidget {
  const _EmptyDownloads();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.download_done_rounded,
            size: 64,
            color: Theme.of(context).colorScheme.outline,
          ),
          const SizedBox(height: 16),
          const Text('No downloads'),
          const SizedBox(height: 4),
          Text(
            'Start downloads from an album or playlist.',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}

/// Album-grouped, expandable card with a combined status header and stable
/// per-song rows. Expansion is controlled ([_expandedByUser] overrides the
/// provider's auto-state: expand while working, collapse once finished).
class _AlbumDownloadCard extends HookConsumerWidget {
  final DownloadGroup group;

  const _AlbumDownloadCard({required this.group});

  bool get _isLoose => group.albumId == null;

  String get _statusText => switch (group.status) {
    DownloadGroupStatus.successful => 'Successful',
    DownloadGroupStatus.downloading => 'Downloading',
    DownloadGroupStatus.incomplete => 'Incomplete',
    DownloadGroupStatus.error => 'Error',
  };

  Color _statusColor(BuildContext context) => switch (group.status) {
    DownloadGroupStatus.successful ||
    DownloadGroupStatus.downloading => Theme.of(context).colorScheme.primary,
    DownloadGroupStatus.incomplete => Colors.amber,
    DownloadGroupStatus.error => Theme.of(context).colorScheme.error,
  };

  Widget _statusIcon(BuildContext context) {
    final color = _statusColor(context);
    return switch (group.status) {
      DownloadGroupStatus.successful => Icon(
        Icons.check_circle_rounded,
        color: color,
        size: 20,
      ),
      DownloadGroupStatus.downloading => SizedBox(
        width: 16,
        height: 16,
        child: CircularProgressIndicator(strokeWidth: 2.5, color: color),
      ),
      DownloadGroupStatus.incomplete => Icon(
        Icons.remove_circle_outline_rounded,
        color: color,
        size: 20,
      ),
      DownloadGroupStatus.error => Icon(
        Icons.error_rounded,
        color: color,
        size: 20,
      ),
    };
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expandedByUser = useState<bool?>(null);
    final expanded =
        expandedByUser.value ??
        (group.status == DownloadGroupStatus.downloading);

    final completedCount = group.downloads
        .where((d) => d.status == DownloadStatus.completed)
        .length;
    final total = group.downloads.length;
    final first = group.downloads.first;

    final title = _isLoose ? 'Other downloads' : first.album ?? 'Unknown album';
    final artistLine = _isLoose ? '' : first.albumArtist ?? 'Various Artists';

    final cover = _isLoose
        ? Icon(
            Icons.library_music_rounded,
            color: Theme.of(context).colorScheme.outline,
            size: 28,
          )
        : CoverArt(coverArt: first.coverArt, albumId: group.albumId);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          InkWell(
            onTap: () => expandedByUser.value = !expanded,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  SizedBox(
                    width: 48,
                    height: 48,
                    child: CardClip(child: cover),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                title,
                                maxLines: 1,
                                softWrap: false,
                                overflow: TextOverflow.fade,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                            Text(
                              '$completedCount/$total',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            const SizedBox(width: 4),
                            _statusIcon(context),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                artistLine,
                                maxLines: 1,
                                softWrap: false,
                                overflow: TextOverflow.fade,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ),
                            Text(
                              _statusText,
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(color: _statusColor(context)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    expanded
                        ? Icons.expand_less_rounded
                        : Icons.expand_more_rounded,
                  ),
                ],
              ),
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 200),
            alignment: Alignment.topCenter,
            child: expanded
                ? _buildBody(context, ref)
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context, WidgetRef ref) {
    final retryable =
        group.status == DownloadGroupStatus.error ||
        group.status == DownloadGroupStatus.incomplete;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Divider(height: 1),
        for (final job in group.downloads) ...[
          _DownloadTile(job: job),
          const Divider(height: 1),
        ],
        if (retryable)
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 4, 12, 12),
            child: Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                onPressed: () => _retry(context, ref),
                icon: const Icon(Icons.refresh_rounded),
                label: const Text('Retry'),
              ),
            ),
          ),
      ],
    );
  }

  Future<void> _retry(BuildContext context, WidgetRef ref) async {
    final notifier = ref.read(mediaDownloadServiceProvider.notifier);
    try {
      if (_isLoose) {
        // Re-enqueue each unfinished loose job by reconstructing a minimal
        // Song from the job's fields.
        for (final job in group.downloads) {
          if (job.status == DownloadStatus.completed) continue;
          await notifier.downloadSong(
            Song(
              id: job.songId,
              title: job.title ?? job.songId,
              artist: job.artist,
              album: job.album,
              albumArtist: job.albumArtist,
              coverArt: job.coverArt,
              albumId: job.albumId,
            ),
          );
        }
      } else {
        final detail = await ref.read(
          remoteAlbumDetailProvider(group.albumId!).future,
        );
        await notifier.downloadAlbum(detail);
      }
    } catch (e) {
      if (context.mounted) {
        showErrorSnackbar(context, e.toString());
      }
    }
  }
}

/// A stable per-song row inside an album card. Rendered in the group's
/// insertion order; a song's row never moves — only its icon/progress change.
class _DownloadTile extends HookConsumerWidget {
  final Download job;

  const _DownloadTile({required this.job});

  String get _statusText {
    switch (job.status) {
      case DownloadStatus.queued:
        return 'Queued';
      case DownloadStatus.downloading:
        return 'Downloading';
      case DownloadStatus.completed:
        return 'Completed';
      case DownloadStatus.failed:
        return 'Failed';
      case DownloadStatus.none:
        return 'Cancelled';
      case DownloadStatus.removed:
        return 'Removed';
    }
  }

  Widget _statusWidget(BuildContext context) {
    final muted = Theme.of(context).colorScheme.onSurfaceVariant;
    switch (job.status) {
      case DownloadStatus.queued:
        return Icon(Icons.hourglass_empty_rounded, color: muted);
      case DownloadStatus.downloading:
        return Text('${job.progress}%');
      case DownloadStatus.completed:
        return Icon(Icons.download_done_rounded);
      case DownloadStatus.failed:
        return Icon(
          Icons.error_outline_rounded,
          color: Theme.of(context).colorScheme.error,
        );
      case DownloadStatus.none:
        return Icon(Icons.remove_circle_outline_rounded, color: muted);
      case DownloadStatus.removed:
        return Icon(Icons.delete_outline_rounded, color: muted);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final title = job.title ?? job.songId;
    final subtitle = job.artist ?? _statusText;

    return ListTile(
      dense: true,
      title: Text(
        title,
        maxLines: 1,
        softWrap: false,
        overflow: TextOverflow.fade,
      ),
      subtitle: Text(
        subtitle,
        maxLines: 1,
        softWrap: false,
        overflow: TextOverflow.fade,
      ),
      trailing: _statusWidget(context),
      onTap: job.error != null
          ? () => showDialog<void>(
              context: context,
              builder: (context) => AlertDialog(
                title: Text(title),
                content: SelectableText(job.error!),
                actions: [
                  FilledButton.tonal(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('OK'),
                  ),
                ],
              ),
            )
          : null,
    );
  }
}
