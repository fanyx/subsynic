// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'downloads.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(downloads)
final downloadsProvider = DownloadsProvider._();

final class DownloadsProvider
    extends $FunctionalProvider<DownloadState, DownloadState, DownloadState>
    with $Provider<DownloadState> {
  DownloadsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'downloadsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$downloadsHash();

  @$internal
  @override
  $ProviderElement<DownloadState> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  DownloadState create(Ref ref) {
    return downloads(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DownloadState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DownloadState>(value),
    );
  }
}

String _$downloadsHash() => r'31d9e1fc1f55fee58b510b3f134cb5d73cb4bc74';

/// Groups the flat session jobs by album (first-appearance order, never
/// re-sorted) and derives each group's combined status. Loose songs (no
/// `albumId`) bucket under a single null-keyed group.

@ProviderFor(downloadGroups)
final downloadGroupsProvider = DownloadGroupsProvider._();

/// Groups the flat session jobs by album (first-appearance order, never
/// re-sorted) and derives each group's combined status. Loose songs (no
/// `albumId`) bucket under a single null-keyed group.

final class DownloadGroupsProvider
    extends
        $FunctionalProvider<
          IList<DownloadGroup>,
          IList<DownloadGroup>,
          IList<DownloadGroup>
        >
    with $Provider<IList<DownloadGroup>> {
  /// Groups the flat session jobs by album (first-appearance order, never
  /// re-sorted) and derives each group's combined status. Loose songs (no
  /// `albumId`) bucket under a single null-keyed group.
  DownloadGroupsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'downloadGroupsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$downloadGroupsHash();

  @$internal
  @override
  $ProviderElement<IList<DownloadGroup>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  IList<DownloadGroup> create(Ref ref) {
    return downloadGroups(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IList<DownloadGroup> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IList<DownloadGroup>>(value),
    );
  }
}

String _$downloadGroupsHash() => r'7bd3d4c8c86322932ed90b51df0b37b3effec155';
