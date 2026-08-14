// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/music.dart';
import '../models/remote_query.dart';
import '../services/network/client.dart';
import '../services/network/storage.dart';
import '../state/presence.dart';
import '../state/remote_library.dart';
import '../state/server.dart';
import 'app_router.dart';
import 'hooks/use_download_actions.dart';

part 'ui.g.dart';

@Riverpod(keepAlive: true)
ThemeData baseTheme(Ref ref) {
  return ThemeData(
    useMaterial3: true,
    colorSchemeSeed: Colors.indigo[800],
    brightness: Brightness.dark,
    cardTheme: CardThemeData(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  );
}

/// The gradient's dark-gray endpoint.
const kGradientLow = Color(0xFF16161A);

/// Derives the album's prominent cover color for the gradient backdrop.
///
/// Fetches the cover bytes (local `cover.jpg` or server art, both cached),
/// downscales and decodes the image on the main isolate (the engine does the
/// heavy decode off-thread; the image decoder registry is not reachable from
/// spawned isolates), then runs the palette quantization on a background
/// isolate. Returns `null` when no cover is available or no suitable color is
/// found — callers fall back to the base theme gradient.
@riverpod
FutureOr<Color?> albumGradientHigh(Ref ref, String id) async {
  final detail = await ref.watch(remoteAlbumDetailProvider(id).future);
  final coverArt = detail.album.coverArt;
  if (coverArt == null) return null;
  final bytes =
      await ref.watch(coverBytesProvider(coverArtId: coverArt, albumId: id).future);
  if (bytes == null || bytes.isEmpty) {
    return null;
  }

  final raw = await _decodeRgba(bytes);
  if (raw == null) {
    return null;
  }
  return compute(_computeGradientHigh, raw);
}

/// Decodes + downscales cover bytes to 48px RGBA on the current (main) isolate.
Future<_RawImage?> _decodeRgba(Uint8List bytes) async {
  final codec = await ui.instantiateImageCodec(bytes, targetWidth: 48);
  try {
    final frame = await codec.getNextFrame();
    final image = frame.image;
    try {
      final byteData =
          await image.toByteData(format: ui.ImageByteFormat.rawRgba);
      if (byteData == null) {
        return null;
      }
      return _RawImage(byteData, image.width, image.height);
    } finally {
      image.dispose();
    }
  } finally {
    codec.dispose();
  }
}

class _RawImage {
  final ByteData data;
  final int width;
  final int height;

  const _RawImage(this.data, this.width, this.height);
}

Future<Color?> _computeGradientHigh(_RawImage raw) async {
  final palette = await PaletteGenerator.fromByteData(
    EncodedImage(raw.data, height: raw.height, width: raw.width),
  );
  return _rankedGradientHigh(palette);
}

/// Picks a legible prominent color, mirroring subtracks' ranking: prefer the
/// dominant/vibrant family and reject near-black colors (luminance < 0.2).
Color? _rankedGradientHigh(PaletteGenerator palette) {
  for (final color in [
    palette.dominantColor,
    palette.vibrantColor,
    palette.mutedColor,
    palette.darkVibrantColor,
  ]) {
    if (color == null) {
      continue;
    }
    if (color.color.computeLuminance() >= 0.2) {
      return color.color;
    }
  }
  return null;
}

/// Full-screen gradient backdrop: album cover prominent color fading into
/// [kGradientLow] behind the header and song list.
class AlbumArtGradient extends HookConsumerWidget {
  final String id;

  const AlbumArtGradient({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final base = ref.watch(baseThemeProvider);
    final gradientHigh =
        ref.watch(albumGradientHighProvider(id)).value ?? base.colorScheme.surface;
    return _Gradient(high: gradientHigh);
  }
}

/// Base theme gradient fallback, used when there is no album art to derive a
/// color from (e.g. the playlist detail view).
class BackgroundGradient extends ConsumerWidget {
  const BackgroundGradient({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _Gradient(high: ref.watch(baseThemeProvider).colorScheme.surface);
  }
}

class _Gradient extends StatelessWidget {
  final Color high;

  const _Gradient({required this.high});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [high, kGradientLow],
        ),
      ),
    );
  }
}

