import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../state/remote_library.dart';
import '../app_router.dart';
import '../hooks/use_list_query_paging_controller.dart';
import '../items.dart';
import '../lists.dart';
import 'library_page.dart';

@RoutePage()
class LibraryArtistsPage extends HookConsumerWidget {
  const LibraryArtistsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pagingController = useLibraryPagingController(
      ref,
      libraryTabIndex: 1,
      getItems: (query) {
        final search = ref.read(librarySearchQueryProvider);
        if (search.isNotEmpty) {
          return ref.read(remoteArtistSearchProvider(
            query: search,
            page: query.page,
          ).future);
        }
        return ref.read(remoteArtistListProvider(query).future);
      },
    );

    return PagedListQueryView(
      pagingController: pagingController,
      refreshRemote: true,
      itemBuilder: (context, item, index) => ArtistListTile(
        artist: item,
        onTap: () => context.navigateTo(ArtistRoute(id: item.id, artist: item)),
      ),
    );
  }
}
