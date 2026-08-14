// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(musicSource)
final musicSourceProvider = MusicSourceProvider._();

final class MusicSourceProvider
    extends
        $FunctionalProvider<
          BaseMusicSource?,
          BaseMusicSource?,
          BaseMusicSource?
        >
    with $Provider<BaseMusicSource?> {
  MusicSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'musicSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$musicSourceHash();

  @$internal
  @override
  $ProviderElement<BaseMusicSource?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  BaseMusicSource? create(Ref ref) {
    return musicSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BaseMusicSource? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BaseMusicSource?>(value),
    );
  }
}

String _$musicSourceHash() => r'5a33c8a5b85fd6ad530c984e99af53f5c46af7c9';

@ProviderFor(LibraryRefresh)
final libraryRefreshProvider = LibraryRefreshProvider._();

final class LibraryRefreshProvider
    extends $NotifierProvider<LibraryRefresh, DateTime> {
  LibraryRefreshProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'libraryRefreshProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$libraryRefreshHash();

  @$internal
  @override
  LibraryRefresh create() => LibraryRefresh();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DateTime value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DateTime>(value),
    );
  }
}

String _$libraryRefreshHash() => r'a46446346804e605f2f07beb185edbd379333319';

abstract class _$LibraryRefresh extends $Notifier<DateTime> {
  DateTime build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<DateTime, DateTime>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<DateTime, DateTime>,
              DateTime,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(coverCacheBuster)
final coverCacheBusterProvider = CoverCacheBusterProvider._();

final class CoverCacheBusterProvider
    extends $FunctionalProvider<String, String, String>
    with $Provider<String> {
  CoverCacheBusterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'coverCacheBusterProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$coverCacheBusterHash();

  @$internal
  @override
  $ProviderElement<String> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  String create(Ref ref) {
    return coverCacheBuster(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$coverCacheBusterHash() => r'4f52bddcbe87efe9abf32c676ddf9f1cfa6c133c';
