import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../database/database.dart';
import '../../models/query.dart';
import '../app_router.dart';
import '../ui.dart';

part 'library_page.g.dart';

@Riverpod(keepAlive: true)
class LibrarySearch extends _$LibrarySearch {
  Timer? _debounce;

  @override
  String build() => '';

  void setQuery(String query) {
    state = query;
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      ref.read(librarySearchQueryProvider.notifier).state = query;
    });
  }

  void clear() {
    _debounce?.cancel();
    state = '';
    ref.read(librarySearchQueryProvider.notifier).state = '';
  }
}

@Riverpod(keepAlive: true)
class LibrarySearchQuery extends _$LibrarySearchQuery {
  @override
  String build() => '';
}

@Riverpod(keepAlive: true)
class LibraryLists extends _$LibraryLists {
  @override
  IList<LibraryListQuery> build() {
    return const IListConst([
      /// Albums
      LibraryListQuery(
        options: ListQueryOptions(
          sortColumns: IListConst([
            'albums.name',
            'albums.album_artist',
            'albums.year',
          ]),
          filterColumns: IListConst([
            'albums.year',
          ]),
        ),
        query: ListQuery(
          page: Pagination(limit: 60),
          sort: SortBy(column: 'albums.name'),
        ),
      ),

      /// Artists
      LibraryListQuery(
        options: ListQueryOptions(
          sortColumns: IListConst([
            'artists.name',
            'artists.album_count',
          ]),
          filterColumns: IListConst([]),
        ),
        query: ListQuery(
          page: Pagination(limit: 30),
          sort: SortBy(column: 'artists.name'),
        ),
      ),

      /// Playlists
      LibraryListQuery(
        options: ListQueryOptions(
          sortColumns: IListConst([
            'playlists.name',
          ]),
          filterColumns: IListConst([
            'playlists.name',
          ]),
        ),
        query: ListQuery(
          page: Pagination(limit: 30),
          sort: SortBy(column: 'playlists.name'),
        ),
      ),
    ]);
  }

  Future<void> init() async {
    final db = ref.read(databaseProvider);
    final last = await db.getLastLibraryState().getSingleOrNull();
    if (last == null) {
      return;
    }

    state = state
        .replace(0, state[0].copyWith(query: last.albumsList))
        .replace(1, state[1].copyWith(query: last.artistsList))
        .replace(2, state[2].copyWith(query: last.playlistsList));
  }

  void setSortColumn(int index, String column) {
    state = state.replace(
      index,
      state[index].copyWith.query.sort!(column: column),
    );
  }

  void toggleDirection(int index) {
    final toggled = state[index].query.sort?.dir == SortDirection.asc
        ? SortDirection.desc
        : SortDirection.asc;
    state = state.replace(
      index,
      state[index].copyWith.query.sort!(dir: toggled),
    );
  }

  void setFilter(int index, FilterWith filter) {
    state = state.replace(
      index,
      state[index].copyWith.query(
            filters: state[index].query.filters.updateById(
              [filter],
              (e) => e.column,
            ),
          ),
    );
  }

  void removeFilter(int index, String column) {
    state = state.replace(
      index,
      state[index].copyWith.query(
          filters: state[index]
              .query
              .filters
              .removeWhere((f) => f.column == column)),
    );
  }

  void clearFilters(int index) {
    state = state.replace(index, state[index].copyWith.query(filters: IList()));
  }
}

@Riverpod(keepAlive: true)
LibraryListQuery libraryListQuery(Ref ref, int index) {
  return ref.watch(libraryListsProvider.select((value) => value[index]));
}

@RoutePage()
class LibraryTabsPage extends HookConsumerWidget {
  const LibraryTabsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final search = ref.watch(librarySearchProvider);
    final tabsRouter = AutoTabsRouter.of(context);

