import 'package:auto_route/auto_route.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../models/music.dart';
import '../../state/remote_library.dart';
import '../app_router.dart';
import '../items.dart';

@RoutePage()
class ArtistPage extends HookConsumerWidget {
  final String id;
  final Artist? artist;

  const ArtistPage({
    super.key,
    @pathParam required this.id,
    this.artist,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(remoteArtistDetailProvider(id), (_, next) {
      final detail = next.value;
      if (detail == null) return;
      final coverArtId = detail.albums.firstOrNull?.coverArt;
      if (coverArtId != null) {
        ref.read(artistArtIndexProvider.notifier).set(id, coverArtId);
      }
      // Populate the badge memo so the Artists-tab tile badge never refetches.
      ref.read(artistBadgeIndexProvider.notifier).set(
            id,
            ArtistBadge(
              total: detail.albums.fold<int>(0, (sum, a) => sum + a.songCount),
              albumIds: detail.albums.map((a) => a.id).toISet(),
            ),
          );
    });

    final detail = ref.watch(remoteArtistDetailProvider(id));
    final name = detail.value?.artist.name ?? artist?.name ?? '';
    final albums = ref.watch(albumsByArtistIdProvider(id)).value;

    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: albums == null
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
              ),
              itemCount: albums.length,
              itemBuilder: (context, index) {
                final album = albums[index];
                return AlbumCard(
                  album: album,
                  onTap: () =>
                      context.pushRoute(AlbumSongsRoute(id: album.id, album: album)),
                );
              },
            ),
    );
  }
}
