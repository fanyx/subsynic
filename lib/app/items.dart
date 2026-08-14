import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/music.dart';
import '../models/download.dart';
import '../state/downloads.dart';
import '../state/presence.dart';
import '../state/remote_library.dart';
import 'ui.dart';

enum CardStyle {
  imageOnly,
  withText,
}

enum AlbumSubtitle {
  artist,
  year,
}

enum DownloadMark {
  none,
  partial,
  complete,
}

/// Derives the download mark for an album/artist/playlist: [complete] when
/// every track is present locally, [partial] when only some tracks are
/// present (or a download is in progress), [none] otherwise.
DownloadMark downloadMarkOf(ListDownloadStatus? status) {
  if (status == null || status.total <= 0) return DownloadMark.none;
  if (status.downloaded >= status.total) return DownloadMark.complete;
  if (status.downloaded > 0 || status.downloading > 0) return DownloadMark.partial;
  return DownloadMark.none;
}

class AlbumCard extends HookConsumerWidget {
  final Album album;
  final void Function()? onTap;
  final CardStyle style;
  final AlbumSubtitle subtitle;

  const AlbumCard({
    super.key,
    required this.album,
    this.onTap,
    this.style = CardStyle.withText,
    this.subtitle = AlbumSubtitle.artist,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counts = ref
        .watch(downloadCountsByAlbumProvider)
        .value?[album.id];
    final status = ListDownloadStatus(
      total: album.songCount,
      downloaded: counts?.downloaded ?? 0,
      downloading: counts?.downloading ?? 0,
    );
    final mark = downloadMarkOf(status);

    final image = CardClip(
      child: Stack(
        fit: StackFit.expand,
        children: [
          CoverArt(album: album),
          if (mark != DownloadMark.none)
            PositionedDirectional(
              top: 6,
              end: 6,
              child: _DownloadBadge(partial: mark == DownloadMark.partial),
            ),
          PositionedDirectional(
            bottom: 0,
            start: 0,
            end: 0,
            child: _AlbumCardHeader(album: album),
          ),
        ],
      ),
    );

    Widget content;
    if (style == CardStyle.imageOnly) {
      content = image;
    } else {
      content = Column(
        children: [
          image,
          _AlbumCardText(album: album, subtitle: subtitle),
        ],
      );
    }

    return ImageCard(onTap: onTap, child: content);
  }
}

/// Opaque label strip overlaid at the bottom of the album cover with the
/// album name in the foreground.
class _AlbumCardHeader extends StatelessWidget {
  final Album album;

  const _AlbumCardHeader({required this.album});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 5),
      color: theme.colorScheme.surface,
      child: Text(
        album.name,
        maxLines: 1,
        softWrap: false,
        overflow: TextOverflow.fade,
        style: theme.textTheme.bodySmall!.copyWith(
          color: theme.colorScheme.onSurface,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _DownloadBadge extends StatelessWidget {
  final bool partial;

  const _DownloadBadge({required this.partial});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: partial ? scheme.secondaryContainer : scheme.primaryContainer,
        shape: BoxShape.circle,
      ),
      child: Icon(
        partial ? Icons.downloading_rounded : Icons.download_done_rounded,
        size: 16,
        color: partial ? scheme.onSecondaryContainer : scheme.onPrimaryContainer,
      ),
    );
  }
}

class _TrailingDownloadMark extends StatelessWidget {
  final DownloadMark mark;

  const _TrailingDownloadMark({required this.mark});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Icon(
      mark == DownloadMark.complete
          ? Icons.download_done_rounded
          : Icons.downloading_rounded,
      size: 20,
      color: mark == DownloadMark.complete
          ? scheme.primary
          : scheme.onSurfaceVariant,
    );
  }
}

class ImageCard extends StatelessWidget {
  final Widget child;
  final void Function()? onTap;
  final void Function()? onLongPress;

