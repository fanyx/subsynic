// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'library_page.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LibrarySearch)
final librarySearchProvider = LibrarySearchProvider._();

final class LibrarySearchProvider
    extends $NotifierProvider<LibrarySearch, String> {
  LibrarySearchProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'librarySearchProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$librarySearchHash();

  @$internal
  @override
  LibrarySearch create() => LibrarySearch();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$librarySearchHash() => r'cf75faaf8185b08759b0829292e3de7a65bc1d7e';

abstract class _$LibrarySearch extends $Notifier<String> {
  String build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<String, String>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String, String>,
              String,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(LibrarySearchQuery)
final librarySearchQueryProvider = LibrarySearchQueryProvider._();

final class LibrarySearchQueryProvider
    extends $NotifierProvider<LibrarySearchQuery, String> {
  LibrarySearchQueryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'librarySearchQueryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$librarySearchQueryHash();

  @$internal
  @override
  LibrarySearchQuery create() => LibrarySearchQuery();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$librarySearchQueryHash() =>
    r'c972c75c5aabacf9ce9249765bce5ef7a99b948d';

abstract class _$LibrarySearchQuery extends $Notifier<String> {
  String build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<String, String>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String, String>,
              String,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(LibraryLists)
final libraryListsProvider = LibraryListsProvider._();

final class LibraryListsProvider
    extends $NotifierProvider<LibraryLists, IList<LibraryListQuery>> {
  LibraryListsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'libraryListsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$libraryListsHash();

  @$internal
  @override
  LibraryLists create() => LibraryLists();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IList<LibraryListQuery> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IList<LibraryListQuery>>(value),
    );
  }
}

String _$libraryListsHash() => r'dd9c4ae3bf98d8d81c484db9fbaa157c3267ab6a';

abstract class _$LibraryLists extends $Notifier<IList<LibraryListQuery>> {
  IList<LibraryListQuery> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<IList<LibraryListQuery>, IList<LibraryListQuery>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<IList<LibraryListQuery>, IList<LibraryListQuery>>,
              IList<LibraryListQuery>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(libraryListQuery)
final libraryListQueryProvider = LibraryListQueryFamily._();

final class LibraryListQueryProvider
    extends
        $FunctionalProvider<
          LibraryListQuery,
          LibraryListQuery,
          LibraryListQuery
        >
    with $Provider<LibraryListQuery> {
  LibraryListQueryProvider._({
    required LibraryListQueryFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'libraryListQueryProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$libraryListQueryHash();

  @override
  String toString() {
    return r'libraryListQueryProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<LibraryListQuery> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  LibraryListQuery create(Ref ref) {
    final argument = this.argument as int;
    return libraryListQuery(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LibraryListQuery value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LibraryListQuery>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is LibraryListQueryProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$libraryListQueryHash() => r'204f29f0f5b43afd8d24515b88944b6ff4f9397e';

final class LibraryListQueryFamily extends $Family
    with $FunctionalFamilyOverride<LibraryListQuery, int> {
  LibraryListQueryFamily._()
    : super(
        retry: null,
        name: r'libraryListQueryProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  LibraryListQueryProvider call(int index) =>
      LibraryListQueryProvider._(argument: index, from: this);

  @override
  String toString() => r'libraryListQueryProvider';
}
