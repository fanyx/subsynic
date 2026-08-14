import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../services/remote_query_mapper.dart';
import '../../state/remote_library.dart';
import '../app_router.dart';
import '../hooks/use_list_query_paging_controller.dart';
import '../items.dart';
import '../lists.dart';
import 'library_page.dart';

@RoutePage()
class LibraryAlbumsPage extends HookConsumerWidget {
  const LibraryAlbumsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pagingController = useLibraryPagingController(
      ref,
      libraryTabIndex: 0,
      getItems: (query) {
        final search = ref.read(librarySearchQueryProvider);
        if (search.isNotEmpty) {
          return ref.read(remoteAlbumSearchProvider(
            query: search,
            page: query.page,
          ).future);
        }
        return ref.read(remoteAlbumListProvider(mapAlbumsQuery(query)).future);
      },
    );

    return PagedGridQueryView(
      pagingController: pagingController,
      refreshRemote: true,
      itemBuilder: (context, item, index, size) => AlbumCard(
        album: item,
        style:
            size == GridSize.small ? CardStyle.imageOnly : CardStyle.withText,
        onTap: () => context.navigateTo(AlbumSongsRoute(id: item.id, album: item)),
      ),
    );
  }
}
