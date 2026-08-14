import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../state/server.dart';
import 'items.dart';
import 'ui.dart';

class PagedListQueryView<T> extends HookConsumerWidget {
  final PagingController<int, T> pagingController;
  final bool refreshRemote;
  final bool fabPadding;
  final bool useSliver;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;

  const PagedListQueryView({
    super.key,
    required this.pagingController,
    this.refreshRemote = false,
    this.fabPadding = true,
    this.useSliver = false,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final builderDelegate = PagedChildBuilderDelegate<T>(
      itemBuilder: (context, item, index) => itemBuilder(context, item, index),
      noMoreItemsIndicatorBuilder:
          fabPadding ? (context) => const FabPadding() : null,
    );

    return PagingListener<int, T>(
      controller: pagingController,
      builder: (context, state, fetchNextPage) {
        final listView = useSliver
            ? PagedSliverList<int, T>(
                state: state,
                fetchNextPage: fetchNextPage,
                builderDelegate: builderDelegate,
              )
            : PagedListView<int, T>(
                state: state,
                fetchNextPage: fetchNextPage,
                builderDelegate: builderDelegate,
              );

        if (refreshRemote) {
          return RemoteRefresh(child: listView);
        } else {
          return listView;
        }
      },
    );
  }
}

enum GridSize {
  small,
  large,
}

class PagedGridQueryView<T> extends HookConsumerWidget {
  final PagingController<int, T> pagingController;
  final bool refreshRemote;
  final bool fabPadding;
  final GridSize size;
  final Widget Function(BuildContext context, T item, int index, GridSize size)
      itemBuilder;

  const PagedGridQueryView({
    super.key,
    required this.pagingController,
    this.refreshRemote = false,
    this.fabPadding = true,
    this.size = GridSize.small,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SliverGridDelegate gridDelegate;
    double spacing;

    if (size == GridSize.small) {
      spacing = 4;
      gridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: spacing,
        crossAxisSpacing: spacing,
      );
    } else {
      spacing = 12;
      gridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: spacing,
        crossAxisSpacing: spacing,
      );
    }

    return PagingListener<int, T>(
      controller: pagingController,
      builder: (context, state, fetchNextPage) {
        final listView = PagedGridView<int, T>(
          padding: MediaQuery.of(context).padding + EdgeInsets.all(spacing),
          state: state,
          fetchNextPage: fetchNextPage,
          builderDelegate: PagedChildBuilderDelegate(
            itemBuilder: (context, item, index) =>
                itemBuilder(context, item, index, size),
            noMoreItemsIndicatorBuilder:
                fabPadding ? (context) => const FabPadding() : null,
          ),
          gridDelegate: gridDelegate,
          showNoMoreItemsIndicatorAsGridChild: false,
        );

        if (refreshRemote) {
          return RemoteRefresh(child: listView);
        } else {
          return listView;
        }
      },
    );
  }
}

class RemoteRefresh extends HookConsumerWidget {
  final Widget child;

  const RemoteRefresh({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RefreshIndicator(
      onRefresh: () async {
        try {
          await ref.read(libraryRefreshProvider.notifier).refresh();
        } catch (e) {
          if (context.mounted) {
            showErrorSnackbar(context, e.toString());
          }
        }
      },
      child: child,
    );
  }
}