// Resolves album cover bytes.
//
// Prefers the locally downloaded `cover.jpg` (via the storage layer,
// resolved through the `album_covers` presence table); when there is none,
// fetches the server cover art (600x600, via `getCoverArt`) and caches it
// under the app cache directory, namespaced by the server identity
// ([coverCacheBusterProvider]) so a server change can never serve stale art.
@riverpod
FutureOr<Uint8List?> coverBytes(
  Ref ref, {
  required String coverArtId,
  String? albumId,
}) async {
  if (albumId != null) {
    final coverPath = ref.watch(albumCoverPathProvider(albumId)).value;
    if (coverPath != null) {
      final storage = ref.watch(storageProvider);
      try {
        if (await storage.exists(coverPath)) {
          return await storage.readFile(coverPath);
        }
      } catch (_) {}
    }
  }

  final source = ref.watch(musicSourceProvider);
  if (source == null) return null;

  final buster = ref.watch(coverCacheBusterProvider);
  final cacheDir = await getApplicationCacheDirectory();
  final cacheFile = File(
    p.join(
      cacheDir.path,
      'covers',
      buster,
      '${Uri.encodeComponent(coverArtId)}.jpg',
    ),
  );
  if (await cacheFile.exists()) {
    try {
      return await cacheFile.readAsBytes();
    } catch (_) {}
  }

  try {
    final res = await ref
        .read(dioProvider)
        .get<List<int>>(
          source.coverArtUri(coverArtId).toString(),
          options: Options(responseType: ResponseType.bytes),
        );
    final bytes = res.data;
    if (bytes == null || bytes.isEmpty) return null;
    final uint8 = Uint8List.fromList(bytes);
    await cacheFile.parent.create(recursive: true);
    await cacheFile.writeAsBytes(uint8, flush: true);
    return uint8;
  } catch (_) {
    return null;
  }
}

class PlaceholderArt extends StatelessWidget {
  final BoxFit fit;

  const PlaceholderArt({super.key, this.fit = BoxFit.cover});

  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/fallback.png', fit: fit, gaplessPlayback: true);
  }
}

class CoverArt extends HookConsumerWidget {
  final String? coverArt;
  final String? albumId;
  final Album? album;
  final bool square;
  final BoxFit fit;

  const CoverArt({
    super.key,
    this.coverArt,
    this.albumId,
    this.album,
    this.square = true,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final art = coverArt ?? album?.coverArt;
    final resolvedAlbumId = albumId ?? album?.id;

    Widget child;
    if (art == null) {
      child = const PlaceholderArt();
    } else {
      final bytes = ref.watch(
        coverBytesProvider(coverArtId: art, albumId: resolvedAlbumId),
      );
      child = bytes.when(
        data: (data) => data == null
            ? const PlaceholderArt()
            : Image.memory(data, fit: fit, gaplessPlayback: true),
        error: (_, _) => const PlaceholderArt(),
        loading: () =>
            Container(color: Theme.of(context).colorScheme.secondaryContainer),
      );
    }

    if (square) {
      child = AspectRatio(aspectRatio: 1.0, child: child);
    }

    return child;
  }
}

class CardClip extends StatelessWidget {
  final Widget child;
  final bool square;

  const CardClip({super.key, required this.child, this.square = true});

  @override
  Widget build(BuildContext context) {
    final cardShape = Theme.of(context).cardTheme.shape;
    final borderRadius = cardShape is RoundedRectangleBorder
        ? cardShape.borderRadius
        : null;
    return ClipRRect(
      borderRadius: borderRadius is BorderRadius
          ? borderRadius
          : BorderRadius.zero,
      child: !square ? child : AspectRatio(aspectRatio: 1.0, child: child),
    );
  }
}

class CircleClip extends StatelessWidget {
  final Widget child;

  const CircleClip({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      clipBehavior: Clip.antiAlias,
      child: AspectRatio(aspectRatio: 1.0, child: child),
    );
  }
}

class DeleteDialog extends StatelessWidget {
  const DeleteDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Remove downloads'),
      content: const Text(
        'This removes the downloaded files from your device. '
        'The library entry stays so you can download it again.',
      ),
      actions: [
        FilledButton.tonal(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('Cancel'),
        ),
        FilledButton.icon(
          onPressed: () => Navigator.pop(context, true),
          label: const Text('Remove'),
          icon: const Icon(Icons.delete_forever_rounded),
        ),
      ],
    );
  }
}

void showErrorSnackbar(BuildContext context, String message) {
  final colors = Theme.of(context).colorScheme;

  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message, style: TextStyle(color: colors.onErrorContainer)),
    backgroundColor: colors.errorContainer,
    showCloseIcon: true,
    closeIconColor: colors.onErrorContainer,
    behavior: SnackBarBehavior.floating,
    duration: const Duration(seconds: 10),
  ));
}

enum MenuSize {
  small,
  medium,
}

Future<T?> showContextMenu<T>({
  required BuildContext context,
  required WidgetRef ref,
  required WidgetBuilder builder,
}) {
  return showModalBottomSheet<T>(
    backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
    useRootNavigator: true,
    isScrollControlled: true,
    context: context,
    builder: builder,
  );
}

