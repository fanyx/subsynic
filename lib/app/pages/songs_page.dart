import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../models/music.dart';
import '../../models/query.dart';
import '../../models/remote_query.dart';
import '../../models/download.dart';
import '../../services/media_download.dart';
import '../../services/remote_query_mapper.dart';
import '../../state/presence.dart';
import '../../state/remote_library.dart';
import '../hooks/use_download_actions.dart';
import '../hooks/use_list_query_paging_controller.dart';
import '../items.dart';
import '../lists.dart';
import '../ui.dart';

@RoutePage()
class AlbumSongsPage extends HookConsumerWidget {
  final String id;
  final Album? album;

  const AlbumSongsPage({
    super.key,
    @pathParam required this.id,
    this.album,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detail = ref.watch(remoteAlbumDetailProvider(id));
    final resolved = detail.value?.album ?? album;
    if (resolved == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final query = useMemoized(() => const ListQuery(
          page: Pagination(limit: 60),
          sort: SortBy(column: 'disc, track'),
        ));

    final getSongs = useCallback(
      (ListQuery query) async {
        final d = await ref.read(remoteAlbumDetailProvider(id).future);
        return slice(d.songs.toList(), query.page);
      },
      [id],
    );

    return _SongsPage(
      header: _AlbumHeader(album: resolved),
      query: query,
      getSongs: getSongs,
      background: AlbumArtGradient(id: id),
      boldTitle: true,
      albumDetail: detail.value,
    );
  }
}

@RoutePage()
class PlaylistSongsPage extends HookConsumerWidget {
  final String id;
  final Playlist? playlist;

  const PlaylistSongsPage({
    super.key,
    @pathParam required this.id,
    this.playlist,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detail = ref.watch(remotePlaylistDetailProvider(id));
    final resolved = detail.value?.playlist ?? playlist;
    if (resolved == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final query = useMemoized(() => const ListQuery(
          page: Pagination(limit: 60),
          sort: SortBy(column: 'playlist_songs.position'),
        ));

    final getSongs = useCallback(
      (ListQuery query) async {
        final d = await ref.read(remotePlaylistDetailProvider(id).future);
        return slice(d.songs.toList(), query.page);
      },
      [id],
    );

    return _SongsPage(
      header: _PlaylistHeader(playlist: resolved),
      query: query,
      getSongs: getSongs,
      songImage: true,
      background: const BackgroundGradient(),
      boldTitle: true,
    );
  }
}

class _AlbumHeader extends HookConsumerWidget {
  final Album album;

  const _AlbumHeader({required this.album});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final downloadActions = useAlbumDownloadActions(
      context: context,
      ref: ref,
      album: album,
    );
    final status = ref.watch(albumDownloadStatusProvider(album.id)).value ??
        const ListDownloadStatus(total: 0, downloaded: 0, downloading: 0);
    final allDownloaded = status.total > 0 && status.downloaded >= status.total;

    final artist = album.albumArtist;
    final year = album.year;
    final subtitle = artist != null && year != null
        ? '$artist · $year'
        : artist ?? year?.toString();

    return _Header(
      title: album.name,
      subtitle: subtitle,
      image: CardClip(
        square: false,
        child: CoverArt(
          album: album,
          square: false,
          fit: BoxFit.contain,
        ),
      ),
      downloadActions: downloadActions,
      primaryButton: FilledButton.icon(
        onPressed: () async {
          final notifier = ref.read(mediaDownloadServiceProvider.notifier);
          try {
            if (allDownloaded) {
              final ok = await showDialog<bool>(
                context: context,
                builder: (context) => const DeleteDialog(),
              );
              if (ok == true) {
                await notifier.deleteAlbum(album);
              }
            } else {
              final d = await ref.read(remoteAlbumDetailProvider(album.id).future);
              await notifier.downloadAlbum(d);
            }
          } catch (e) {
            if (context.mounted) {
              showErrorSnackbar(context, e.toString());
            }
          }
        },
        icon: Icon(
          allDownloaded
              ? Icons.delete_outline_rounded
              : Icons.download_rounded,
        ),
        label: Text(allDownloaded ? 'Remove Album' : 'Download Album'),
      ),
      onMore: () => showContextMenu(
        context: context,
        ref: ref,
        builder: (context) => BottomSheetMenu(
          child: AlbumContextMenu(album: album),
        ),
      ),
    );
  }
}

class _PlaylistHeader extends HookConsumerWidget {
  final Playlist playlist;

  const _PlaylistHeader({required this.playlist});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detail = ref.watch(remotePlaylistDetailProvider(playlist.id));
    final downloadActions = usePlaylistDownloadActions(
      context: context,
      ref: ref,
      playlist: playlist,
      detail: detail.value,
    );
    final status =
        ref.watch(playlistDownloadStatusProvider(playlist.id)).value ??
            const ListDownloadStatus(total: 0, downloaded: 0, downloading: 0);
    final allDownloaded = status.total > 0 && status.downloaded >= status.total;

    return _Header(
      title: playlist.name,
      subtitle: '${playlist.songCount} songs',
      image: CardClip(
        square: false,
        child: const PlaceholderArt(),
      ),
      downloadActions: downloadActions,
      primaryButton: FilledButton.icon(
        onPressed: () async {
          final notifier = ref.read(mediaDownloadServiceProvider.notifier);
          try {
            if (allDownloaded) {
              final ok = await showDialog<bool>(
                context: context,
                builder: (context) => const DeleteDialog(),
              );
              if (ok == true) {
                await notifier.deletePlaylist(playlist, detail: detail.value);
              }
            } else {
              final d =
                  await ref.read(remotePlaylistDetailProvider(playlist.id).future);
              await notifier.downloadPlaylist(d);
            }
          } catch (e) {
            if (context.mounted) {
              showErrorSnackbar(context, e.toString());
            }
          }
        },
        icon: Icon(
          allDownloaded
              ? Icons.delete_outline_rounded
              : Icons.download_rounded,
        ),
        label: Text(allDownloaded ? 'Remove Playlist' : 'Download Playlist'),
      ),
      onMore: () => showContextMenu(
        context: context,
        ref: ref,
        builder: (context) => BottomSheetMenu(
          child: PlaylistContextMenu(playlist: playlist, detail: detail.value),
        ),
      ),
    );
  }
}

class _SongsPage extends HookConsumerWidget {
  final ListQuery query;
  final FutureOr<List<Song>> Function(ListQuery query) getSongs;
  final Widget header;
  final Widget background;
  final bool songImage;
  final bool boldTitle;
  final AlbumDetail? albumDetail;

  const _SongsPage({
    required this.query,
    required this.getSongs,
    required this.header,
    required this.background,
    this.songImage = false,
    this.boldTitle = false,
    this.albumDetail,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pagingController = useListQueryPagingController(
      ref,
      query: query,
      getItems: getSongs,
    );

    final router = context.router;
    final previous = router.stack.length >= 2
        ? router.stack[router.stack.length - 2].routeData
        : null;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: background),
          CustomScrollView(
            slivers: [
              SliverSafeArea(
                sliver: SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: header,
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: PagedListQueryView(
                  pagingController: pagingController,
                  useSliver: true,
                  itemBuilder: (context, item, index) => SongListTile(
                    song: item,
                    image: songImage,
                    boldTitle: boldTitle,
                    onRemove: () => ref
                        .read(mediaDownloadServiceProvider.notifier)
                        .deleteSong(item),
                    onLongPress: () => showContextMenu(
                      context: context,
                      ref: ref,
                      builder: (context) => BottomSheetMenu(
                        size: MenuSize.small,
                        child: SongContextMenu(
                          song: item,
                          albumDetail: albumDetail,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (router.canPop())
            PositionedDirectional(
              top: MediaQuery.paddingOf(context).top + 4,
              start: 8,
              child: _BackChip(
                label: _backLabel(ref, previous),
                onPressed: () => router.maybePop(),
              ),
            ),
        ],
      ),
    );
  }
}

String? _backLabel(WidgetRef ref, RouteData? previous) {
  switch (previous?.name) {
    case 'LibraryTabsRoute':
      return 'Library';
    case 'ArtistRoute':
      final id = previous?.params.optString('id');
      if (id != null) {
        return ref.watch(remoteArtistDetailProvider(id)).value?.artist.name ??
            'Artist';
      }
      return 'Artist';
    case 'PlaylistSongsRoute':
      return 'Playlist';
    default:
      return null;
  }
}

class _BackChip extends StatelessWidget {
  final String? label;
  final VoidCallback onPressed;

  const _BackChip({
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.75),
      shape: const StadiumBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(8, 6, 12, 6),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.arrow_back_rounded, size: 20),
              const SizedBox(width: 6),
              Text(label ?? 'Back'),
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends HookConsumerWidget {
  final String title;
  final String? subtitle;
  final Widget image;
  final List<DownloadAction> downloadActions;
  final Widget? primaryButton;
  final void Function()? onMore;

  const _Header({
    required this.title,
    this.subtitle,
    required this.image,
    required this.downloadActions,
    this.primaryButton,
    this.onMore,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 280, child: image),
        const SizedBox(height: 16),
        Text(
          title,
          style: theme.textTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          subtitle ?? '',
          style: theme.textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (primaryButton != null)
              primaryButton!
            else if (downloadActions.isNotEmpty)
              IconButton(
                onPressed: downloadActions.first.action,
                icon: downloadActions.first.iconBuilder(context),
                tooltip: 'Download / manage',
              ),
            if (onMore != null)
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 8),
                child: IconButton(
                  onPressed: onMore,
                  icon: const Icon(Icons.more_horiz),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
