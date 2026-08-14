// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ui.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(baseTheme)
final baseThemeProvider = BaseThemeProvider._();

final class BaseThemeProvider
    extends $FunctionalProvider<ThemeData, ThemeData, ThemeData>
    with $Provider<ThemeData> {
  BaseThemeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'baseThemeProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$baseThemeHash();

  @$internal
  @override
  $ProviderElement<ThemeData> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ThemeData create(Ref ref) {
    return baseTheme(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ThemeData value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ThemeData>(value),
    );
  }
}

String _$baseThemeHash() => r'78a389f987de18373623a094faeff134a7da9f80';

/// Derives the album's prominent cover color for the gradient backdrop.
///
/// Fetches the cover bytes (local `cover.jpg` or server art, both cached),
/// downscales and decodes the image on the main isolate (the engine does the
/// heavy decode off-thread; the image decoder registry is not reachable from
/// spawned isolates), then runs the palette quantization on a background
/// isolate. Returns `null` when no cover is available or no suitable color is
/// found — callers fall back to the base theme gradient.

@ProviderFor(albumGradientHigh)
final albumGradientHighProvider = AlbumGradientHighFamily._();

/// Derives the album's prominent cover color for the gradient backdrop.
///
/// Fetches the cover bytes (local `cover.jpg` or server art, both cached),
/// downscales and decodes the image on the main isolate (the engine does the
/// heavy decode off-thread; the image decoder registry is not reachable from
/// spawned isolates), then runs the palette quantization on a background
/// isolate. Returns `null` when no cover is available or no suitable color is
/// found — callers fall back to the base theme gradient.

final class AlbumGradientHighProvider
    extends
        $FunctionalProvider<
          AsyncValue<ui.Color?>,
          ui.Color?,
          FutureOr<ui.Color?>
        >
    with $FutureModifier<ui.Color?>, $FutureProvider<ui.Color?> {
  /// Derives the album's prominent cover color for the gradient backdrop.
  ///
  /// Fetches the cover bytes (local `cover.jpg` or server art, both cached),
  /// downscales and decodes the image on the main isolate (the engine does the
  /// heavy decode off-thread; the image decoder registry is not reachable from
  /// spawned isolates), then runs the palette quantization on a background
  /// isolate. Returns `null` when no cover is available or no suitable color is
  /// found — callers fall back to the base theme gradient.
  AlbumGradientHighProvider._({
    required AlbumGradientHighFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'albumGradientHighProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$albumGradientHighHash();

  @override
  String toString() {
    return r'albumGradientHighProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<ui.Color?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<ui.Color?> create(Ref ref) {
    final argument = this.argument as String;
    return albumGradientHigh(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is AlbumGradientHighProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$albumGradientHighHash() => r'188091c7aac6855b208ee58ddfd05b5b5cecae5d';

/// Derives the album's prominent cover color for the gradient backdrop.
///
/// Fetches the cover bytes (local `cover.jpg` or server art, both cached),
/// downscales and decodes the image on the main isolate (the engine does the
/// heavy decode off-thread; the image decoder registry is not reachable from
/// spawned isolates), then runs the palette quantization on a background
/// isolate. Returns `null` when no cover is available or no suitable color is
/// found — callers fall back to the base theme gradient.

final class AlbumGradientHighFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<ui.Color?>, String> {
  AlbumGradientHighFamily._()
    : super(
        retry: null,
        name: r'albumGradientHighProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Derives the album's prominent cover color for the gradient backdrop.
  ///
  /// Fetches the cover bytes (local `cover.jpg` or server art, both cached),
  /// downscales and decodes the image on the main isolate (the engine does the
  /// heavy decode off-thread; the image decoder registry is not reachable from
  /// spawned isolates), then runs the palette quantization on a background
  /// isolate. Returns `null` when no cover is available or no suitable color is
  /// found — callers fall back to the base theme gradient.

  AlbumGradientHighProvider call(String id) =>
      AlbumGradientHighProvider._(argument: id, from: this);

  @override
  String toString() => r'albumGradientHighProvider';
}

@ProviderFor(coverBytes)
final coverBytesProvider = CoverBytesFamily._();

final class CoverBytesProvider
    extends
        $FunctionalProvider<
          AsyncValue<Uint8List?>,
          Uint8List?,
          FutureOr<Uint8List?>
        >
    with $FutureModifier<Uint8List?>, $FutureProvider<Uint8List?> {
  CoverBytesProvider._({
    required CoverBytesFamily super.from,
    required ({String coverArtId, String? albumId}) super.argument,
  }) : super(
         retry: null,
         name: r'coverBytesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$coverBytesHash();

  @override
  String toString() {
    return r'coverBytesProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<Uint8List?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Uint8List?> create(Ref ref) {
    final argument = this.argument as ({String coverArtId, String? albumId});
    return coverBytes(
      ref,
      coverArtId: argument.coverArtId,
      albumId: argument.albumId,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is CoverBytesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$coverBytesHash() => r'29e44b3307adce69dd29f40539a1bab88fd18877';

final class CoverBytesFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<Uint8List?>,
          ({String coverArtId, String? albumId})
        > {
  CoverBytesFamily._()
    : super(
        retry: null,
        name: r'coverBytesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CoverBytesProvider call({required String coverArtId, String? albumId}) =>
      CoverBytesProvider._(
        argument: (coverArtId: coverArtId, albumId: albumId),
        from: this,
      );

  @override
  String toString() => r'coverBytesProvider';
}
