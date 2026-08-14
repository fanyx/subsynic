// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'library_scan.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LibraryScanService)
final libraryScanServiceProvider = LibraryScanServiceProvider._();

final class LibraryScanServiceProvider
    extends $NotifierProvider<LibraryScanService, bool> {
  LibraryScanServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'libraryScanServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$libraryScanServiceHash();

  @$internal
  @override
  LibraryScanService create() => LibraryScanService();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$libraryScanServiceHash() =>
    r'a7b2e7d354ec0bc6357dea3c2807ed8a0bc18b7c';

abstract class _$LibraryScanService extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