    return Scaffold(
      body: Column(
        children: [
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: SearchBar(
                hintText: 'Search library',
                leading: const Icon(Icons.search_rounded),
                trailing: search.isEmpty
                    ? null
                    : [
                        IconButton(
                          icon: const Icon(Icons.close_rounded),
                          onPressed: () => ref
                              .read(librarySearchProvider.notifier)
                              .clear(),
                        ),
                      ],
                onChanged: (value) => ref
                    .read(librarySearchProvider.notifier)
                    .setQuery(value),
              ),
            ),
          ),
          AutoTabsRouter.tabBar(
            routes: const [
              LibraryAlbumsRoute(),
              LibraryArtistsRoute(),
              LibraryPlaylistsRoute(),
            ],
            builder: (context, child, controller) {
              return Expanded(
                child: Column(
                  children: [
                    TabBar(
                      controller: controller,
                      tabs: const [
                        Tab(text: 'Albums'),
                        Tab(text: 'Artists'),
                        Tab(text: 'Playlists'),
                      ],
                    ),
                    Expanded(
                      child: Stack(
                        children: [
                          child,
                          PositionedDirectional(
                            end: 12,
                            bottom: 12,
                            child: FloatingActionButton.small(
                              heroTag: null,
                              tooltip: 'Sort / filter',
                              onPressed: () => showContextMenu(
                                context: context,
                                ref: ref,
                                builder: (context) => BottomSheetMenu(
                                  child: ListSortFilterOptions(
                                    index: tabsRouter.activeIndex,
                                  ),
                                ),
                              ),
                              child: const Icon(Icons.sort_rounded),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class ListSortFilterOptions extends HookConsumerWidget {
  final int index;

  const ListSortFilterOptions({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searching = ref.watch(librarySearchQueryProvider).isNotEmpty;
    if (searching) {
      return ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Text(
              'Sorting and filtering are unavailable while searching.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      );
    }

    final list = ref.watch(libraryListQueryProvider(index));

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Sort by',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        const SizedBox(height: 8),
        for (var column in list.options.sortColumns)
          SortOptionTile(
            column: column,
            value: list.query.sort!.copyWith(column: column),
            groupValue: list.query.sort!,
            onColumnChanged: (column) {
              if (column != null) {
                ref.read(libraryListsProvider.notifier).setSortColumn(index, column);
              }
            },
            onDirectionToggle: () =>
                ref.read(libraryListsProvider.notifier).toggleDirection(index),
          ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            'Filter',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        for (var column in list.options.filterColumns)
          FilterOptionTile(
            column: column,
            state: list.query.filters.singleWhereOrNull(
              (e) => e.column == column,
            ),
            onChanged: (value) {
              if (value == null || !value) {
                ref.read(libraryListsProvider.notifier).removeFilter(index, column);
              } else {
                ref.read(libraryListsProvider.notifier).setFilter(
                      index,
                      FilterWith.isNull(column: column, invert: true),
                    );
              }
            },
          ),
      ],
    );
  }
}

class SortOptionTile extends HookConsumerWidget {
  final String column;
  final SortBy value;
  final SortBy groupValue;
  final void Function(String? value) onColumnChanged;
  final void Function() onDirectionToggle;

  const SortOptionTile({
    super.key,
    required this.column,
    required this.value,
    required this.groupValue,
    required this.onColumnChanged,
    required this.onDirectionToggle,
  });

  String _sortTitle(String type) {
    switch (type) {
      case 'name':
        return 'Name';
      case 'album_artist':
        return 'Artist';
      case 'year':
        return 'Year';
      case 'album_count':
        return 'Album count';
      case 'album':
        return 'Album';
      case 'artist':
        return 'Artist';
      case 'title':
        return 'Title';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RadioGroup<String?>(
      groupValue: groupValue.column,
      onChanged: onColumnChanged,
      child: RadioListTile<String?>(
        value: value.column,
        selected: value.column == groupValue.column,
        title: Text(_sortTitle(column.split('.').last)),
        secondary: value.column == groupValue.column
            ? IconButton(
                icon: Icon(
                  value.dir == SortDirection.desc
                      ? Icons.arrow_upward_rounded
                      : Icons.arrow_downward_rounded,
                ),
                onPressed: onDirectionToggle,
              )
            : null,
      ),
    );
  }
}

class FilterOptionTile extends HookConsumerWidget {
  final String column;
  final FilterWith? state;
  final void Function(bool? value)? onChanged;

  const FilterOptionTile({
    super.key,
    required this.column,
    required this.state,
    required this.onChanged,
  });

  String _filterTitle(String type) {
    switch (type) {
      case 'year':
        return 'Year';
      case 'genre':
        return 'Genre';
      case 'album_artist':
        return 'Artist';
      case 'album':
        return 'Album';
      case 'artist':
        return 'Artist';
      case 'name':
        return 'Name';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CheckboxListTile(
      value: state != null,
      title: Text(_filterTitle(column.split('.').last)),
      controlAffinity: ListTileControlAffinity.leading,
      onChanged: onChanged,
    );
  }
}
