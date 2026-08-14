import 'dart:async';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../models/query.dart';
import '../../state/server.dart';
import '../pages/library_page.dart';
import 'use_paging_controller.dart';

PagingController<int, T> useLibraryPagingController<T>(
  WidgetRef ref, {
  required int libraryTabIndex,
  required FutureOr<List<T>> Function(ListQuery query) getItems,
}) {
  final queryProvider = libraryListQueryProvider(libraryTabIndex).select(
    (value) => value.query,
  );
  final query = useState(ref.read(queryProvider));

  final controller = usePagingController<int, T>(
    firstPageKey: query.value.page.offset,
    fetchPage: (pageKey) =>
        getItems(query.value.copyWith.page(offset: pageKey)),
    getNextPageKey: (state) => _nextPageKey(query.value, state),
  );

  ref.listen(queryProvider, (_, next) {
    query.value = next;
    controller.refresh();
  });

  ref.listen(libraryRefreshProvider, (_, _) => controller.refresh());
  ref.listen(librarySearchQueryProvider, (_, _) => controller.refresh());

  return controller;
}

PagingController<int, T> useListQueryPagingController<T>(
  WidgetRef ref, {
  required ListQuery query,
  required FutureOr<List<T>> Function(ListQuery query) getItems,
}) {
  return usePagingController<int, T>(
    firstPageKey: query.page.offset,
    fetchPage: (pageKey) => getItems(query.copyWith.page(offset: pageKey)),
    getNextPageKey: (state) => _nextPageKey(query, state),
  );
}

int? _nextPageKey<T>(ListQuery query, PagingState<int, T> state) {
  final pages = state.pages;
  if (pages == null || pages.isEmpty) {
    return query.page.offset;
  }

  final lastPage = pages.last;
  if (lastPage.isEmpty) return null;

  final limit = query.page.limit;
  if (limit <= 0) return null;

  // A page shorter than the limit marks the last page.
  if (lastPage.length < limit) return null;

  return state.items?.length;
}
