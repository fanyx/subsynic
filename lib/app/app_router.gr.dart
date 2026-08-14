// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [AlbumSongsPage]
class AlbumSongsRoute extends PageRouteInfo<AlbumSongsRouteArgs> {
  AlbumSongsRoute({
    Key? key,
    required String id,
    Album? album,
    List<PageRouteInfo>? children,
  }) : super(
         AlbumSongsRoute.name,
         args: AlbumSongsRouteArgs(key: key, id: id, album: album),
         rawPathParams: {'id': id},
         initialChildren: children,
       );

  static const String name = 'AlbumSongsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<AlbumSongsRouteArgs>(
        orElse: () => AlbumSongsRouteArgs(id: pathParams.getString('id')),
      );
      return AlbumSongsPage(key: args.key, id: args.id, album: args.album);
    },
  );
}

class AlbumSongsRouteArgs {
  const AlbumSongsRouteArgs({this.key, required this.id, this.album});

  final Key? key;

  final String id;

  final Album? album;

  @override
  String toString() {
    return 'AlbumSongsRouteArgs{key: $key, id: $id, album: $album}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! AlbumSongsRouteArgs) return false;
    return key == other.key && id == other.id && album == other.album;
  }

  @override
  int get hashCode => key.hashCode ^ id.hashCode ^ album.hashCode;
}

/// generated route for
/// [ArtistPage]
class ArtistRoute extends PageRouteInfo<ArtistRouteArgs> {
  ArtistRoute({
    Key? key,
    required String id,
    Artist? artist,
    List<PageRouteInfo>? children,
  }) : super(
         ArtistRoute.name,
         args: ArtistRouteArgs(key: key, id: id, artist: artist),
         rawPathParams: {'id': id},
         initialChildren: children,
       );

  static const String name = 'ArtistRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<ArtistRouteArgs>(
        orElse: () => ArtistRouteArgs(id: pathParams.getString('id')),
      );
      return ArtistPage(key: args.key, id: args.id, artist: args.artist);
    },
  );
}

class ArtistRouteArgs {
  const ArtistRouteArgs({this.key, required this.id, this.artist});

  final Key? key;

  final String id;

  final Artist? artist;

  @override
  String toString() {
    return 'ArtistRouteArgs{key: $key, id: $id, artist: $artist}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ArtistRouteArgs) return false;
    return key == other.key && id == other.id && artist == other.artist;
  }

  @override
  int get hashCode => key.hashCode ^ id.hashCode ^ artist.hashCode;
}

/// generated route for
/// [BottomNavTabsPage]
class BottomNavTabsRoute extends PageRouteInfo<void> {
  const BottomNavTabsRoute({List<PageRouteInfo>? children})
    : super(BottomNavTabsRoute.name, initialChildren: children);

  static const String name = 'BottomNavTabsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const BottomNavTabsPage();
    },
  );
}

/// generated route for
/// [DownloadsPage]
class DownloadsRoute extends PageRouteInfo<void> {
  const DownloadsRoute({List<PageRouteInfo>? children})
    : super(DownloadsRoute.name, initialChildren: children);

  static const String name = 'DownloadsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const DownloadsPage();
    },
  );
}

/// generated route for
/// [DownloadsShellPage]
class DownloadsShellRoute extends PageRouteInfo<void> {
  const DownloadsShellRoute({List<PageRouteInfo>? children})
    : super(DownloadsShellRoute.name, initialChildren: children);

  static const String name = 'DownloadsShellRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const DownloadsShellPage();
    },
  );
}

/// generated route for
/// [LibraryAlbumsPage]
class LibraryAlbumsRoute extends PageRouteInfo<void> {
  const LibraryAlbumsRoute({List<PageRouteInfo>? children})
    : super(LibraryAlbumsRoute.name, initialChildren: children);

  static const String name = 'LibraryAlbumsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const LibraryAlbumsPage();
    },
  );
}

/// generated route for
/// [LibraryArtistsPage]
class LibraryArtistsRoute extends PageRouteInfo<void> {
  const LibraryArtistsRoute({List<PageRouteInfo>? children})
    : super(LibraryArtistsRoute.name, initialChildren: children);

  static const String name = 'LibraryArtistsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const LibraryArtistsPage();
    },
  );
}

/// generated route for
/// [LibraryPlaylistsPage]
class LibraryPlaylistsRoute extends PageRouteInfo<void> {
  const LibraryPlaylistsRoute({List<PageRouteInfo>? children})
    : super(LibraryPlaylistsRoute.name, initialChildren: children);

  static const String name = 'LibraryPlaylistsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const LibraryPlaylistsPage();
    },
  );
}

/// generated route for
/// [LibraryShellPage]
class LibraryShellRoute extends PageRouteInfo<void> {
  const LibraryShellRoute({List<PageRouteInfo>? children})
    : super(LibraryShellRoute.name, initialChildren: children);

  static const String name = 'LibraryShellRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const LibraryShellPage();
    },
  );
}

/// generated route for
/// [LibraryTabsPage]
class LibraryTabsRoute extends PageRouteInfo<void> {
  const LibraryTabsRoute({List<PageRouteInfo>? children})
    : super(LibraryTabsRoute.name, initialChildren: children);

  static const String name = 'LibraryTabsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const LibraryTabsPage();
    },
  );
}

/// generated route for
/// [PlaylistSongsPage]
class PlaylistSongsRoute extends PageRouteInfo<PlaylistSongsRouteArgs> {
  PlaylistSongsRoute({
    Key? key,
    required String id,
    Playlist? playlist,
    List<PageRouteInfo>? children,
  }) : super(
         PlaylistSongsRoute.name,
         args: PlaylistSongsRouteArgs(key: key, id: id, playlist: playlist),
         rawPathParams: {'id': id},
         initialChildren: children,
       );

  static const String name = 'PlaylistSongsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<PlaylistSongsRouteArgs>(
        orElse: () => PlaylistSongsRouteArgs(id: pathParams.getString('id')),
      );
      return PlaylistSongsPage(
        key: args.key,
        id: args.id,
        playlist: args.playlist,
      );
    },
  );
}

class PlaylistSongsRouteArgs {
  const PlaylistSongsRouteArgs({this.key, required this.id, this.playlist});

  final Key? key;

  final String id;

  final Playlist? playlist;

  @override
  String toString() {
    return 'PlaylistSongsRouteArgs{key: $key, id: $id, playlist: $playlist}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! PlaylistSongsRouteArgs) return false;
    return key == other.key && id == other.id && playlist == other.playlist;
  }

  @override
  int get hashCode => key.hashCode ^ id.hashCode ^ playlist.hashCode;
}

/// generated route for
/// [SettingsPage]
class SettingsRoute extends PageRouteInfo<void> {
  const SettingsRoute({List<PageRouteInfo>? children})
    : super(SettingsRoute.name, initialChildren: children);

  static const String name = 'SettingsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SettingsPage();
    },
  );
}

/// generated route for
/// [SettingsShellPage]
class SettingsShellRoute extends PageRouteInfo<void> {
  const SettingsShellRoute({List<PageRouteInfo>? children})
    : super(SettingsShellRoute.name, initialChildren: children);

  static const String name = 'SettingsShellRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SettingsShellPage();
    },
  );
}

/// generated route for
/// [SourcePage]
class SourceRoute extends PageRouteInfo<void> {
  const SourceRoute({List<PageRouteInfo>? children})
    : super(SourceRoute.name, initialChildren: children);

  static const String name = 'SourceRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SourcePage();
    },
  );
}
