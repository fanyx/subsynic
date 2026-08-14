import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

PagingController<PageKeyType, ItemType>
    usePagingController<PageKeyType, ItemType>({
  required final PageKeyType firstPageKey,
  required final FutureOr<List<ItemType>> Function(PageKeyType pageKey)
      fetchPage,
  required final PageKeyType? Function(
      PagingState<PageKeyType, ItemType> state) getNextPageKey,
  List<Object?>? keys,
}) {
  final controller = use(
    _PagingControllerHook<PageKeyType, ItemType>(
      firstPageKey: firstPageKey,
      fetchPage: fetchPage,
      getNextPageKey: getNextPageKey,
      keys: keys,
    ),
  );

  return controller;
}

class _PagingControllerHook<PageKeyType, ItemType>
    extends Hook<PagingController<PageKeyType, ItemType>> {
  const _PagingControllerHook({
    required this.firstPageKey,
    required this.fetchPage,
    required this.getNextPageKey,
    super.keys,
  });

  final PageKeyType firstPageKey;
  final FutureOr<List<ItemType>> Function(PageKeyType pageKey) fetchPage;
  final PageKeyType? Function(PagingState<PageKeyType, ItemType> state)
      getNextPageKey;

  @override
  HookState<PagingController<PageKeyType, ItemType>,
          Hook<PagingController<PageKeyType, ItemType>>>
      createState() => _PagingControllerHookState<PageKeyType, ItemType>();
}

class _PagingControllerHookState<PageKeyType, ItemType> extends HookState<
    PagingController<PageKeyType, ItemType>,
    _PagingControllerHook<PageKeyType, ItemType>> {
  late final controller = PagingController<PageKeyType, ItemType>(
    getNextPageKey: hook.getNextPageKey,
    fetchPage: hook.fetchPage,
  );

  @override
  PagingController<PageKeyType, ItemType> build(BuildContext context) =>
      controller;

  @override
  void dispose() => controller.dispose();

  @override
  String get debugLabel => 'usePagingController';
}
