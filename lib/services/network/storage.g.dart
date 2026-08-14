// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'storage.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(saf)
final safProvider = SafProvider._();

final class SafProvider extends $FunctionalProvider<Saf, Saf, Saf>
    with $Provider<Saf> {
  SafProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'safProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$safHash();

  @$internal
  @override
  $ProviderElement<Saf> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Saf create(Ref ref) {
    return saf(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Saf value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Saf>(value),
    );
  }
}

String _$safHash() => r'0d83a4a230a2efa25d1683e16990285f3781dc6f';

@ProviderFor(storage)
final storageProvider = StorageProvider._();

final class StorageProvider
    extends $FunctionalProvider<LibraryStorage, LibraryStorage, LibraryStorage>
    with $Provider<LibraryStorage> {
  StorageProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'storageProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$storageHash();

  @$internal
  @override
  $ProviderElement<LibraryStorage> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  LibraryStorage create(Ref ref) {
    return storage(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LibraryStorage value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LibraryStorage>(value),
    );
  }
}

String _$storageHash() => r'853308b7f4dc2d97575c1d80abe7e2602a43ef5b';
