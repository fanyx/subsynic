// ignore_for_file: use_key_in_widget_constructors

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../models/music.dart';
import 'pages/artist_page.dart';
import 'pages/bottom_nav_page.dart';
import 'pages/downloads_page.dart';
import 'pages/library_albums_page.dart';
import 'pages/library_artists_page.dart';
import 'pages/library_page.dart';
import 'pages/library_playlists_page.dart';
import 'pages/settings_page.dart';
import 'pages/songs_page.dart';
import 'pages/source_page.dart';

part 'app_router.gr.dart';

@RoutePage()
class LibraryShellPage extends AutoRouter {
  const LibraryShellPage({super.key});
}

@RoutePage()
class DownloadsShellPage extends AutoRouter {
  const DownloadsShellPage({super.key});
}

@RoutePage()
class SettingsShellPage extends AutoRouter {
  const SettingsShellPage({super.key});
}

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          path: '/',
          page: BottomNavTabsRoute.page,
          children: [
            AutoRoute(
              path: 'library',
              page: LibraryShellRoute.page,
              children: [
                AutoRoute(
                  path: '',
                  page: LibraryTabsRoute.page,
                  children: [
                    AutoRoute(path: 'albums', page: LibraryAlbumsRoute.page),
                    AutoRoute(path: 'artists', page: LibraryArtistsRoute.page),
                    AutoRoute(
                        path: 'playlists', page: LibraryPlaylistsRoute.page),
                  ],
                ),
                AutoRoute(path: 'album/:id', page: AlbumSongsRoute.page),
                AutoRoute(path: 'playlist/:id', page: PlaylistSongsRoute.page),
                AutoRoute(path: 'artist/:id', page: ArtistRoute.page),
              ],
            ),
            AutoRoute(
              path: 'downloads',
              page: DownloadsShellRoute.page,
              children: [
                AutoRoute(path: '', page: DownloadsRoute.page),
              ],
            ),
            AutoRoute(
              path: 'settings',
              page: SettingsShellRoute.page,
              children: [
                AutoRoute(path: '', page: SettingsRoute.page),
                AutoRoute(path: 'source', page: SourceRoute.page),
              ],
            ),
          ],
        ),
      ];
}
