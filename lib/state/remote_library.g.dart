// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_library.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ArtistArtIndex)
final artistArtIndexProvider = ArtistArtIndexProvider._();

final class ArtistArtIndexProvider
    extends $NotifierProvider<ArtistArtIndex, Map<String, String?>> {
  ArtistArtIndexProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'artistArtIndexProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$artistArtIndexHash();

  @$internal
  @override
  ArtistArtIndex create() => ArtistArtIndex();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<String, String?> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<String, String?>>(value),
    );
  }
}

String _$artistArtIndexHash() => r'6e95471b2bd0df25eb094fc80d0207ed1069decf';

abstract class _$ArtistArtIndex extends $Notifier<Map<String, String?>> {
  Map<String, String?> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<Map<String, String?>, Map<String, String?>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Map<String, String?>, Map<String, String?>>,
              Map<String, String?>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(ArtistBadgeIndex)
final artistBadgeIndexProvider = ArtistBadgeIndexProvider._();

final class ArtistBadgeIndexProvider
    extends $NotifierProvider<ArtistBadgeIndex, Map<String, ArtistBadge>> {
  ArtistBadgeIndexProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'artistBadgeIndexProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$artistBadgeIndexHash();

  @$internal
  @override
  ArtistBadgeIndex create() => ArtistBadgeIndex();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<String, ArtistBadge> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<String, ArtistBadge>>(value),
    );
  }
}

String _$artistBadgeIndexHash() => r'0e3c1261eded7318cdfcb7ab77d79fe239c2f32c';

abstract class _$ArtistBadgeIndex extends $Notifier<Map<String, ArtistBadge>> {
  Map<String, ArtistBadge> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<Map<String, ArtistBadge>, Map<String, ArtistBadge>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Map<String, ArtistBadge>, Map<String, ArtistBadge>>,
              Map<String, ArtistBadge>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Memoized `PlaylistDetail`s (small count) so the Playlists-tab tile badge
/// survives scroll re-entry without a fresh `getPlaylist`.

@ProviderFor(PlaylistDetailMemo)
final playlistDetailMemoProvider = PlaylistDetailMemoProvider._();

/// Memoized `PlaylistDetail`s (small count) so the Playlists-tab tile badge
/// survives scroll re-entry without a fresh `getPlaylist`.
final class PlaylistDetailMemoProvider
    extends $NotifierProvider<PlaylistDetailMemo, Map<String, PlaylistDetail>> {
  /// Memoized `PlaylistDetail`s (small count) so the Playlists-tab tile badge
  /// survives scroll re-entry without a fresh `getPlaylist`.
  PlaylistDetailMemoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'playlistDetailMemoProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$playlistDetailMemoHash();

  @$internal
  @override
  PlaylistDetailMemo create() => PlaylistDetailMemo();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<String, PlaylistDetail> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<String, PlaylistDetail>>(value),
    );
  }
}

String _$playlistDetailMemoHash() =>
    r'529776da0a4596109a0868b1fab5c63d7bdd5bb1';

/// Memoized `PlaylistDetail`s (small count) so the Playlists-tab tile badge
/// survives scroll re-entry without a fresh `getPlaylist`.