class BottomSheetMenu extends StatelessWidget {
  final Widget child;
  final MenuSize size;

  const BottomSheetMenu({
    super.key,
    required this.child,
    this.size = MenuSize.medium,
  });

  @override
  Widget build(BuildContext context) {
    final height = size == MenuSize.medium ? 0.4 : 0.25;

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: height,
      maxChildSize: height,
      minChildSize: height - 0.05,
      snap: true,
      snapSizes: [height - 0.05, height],
      builder: (context, scrollController) {
        return PrimaryScrollController(
          controller: scrollController,
          child: SizedBox(
            child: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: child,
            ),
          ),
        );
      },
    );
  }
}

class AlbumContextMenu extends HookConsumerWidget {
  final Album album;

  const AlbumContextMenu({
    super.key,
    required this.album,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final downloadActions = useAlbumDownloadActions(
      context: context,
      ref: ref,
      album: album,
    );

    return ListView(
      children: [
        _Header(
          title: album.name,
          subtitle: album.albumArtist,
          image: CardClip(child: CoverArt(album: album)),
        ),
        const SizedBox(height: 8),
        if (album.artistId != null)
          _MenuItem(
            title: 'View artist',
            icon: const Icon(Icons.person_rounded),
            onTap: () async {
              final router = context.router;
              router.pop();
              router.navigate(ArtistRoute(id: album.artistId!));
            },
          ),
        for (var action in downloadActions)
          _DownloadAction(key: ValueKey(action.type), downloadAction: action),
      ],
    );
  }
}

class PlaylistContextMenu extends HookConsumerWidget {
  final Playlist playlist;
  final PlaylistDetail? detail;

  const PlaylistContextMenu({
    super.key,
    required this.playlist,
    this.detail,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final downloadActions = usePlaylistDownloadActions(
      context: context,
      ref: ref,
      playlist: playlist,
      detail: detail,
    );

    return ListView(
      children: [
        _Header(
          title: playlist.name,
          subtitle: '${playlist.songCount} songs',
          image: CardClip(
            child: const PlaceholderArt(),
          ),
        ),
        const SizedBox(height: 8),
        for (var action in downloadActions)
          _DownloadAction(key: ValueKey(action.type), downloadAction: action),
      ],
    );
  }
}

class SongContextMenu extends HookConsumerWidget {
  final Song song;
  final AlbumDetail? albumDetail;

  const SongContextMenu({
    super.key,
    required this.song,
    this.albumDetail,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final downloadActions = useSongDownloadActions(
      context: context,
      ref: ref,
      song: song,
      detail: albumDetail,
    );

    return ListView(
      children: [
        _Header(
          title: song.title,
          subtitle: song.artist,
          image: CardClip(child: CoverArt(coverArt: song.coverArt, albumId: song.albumId)),
        ),
        const SizedBox(height: 8),
        for (var action in downloadActions)
          _DownloadAction(key: ValueKey(action.type), downloadAction: action),
        if (song.artistId != null)
          _MenuItem(
            title: 'View artist',
            icon: const Icon(Icons.person_rounded),
            onTap: () async {
              final router = context.router;
              router.pop();
              router.navigate(ArtistRoute(id: song.artistId!));
            },
          ),
        if (song.albumId != null)
          _MenuItem(
            title: 'View album',
            icon: const Icon(Icons.album_rounded),
            onTap: () async {
              final router = context.router;
              router.pop();
              router.navigate(AlbumSongsRoute(id: song.albumId!));
            },
          ),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget image;

  const _Header({
    required this.title,
    this.subtitle,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 80, width: 80, child: image),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: theme.textTheme.titleLarge),
                if (subtitle != null)
                  Text(subtitle!, style: theme.textTheme.titleSmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DownloadAction extends HookConsumerWidget {
  final DownloadAction downloadAction;

  const _DownloadAction({
    super.key,
    required this.downloadAction,
  });

  String _actionText(DownloadActionType type) {
    switch (type) {
      case DownloadActionType.download:
        return 'Download';
      case DownloadActionType.cancel:
        return 'Cancel download';
      case DownloadActionType.delete:
        return 'Remove downloads';
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _MenuItem(
      title: _actionText(downloadAction.type),
      icon: downloadAction.iconBuilder(context),
      onTap: downloadAction.action,
    );
  }
}

class _MenuItem extends StatelessWidget {
  final String title;
  final Widget icon;
  final FutureOr<void> Function()? onTap;

  const _MenuItem({
    required this.title,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: Padding(
        padding: const EdgeInsetsDirectional.only(start: 8),
        child: icon,
      ),
      onTap: onTap,
    );
  }
}
