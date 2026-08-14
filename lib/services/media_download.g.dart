// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_download.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MediaDownloadService)
final mediaDownloadServiceProvider = MediaDownloadServiceProvider._();

final class MediaDownloadServiceProvider
    extends $NotifierProvider<MediaDownloadService, DownloadState> {
  MediaDownloadServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mediaDownloadServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mediaDownloadServiceHash();

  @$internal
  @override
  MediaDownloadService create() => MediaDownloadService();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DownloadState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DownloadState>(value),
    );
  }
}

String _$mediaDownloadServiceHash() =>
    r'f798bf14ca1babef40666e0be8df8cc541c8e76c';

abstract class _$MediaDownloadService extends $Notifier<DownloadState> {
  DownloadState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<DownloadState, DownloadState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<DownloadState, DownloadState>,
              DownloadState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