abstract class _$PlaylistDetailMemo
    extends $Notifier<Map<String, PlaylistDetail>> {
  Map<String, PlaylistDetail> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<Map<String, PlaylistDetail>, Map<String, PlaylistDetail>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                Map<String, PlaylistDetail>,
                Map<String, PlaylistDetail>
              >,
              Map<String, PlaylistDetail>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(remoteAlbumList)
final remoteAlbumListProvider = RemoteAlbumListFamily._();

final class RemoteAlbumListProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Album>>,
          List<Album>,
          FutureOr<List<Album>>
        >
    with $FutureModifier<List<Album>>, $FutureProvider<List<Album>> {
  RemoteAlbumListProvider._({
    required RemoteAlbumListFamily super.from,
    required AlbumListRequest super.argument,
  }) : super(
         retry: null,
         name: r'remoteAlbumListProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$remoteAlbumListHash();

  @override
  String toString() {
    return r'remoteAlbumListProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Album>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Album>> create(Ref ref) {
    final argument = this.argument as AlbumListRequest;
    return remoteAlbumList(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is RemoteAlbumListProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$remoteAlbumListHash() => r'f8a6893cfc08113491c683dd6875ac6c6541fd4a';

final class RemoteAlbumListFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Album>>, AlbumListRequest> {
  RemoteAlbumListFamily._()
    : super(
        retry: null,
        name: r'remoteAlbumListProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  RemoteAlbumListProvider call(AlbumListRequest request) =>
      RemoteAlbumListProvider._(argument: request, from: this);

  @override
  String toString() => r'remoteAlbumListProvider';
}

@ProviderFor(allArtists)
final allArtistsProvider = AllArtistsProvider._();

final class AllArtistsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Artist>>,
          List<Artist>,
          FutureOr<List<Artist>>
        >
    with $FutureModifier<List<Artist>>, $FutureProvider<List<Artist>> {
  AllArtistsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'allArtistsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$allArtistsHash();

  @$internal
  @override
  $FutureProviderElement<List<Artist>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Artist>> create(Ref ref) {
    return allArtists(ref);
  }
}

String _$allArtistsHash() => r'266da300abcadc3c4454f5c74304fc0fe6a87169';

@ProviderFor(allPlaylists)
final allPlaylistsProvider = AllPlaylistsProvider._();

final class AllPlaylistsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Playlist>>,
          List<Playlist>,
          FutureOr<List<Playlist>>
        >
    with $FutureModifier<List<Playlist>>, $FutureProvider<List<Playlist>> {
  AllPlaylistsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'allPlaylistsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$allPlaylistsHash();

  @$internal
  @override
  $FutureProviderElement<List<Playlist>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Playlist>> create(Ref ref) {
    return allPlaylists(ref);
  }
}

String _$allPlaylistsHash() => r'632fc13465aa15e9b935bdafeb4560278e4b928c';

@ProviderFor(remoteArtistList)
final remoteArtistListProvider = RemoteArtistListFamily._();

final class RemoteArtistListProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Artist>>,
          List<Artist>,
          FutureOr<List<Artist>>
        >
    with $FutureModifier<List<Artist>>, $FutureProvider<List<Artist>> {
  RemoteArtistListProvider._({
    required RemoteArtistListFamily super.from,
    required ListQuery super.argument,
  }) : super(
         retry: null,
         name: r'remoteArtistListProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$remoteArtistListHash();

  @override
  String toString() {
    return r'remoteArtistListProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Artist>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Artist>> create(Ref ref) {
    final argument = this.argument as ListQuery;
    return remoteArtistList(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is RemoteArtistListProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$remoteArtistListHash() => r'73d3ced7e3e7cb8e7902329bb818d564bb5dec49';

final class RemoteArtistListFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Artist>>, ListQuery> {
  RemoteArtistListFamily._()
    : super(
        retry: null,
        name: r'remoteArtistListProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  RemoteArtistListProvider call(ListQuery query) =>
      RemoteArtistListProvider._(argument: query, from: this);

  @override
  String toString() => r'remoteArtistListProvider';
}

@ProviderFor(remotePlaylistList)
final remotePlaylistListProvider = RemotePlaylistListFamily._();

final class RemotePlaylistListProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Playlist>>,
          List<Playlist>,
          FutureOr<List<Playlist>>
        >
    with $FutureModifier<List<Playlist>>, $FutureProvider<List<Playlist>> {
  RemotePlaylistListProvider._({
    required RemotePlaylistListFamily super.from,
    required ListQuery super.argument,
  }) : super(
         retry: null,
         name: r'remotePlaylistListProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$remotePlaylistListHash();

  @override
  String toString() {
    return r'remotePlaylistListProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Playlist>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Playlist>> create(Ref ref) {
    final argument = this.argument as ListQuery;
    return remotePlaylistList(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is RemotePlaylistListProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$remotePlaylistListHash() =>
    r'8593f304cb9c7cdbacc5f0f0fbbfd48b42eb42ee';

final class RemotePlaylistListFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Playlist>>, ListQuery> {
  RemotePlaylistListFamily._()
    : super(
        retry: null,
        name: r'remotePlaylistListProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  RemotePlaylistListProvider call(ListQuery query) =>
      RemotePlaylistListProvider._(argument: query, from: this);

  @override
  String toString() => r'remotePlaylistListProvider';
}

@ProviderFor(remoteAlbumSearch)
final remoteAlbumSearchProvider = RemoteAlbumSearchFamily._();

final class RemoteAlbumSearchProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Album>>,
          List<Album>,
          FutureOr<List<Album>>
        >
    with $FutureModifier<List<Album>>, $FutureProvider<List<Album>> {
  RemoteAlbumSearchProvider._({
    required RemoteAlbumSearchFamily super.from,
    required ({String query, Pagination page}) super.argument,
  }) : super(
         retry: null,
         name: r'remoteAlbumSearchProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$remoteAlbumSearchHash();

  @override
  String toString() {
    return r'remoteAlbumSearchProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<List<Album>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Album>> create(Ref ref) {
    final argument = this.argument as ({String query, Pagination page});
    return remoteAlbumSearch(ref, query: argument.query, page: argument.page);
  }

  @override
  bool operator ==(Object other) {
    return other is RemoteAlbumSearchProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$remoteAlbumSearchHash() => r'd9292e808dcb5cf4a2eb0842e26a4b2341477efb';

final class RemoteAlbumSearchFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<List<Album>>,
          ({String query, Pagination page})
        > {
  RemoteAlbumSearchFamily._()
    : super(
        retry: null,
        name: r'remoteAlbumSearchProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  RemoteAlbumSearchProvider call({
    required String query,
    required Pagination page,
  }) => RemoteAlbumSearchProvider._(
    argument: (query: query, page: page),
    from: this,
  );

  @override
  String toString() => r'remoteAlbumSearchProvider';
}

@ProviderFor(remoteArtistSearch)
final remoteArtistSearchProvider = RemoteArtistSearchFamily._();

final class RemoteArtistSearchProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Artist>>,
          List<Artist>,
          FutureOr<List<Artist>>
        >
    with $FutureModifier<List<Artist>>, $FutureProvider<List<Artist>> {
  RemoteArtistSearchProvider._({
    required RemoteArtistSearchFamily super.from,
    required ({String query, Pagination page}) super.argument,
  }) : super(
         retry: null,
         name: r'remoteArtistSearchProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$remoteArtistSearchHash();

  @override
  String toString() {
    return r'remoteArtistSearchProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<List<Artist>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Artist>> create(Ref ref) {
    final argument = this.argument as ({String query, Pagination page});
    return remoteArtistSearch(ref, query: argument.query, page: argument.page);
  }

  @override
  bool operator ==(Object other) {
    return other is RemoteArtistSearchProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$remoteArtistSearchHash() =>
    r'541c1b2a4f63a880fc0a3dca3e6355595c95ad7a';

final class RemoteArtistSearchFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<List<Artist>>,
          ({String query, Pagination page})
        > {
  RemoteArtistSearchFamily._()
    : super(
        retry: null,
        name: r'remoteArtistSearchProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  RemoteArtistSearchProvider call({
    required String query,
    required Pagination page,
  }) => RemoteArtistSearchProvider._(
    argument: (query: query, page: page),
    from: this,
  );

  @override
  String toString() => r'remoteArtistSearchProvider';
}

@ProviderFor(remotePlaylistSearch)
final remotePlaylistSearchProvider = RemotePlaylistSearchFamily._();

final class RemotePlaylistSearchProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Playlist>>,
          List<Playlist>,
          FutureOr<List<Playlist>>
        >
    with $FutureModifier<List<Playlist>>, $FutureProvider<List<Playlist>> {
  RemotePlaylistSearchProvider._({
    required RemotePlaylistSearchFamily super.from,
    required ({String query, Pagination page}) super.argument,
  }) : super(
         retry: null,
         name: r'remotePlaylistSearchProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$remotePlaylistSearchHash();

  @override
  String toString() {
    return r'remotePlaylistSearchProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<List<Playlist>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Playlist>> create(Ref ref) {
    final argument = this.argument as ({String query, Pagination page});
    return remotePlaylistSearch(
      ref,
      query: argument.query,
      page: argument.page,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is RemotePlaylistSearchProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$remotePlaylistSearchHash() =>
    r'22e3f7128cf4b2c6e4936b3c555f8b8e743c3b44';

final class RemotePlaylistSearchFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<List<Playlist>>,
          ({String query, Pagination page})
        > {
  RemotePlaylistSearchFamily._()
    : super(
        retry: null,
        name: r'remotePlaylistSearchProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  RemotePlaylistSearchProvider call({
    required String query,
    required Pagination page,
  }) => RemotePlaylistSearchProvider._(
    argument: (query: query, page: page),
    from: this,
  );

  @override
  String toString() => r'remotePlaylistSearchProvider';
}

@ProviderFor(remoteAlbumDetail)
final remoteAlbumDetailProvider = RemoteAlbumDetailFamily._();

final class RemoteAlbumDetailProvider
    extends
        $FunctionalProvider<
          AsyncValue<AlbumDetail>,
          AlbumDetail,
          FutureOr<AlbumDetail>
        >
    with $FutureModifier<AlbumDetail>, $FutureProvider<AlbumDetail> {
  RemoteAlbumDetailProvider._({
    required RemoteAlbumDetailFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'remoteAlbumDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$remoteAlbumDetailHash();

  @override
  String toString() {
    return r'remoteAlbumDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<AlbumDetail> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<AlbumDetail> create(Ref ref) {
    final argument = this.argument as String;
    return remoteAlbumDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is RemoteAlbumDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$remoteAlbumDetailHash() => r'803b791096a22930ae45f80229bfb7f761aea2be';

final class RemoteAlbumDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<AlbumDetail>, String> {
  RemoteAlbumDetailFamily._()
    : super(
        retry: null,
        name: r'remoteAlbumDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  RemoteAlbumDetailProvider call(String id) =>
      RemoteAlbumDetailProvider._(argument: id, from: this);

  @override
  String toString() => r'remoteAlbumDetailProvider';
}

@ProviderFor(remoteArtistDetail)
final remoteArtistDetailProvider = RemoteArtistDetailFamily._();

final class RemoteArtistDetailProvider
    extends
        $FunctionalProvider<
          AsyncValue<ArtistDetail>,
          ArtistDetail,
          FutureOr<ArtistDetail>
        >
    with $FutureModifier<ArtistDetail>, $FutureProvider<ArtistDetail> {
  RemoteArtistDetailProvider._({
    required RemoteArtistDetailFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'remoteArtistDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$remoteArtistDetailHash();

  @override
  String toString() {
    return r'remoteArtistDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<ArtistDetail> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<ArtistDetail> create(Ref ref) {
    final argument = this.argument as String;
    return remoteArtistDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is RemoteArtistDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$remoteArtistDetailHash() =>
    r'79be5e97b9f7ab38d1b3986f41dc8807efac27e8';

final class RemoteArtistDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<ArtistDetail>, String> {
  RemoteArtistDetailFamily._()
    : super(
        retry: null,
        name: r'remoteArtistDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  RemoteArtistDetailProvider call(String id) =>
      RemoteArtistDetailProvider._(argument: id, from: this);

  @override
  String toString() => r'remoteArtistDetailProvider';
}

@ProviderFor(remotePlaylistDetail)
final remotePlaylistDetailProvider = RemotePlaylistDetailFamily._();

final class RemotePlaylistDetailProvider
    extends
        $FunctionalProvider<
          AsyncValue<PlaylistDetail>,
          PlaylistDetail,
          FutureOr<PlaylistDetail>
        >
    with $FutureModifier<PlaylistDetail>, $FutureProvider<PlaylistDetail> {
  RemotePlaylistDetailProvider._({
    required RemotePlaylistDetailFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'remotePlaylistDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$remotePlaylistDetailHash();

  @override
  String toString() {
    return r'remotePlaylistDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<PlaylistDetail> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<PlaylistDetail> create(Ref ref) {
    final argument = this.argument as String;
    return remotePlaylistDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is RemotePlaylistDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$remotePlaylistDetailHash() =>
    r'fb0a0adbd894cc3a3c088a530ec6b8cf9cfbac68';

final class RemotePlaylistDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<PlaylistDetail>, String> {
  RemotePlaylistDetailFamily._()
    : super(
        retry: null,
        name: r'remotePlaylistDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  RemotePlaylistDetailProvider call(String id) =>
      RemotePlaylistDetailProvider._(argument: id, from: this);

  @override
  String toString() => r'remotePlaylistDetailProvider';
}

@ProviderFor(artistCoverArt)
final artistCoverArtProvider = ArtistCoverArtFamily._();

final class ArtistCoverArtProvider
    extends $FunctionalProvider<AsyncValue<String?>, String?, FutureOr<String?>>
    with $FutureModifier<String?>, $FutureProvider<String?> {
  ArtistCoverArtProvider._({
    required ArtistCoverArtFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'artistCoverArtProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$artistCoverArtHash();

  @override
  String toString() {
    return r'artistCoverArtProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<String?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<String?> create(Ref ref) {
    final argument = this.argument as String;
    return artistCoverArt(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ArtistCoverArtProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$artistCoverArtHash() => r'800ac1c2b8965646915d02fd6752472943e2b424';

final class ArtistCoverArtFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<String?>, String> {
  ArtistCoverArtFamily._()
    : super(
        retry: null,
        name: r'artistCoverArtProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ArtistCoverArtProvider call(String artistId) =>
      ArtistCoverArtProvider._(argument: artistId, from: this);

  @override
  String toString() => r'artistCoverArtProvider';
}

@ProviderFor(albumsByArtistId)
final albumsByArtistIdProvider = AlbumsByArtistIdFamily._();

final class AlbumsByArtistIdProvider
    extends
        $FunctionalProvider<
          AsyncValue<IList<Album>>,
          IList<Album>,
          FutureOr<IList<Album>>
        >
    with $FutureModifier<IList<Album>>, $FutureProvider<IList<Album>> {
  AlbumsByArtistIdProvider._({
    required AlbumsByArtistIdFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'albumsByArtistIdProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$albumsByArtistIdHash();

  @override
  String toString() {
    return r'albumsByArtistIdProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<IList<Album>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<IList<Album>> create(Ref ref) {
    final argument = this.argument as String;
    return albumsByArtistId(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is AlbumsByArtistIdProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$albumsByArtistIdHash() => r'444df967ae67918ba8618d9ffa95101c6332541c';

final class AlbumsByArtistIdFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<IList<Album>>, String> {
  AlbumsByArtistIdFamily._()
    : super(
        retry: null,
        name: r'albumsByArtistIdProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  AlbumsByArtistIdProvider call(String id) =>
      AlbumsByArtistIdProvider._(argument: id, from: this);

  @override
  String toString() => r'albumsByArtistIdProvider';
}