  const ImageCard({
    super.key,
    required this.child,
    this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      surfaceTintColor: Colors.transparent,
      margin: const EdgeInsets.all(0),
      child: Stack(
        fit: StackFit.passthrough,
        alignment: Alignment.bottomCenter,
        children: [
          child,
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onTap,
                onLongPress: onLongPress,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AlbumCardText extends StatelessWidget {
  final Album album;
  final AlbumSubtitle subtitle;

  const _AlbumCardText({
    required this.album,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.only(top: 4, bottom: 8),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            (subtitle == AlbumSubtitle.artist
                    ? album.albumArtist
                    : album.year?.toString()) ??
                '',
            maxLines: 1,
            softWrap: false,
            overflow: TextOverflow.fade,
            textAlign: TextAlign.start,
            style: textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}

class AlbumListTile extends HookConsumerWidget {
  final Album album;
  final void Function()? onTap;
  final void Function()? onLongPress;

  const AlbumListTile({
    super.key,
    required this.album,
    this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counts = ref
        .watch(downloadCountsByAlbumProvider)
        .value?[album.id];
    final status = ListDownloadStatus(
      total: album.songCount,
      downloaded: counts?.downloaded ?? 0,
      downloading: counts?.downloading ?? 0,
    );
    final mark = downloadMarkOf(status);

    return ListTile(
      leading: CardClip(child: CoverArt(album: album)),
      title: Text(album.name),
      subtitle: Text(album.albumArtist ?? ''),
      trailing: mark == DownloadMark.none
          ? null
          : _TrailingDownloadMark(mark: mark),
      onTap: onTap,
      onLongPress: onLongPress,
    );
  }
}

class ArtistListTile extends HookConsumerWidget {
  final Artist artist;
  final void Function()? onTap;
  final void Function()? onLongPress;

  const ArtistListTile({
    super.key,
    required this.artist,
    this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final coverArtId = ref.watch(artistCoverArtProvider(artist.id)).value;
    final mark =
        downloadMarkOf(ref.watch(artistDownloadStatusProvider(artist.id)).value);

    return ListTile(
      leading: CircleClip(
        child: coverArtId != null
            ? CoverArt(coverArt: coverArtId, square: false)
            : const PlaceholderArt(),
      ),
      title: Text(artist.name),
      subtitle: Text('${artist.albumCount} albums'),
      trailing: mark == DownloadMark.none
          ? null
          : _TrailingDownloadMark(mark: mark),
      onTap: onTap,
      onLongPress: onLongPress,
    );
  }
}

class PlaylistListTile extends HookConsumerWidget {
  final Playlist playlist;
  final void Function()? onTap;
  final void Function()? onLongPress;

  const PlaylistListTile({
    super.key,
    required this.playlist,
    this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status =
        ref.watch(playlistDownloadStatusProvider(playlist.id)).value;
    final mark = downloadMarkOf(status);

    return ListTile(
      leading: CardClip(
        child: const PlaceholderArt(),
      ),
      title: Text(playlist.name),
      subtitle: Text('${playlist.songCount} songs'),
      trailing: mark == DownloadMark.none
          ? null
          : _TrailingDownloadMark(mark: mark),
      onTap: onTap,
      onLongPress: onLongPress,
    );
  }
}

class SongListTile extends HookConsumerWidget {
  final Song song;
  final void Function()? onTap;
  final void Function()? onRemove;
  final void Function()? onLongPress;
  final bool image;
  final bool boldTitle;

  const SongListTile({
    super.key,
    required this.song,
    this.onTap,
    this.onRemove,
    this.onLongPress,
    this.image = false,
    this.boldTitle = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      type: MaterialType.transparency,
      child: ListTile(
        title: Text(
          song.title,
          maxLines: 1,
          softWrap: false,
          overflow: TextOverflow.fade,
          style: boldTitle
              ? const TextStyle(fontWeight: FontWeight.w700)
              : null,
        ),
        subtitle: _SongSubtitle(song: song),
        leading: image
            ? CardClip(child: CoverArt(coverArt: song.coverArt, albumId: song.albumId))
            : null,
        trailing: _SongTrailing(song: song, onRemove: onRemove),
        onTap: onTap,
        onLongPress: onLongPress,
      ),
    );
  }
}

class _SongSubtitle extends HookConsumerWidget {
  final Song song;

  const _SongSubtitle({required this.song});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final presence = ref.watch(songPresenceProvider(song.id)).value;
    final status = presence?.downloadStatus ?? DownloadStatus.none;

    final inheritedStyle = DefaultTextStyle.of(context).style;

    Widget? downloadIndicator;
    if (status == DownloadStatus.completed) {
      downloadIndicator = const Padding(
        padding: EdgeInsetsDirectional.only(end: 3),
        child: Icon(
          Icons.download_done_rounded,
          size: 20,
        ),
      );
    } else if (status == DownloadStatus.downloading) {
      downloadIndicator = Padding(
        padding: const EdgeInsetsDirectional.only(start: 4, end: 9),
        child: SizedBox(
          height: 10,
          width: 10,
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        ),
      );
    } else if (status == DownloadStatus.failed ||
        status == DownloadStatus.removed) {
      final jobError = ref
          .watch(downloadsProvider)
          .downloads
          .firstWhereOrNull((d) => d.songId == song.id && d.error != null)
          ?.error;
      downloadIndicator = Padding(
        padding: const EdgeInsetsDirectional.only(end: 3),
        child: Tooltip(
          message: jobError ?? 'Download failed',
          child: Icon(
            status == DownloadStatus.failed
                ? Icons.error_outline_rounded
                : Icons.delete_outline_rounded,
            size: 18,
          ),
        ),
      );
    }

    return Row(
      children: [
        ?downloadIndicator,
        Expanded(
          child: Text(
            song.artist ?? song.album ?? '',
            maxLines: 1,
            softWrap: false,
            overflow: TextOverflow.fade,
            style: TextStyle(color: inheritedStyle.color),
          ),
        ),
      ],
    );
  }
}

class _SongTrailing extends HookConsumerWidget {
  final Song song;
  final void Function()? onRemove;

  const _SongTrailing({required this.song, this.onRemove});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final presence = ref.watch(songPresenceProvider(song.id)).value;
    final status = presence?.downloadStatus ?? DownloadStatus.none;

    if (status == DownloadStatus.completed && onRemove != null) {
      return IconButton(
        icon: const Icon(Icons.delete_outline_rounded),
        tooltip: 'Remove download',
        onPressed: onRemove,
      );
    }

    return const SizedBox.shrink();
  }
}

class FabPadding extends StatelessWidget {
  const FabPadding({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(height: 86);
  }
}
