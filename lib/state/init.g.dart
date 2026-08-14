// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'init.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(router)
final routerProvider = RouterProvider._();

final class RouterProvider
    extends $FunctionalProvider<AppRouter, AppRouter, AppRouter>
    with $Provider<AppRouter> {
  RouterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'routerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$routerHash();

  @$internal
  @override
  $ProviderElement<AppRouter> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppRouter create(Ref ref) {
    return router(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppRouter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppRouter>(value),
    );
  }
}

String _$routerHash() => r'db972aab6a21ab97e4fc43503f981578819df2c2';

@ProviderFor(init)
final initProvider = InitProvider._();

final class InitProvider
    extends $FunctionalProvider<AsyncValue<void>, void, FutureOr<void>>
    with $FutureModifier<void>, $FutureProvider<void> {
  InitProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'initProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$initHash();

  @$internal
  @override
  $FutureProviderElement<void> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<void> create(Ref ref) {
    return init(ref);
  }
}

String _$initHash() => r'3f5c3c8e94ceb6c8158970deb2f3fa7fa029eee0';
