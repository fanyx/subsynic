// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'presence.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(downloadCountsByAlbum)
final downloadCountsByAlbumProvider = DownloadCountsByAlbumProvider._();

final class DownloadCountsByAlbumProvider
    extends
        $FunctionalProvider<
          AsyncValue<IMap<String, DownloadCounts>>,
          IMap<String, DownloadCounts>,
          Stream<IMap<String, DownloadCounts>>
        >
    with
        $FutureModifier<IMap<String, DownloadCounts>>,
        $StreamProvider<IMap<String, DownloadCounts>> {
  DownloadCountsByAlbumProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'downloadCountsByAlbumProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$downloadCountsByAlbumHash();

  @$internal
  @override
  $StreamProviderElement<IMap<String, DownloadCounts>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<IMap<String, DownloadCounts>> create(Ref ref) {
    return downloadCountsByAlbum(ref);
  }
}

String _$downloadCountsByAlbumHash() =>
    r'f4703a4d296ff131c90c86f04c222a7d1b0f809d';

@ProviderFor(songDownloadsByIds)
final songDownloadsByIdsProvider = SongDownloadsByIdsFamily._();

final class SongDownloadsByIdsProvider
    extends
        $FunctionalProvider<
          AsyncValue<IList<SongDownload>>,
          IList<SongDownload>,
          Stream<IList<SongDownload>>
        >
    with
        $FutureModifier<IList<SongDownload>>,
        $StreamProvider<IList<SongDownload>> {
  SongDownloadsByIdsProvider._({
    required SongDownloadsByIdsFamily super.from,
    required IList<String> super.argument,
  }) : super(
         retry: null,
         name: r'songDownloadsByIdsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$songDownloadsByIdsHash();

  @override
  String toString() {
    return r'songDownloadsByIdsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<IList<SongDownload>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<IList<SongDownload>> create(Ref ref) {
    final argument = this.argument as IList<String>;
    return songDownloadsByIds(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is SongDownloadsByIdsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$songDownloadsByIdsHash() =>
    r'4a4ed573fba7e5a8627da1041c12c4e5ceb97a80';

final class SongDownloadsByIdsFamily extends $Family
    with $FunctionalFamilyOverride<Stream<IList<SongDownload>>, IList<String>> {
  SongDownloadsByIdsFamily._()
    : super(
        retry: null,
        name: r'songDownloadsByIdsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  SongDownloadsByIdsProvider call(IList<String> ids) =>
      SongDownloadsByIdsProvider._(argument: ids, from: this);

  @override
  String toString() => r'songDownloadsByIdsProvider';
}

@ProviderFor(songPresence)
final songPresenceProvider = SongPresenceFamily._();

final class SongPresenceProvider
    extends
        $FunctionalProvider<
          AsyncValue<SongDownload?>,
          SongDownload?,
          Stream<SongDownload?>
        >
    with $FutureModifier<SongDownload?>, $StreamProvider<SongDownload?> {
  SongPresenceProvider._({
    required SongPresenceFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'songPresenceProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$songPresenceHash();

  @override
  String toString() {
    return r'songPresenceProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<SongDownload?> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<SongDownload?> create(Ref ref) {
    final argument = this.argument as String;
    return songPresence(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is SongPresenceProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$songPresenceHash() => r'dd025fb25de6fb9dce061392d697064fc97cda41';

final class SongPresenceFamily extends $Family
    with $FunctionalFamilyOverride<Stream<SongDownload?>, String> {
  SongPresenceFamily._()
    : super(
        retry: null,
        name: r'songPresenceProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  SongPresenceProvider call(String songId) =>
      SongPresenceProvider._(argument: songId, from: this);

  @override
  String toString() => r'songPresenceProvider';
}

@ProviderFor(albumCoverPath)
final albumCoverPathProvider = AlbumCoverPathFamily._();

final class AlbumCoverPathProvider
    extends $FunctionalProvider<AsyncValue<String?>, String?, Stream<String?>>
    with $FutureModifier<String?>, $StreamProvider<String?> {
  AlbumCoverPathProvider._({
    required AlbumCoverPathFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'albumCoverPathProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$albumCoverPathHash();

  @override
  String toString() {
    return r'albumCoverPathProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<String?> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<String?> create(Ref ref) {
    final argument = this.argument as String;
    return albumCoverPath(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is AlbumCoverPathProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$albumCoverPathHash() => r'beb9159f669f280d3008c2827e33a0277e5e56a3';

final class AlbumCoverPathFamily extends $Family
    with $FunctionalFamilyOverride<Stream<String?>, String> {
  AlbumCoverPathFamily._()
    : super(
        retry: null,
        name: r'albumCoverPathProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  AlbumCoverPathProvider call(String albumId) =>
      AlbumCoverPathProvider._(argument: albumId, from: this);

  @override
  String toString() => r'albumCoverPathProvider';
}

@ProviderFor(albumDownloadStatus)
final albumDownloadStatusProvider = AlbumDownloadStatusFamily._();

final class AlbumDownloadStatusProvider
    extends
        $FunctionalProvider<
          AsyncValue<ListDownloadStatus>,
          ListDownloadStatus,
          Stream<ListDownloadStatus>
        >
    with
        $FutureModifier<ListDownloadStatus>,
        $StreamProvider<ListDownloadStatus> {
  AlbumDownloadStatusProvider._({
    required AlbumDownloadStatusFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'albumDownloadStatusProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$albumDownloadStatusHash();

  @override
  String toString() {
    return r'albumDownloadStatusProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<ListDownloadStatus> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<ListDownloadStatus> create(Ref ref) {
    final argument = this.argument as String;
    return albumDownloadStatus(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is AlbumDownloadStatusProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$albumDownloadStatusHash() =>
    r'9db31968f1fd76611d721144a3acc29133b8101c';

final class AlbumDownloadStatusFamily extends $Family
    with $FunctionalFamilyOverride<Stream<ListDownloadStatus>, String> {
  AlbumDownloadStatusFamily._()
    : super(
        retry: null,
        name: r'albumDownloadStatusProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  AlbumDownloadStatusProvider call(String albumId) =>
      AlbumDownloadStatusProvider._(argument: albumId, from: this);

  @override
  String toString() => r'albumDownloadStatusProvider';
}

@ProviderFor(playlistDownloadStatus)
final playlistDownloadStatusProvider = PlaylistDownloadStatusFamily._();

final class PlaylistDownloadStatusProvider
    extends
        $FunctionalProvider<
          AsyncValue<ListDownloadStatus>,
          ListDownloadStatus,
          Stream<ListDownloadStatus>
        >
    with
        $FutureModifier<ListDownloadStatus>,
        $StreamProvider<ListDownloadStatus> {
  PlaylistDownloadStatusProvider._({
    required PlaylistDownloadStatusFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'playlistDownloadStatusProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$playlistDownloadStatusHash();

  @override
  String toString() {
    return r'playlistDownloadStatusProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<ListDownloadStatus> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<ListDownloadStatus> create(Ref ref) {
    final argument = this.argument as String;
    return playlistDownloadStatus(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is PlaylistDownloadStatusProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$playlistDownloadStatusHash() =>
    r'0eb9e728f5ddbe2d456a9b6962f4751215d1a1aa';

final class PlaylistDownloadStatusFamily extends $Family
    with $FunctionalFamilyOverride<Stream<ListDownloadStatus>, String> {
  PlaylistDownloadStatusFamily._()
    : super(
        retry: null,
        name: r'playlistDownloadStatusProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  PlaylistDownloadStatusProvider call(String playlistId) =>
      PlaylistDownloadStatusProvider._(argument: playlistId, from: this);

  @override
  String toString() => r'playlistDownloadStatusProvider';
}

@ProviderFor(artistDownloadStatus)
final artistDownloadStatusProvider = ArtistDownloadStatusFamily._();

final class ArtistDownloadStatusProvider
    extends
        $FunctionalProvider<
          AsyncValue<ListDownloadStatus>,
          ListDownloadStatus,
          Stream<ListDownloadStatus>
        >
    with
        $FutureModifier<ListDownloadStatus>,
        $StreamProvider<ListDownloadStatus> {
  ArtistDownloadStatusProvider._({
    required ArtistDownloadStatusFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'artistDownloadStatusProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$artistDownloadStatusHash();

  @override
  String toString() {
    return r'artistDownloadStatusProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<ListDownloadStatus> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<ListDownloadStatus> create(Ref ref) {
    final argument = this.argument as String;
    return artistDownloadStatus(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ArtistDownloadStatusProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$artistDownloadStatusHash() =>
    r'be24f9ef720547a12875a4ae2b0b9337870e7e43';

final class ArtistDownloadStatusFamily extends $Family
    with $FunctionalFamilyOverride<Stream<ListDownloadStatus>, String> {
  ArtistDownloadStatusFamily._()
    : super(
        retry: null,
        name: r'artistDownloadStatusProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ArtistDownloadStatusProvider call(String artistId) =>
      ArtistDownloadStatusProvider._(argument: artistId, from: this);

  @override
  String toString() => r'artistDownloadStatusProvider';
}
