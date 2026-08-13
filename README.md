# subsynic

Subsynic is an Android music **syncing** app for [Subsonic-compatible](https://subsonic.org/) servers
such as [gonic](https://github.com/sentriz/gonic).

It is NOT a player.

This project intends to only take care of the sync process, so you have the freedom to choose
your own local music player app.

## Features

- Downloads are currently limited to Opus128k format/bitrate.
  This is what I personally use and recommend to everyone.
  If there's need for different formats/bitrates, open a PR or issue for it <3
- Download cover art into album directories and embed them into track files (600x600)
- Connects to a single server. Multi-server-support is not planned.
- Unified library view:
  Search for your tracks/albums/artists/playlists using the remote library
  and mark items to be synced.
  If you want to remove items from your synced files, mark them for deletion in the
  same UI.

## Credits

- [austinried/subtracks](https://github.com/austinried/subtracks)
  Inspiration for the project and baseline/best practice for most of my codebase

### Packages

- [riverpod](https://pub.dev/packages/riverpod) — state management
- [drift](https://pub.dev/packages/drift) — reactive SQLite ORM
- [freezed](https://pub.dev/packages/freezed) — immutable model codegen
- [fast_immutable_collections](https://pub.dev/packages/fast_immutable_collections) — immutable collections
- [dio](https://pub.dev/packages/dio) — HTTP client and downloads
- [auto_route](https://pub.dev/packages/auto_route) — declarative routing
- [flutter_taglib](https://pub.dev/packages/flutter_taglib) — embedded cover art via TagLib
- [infinite_scroll_pagination](https://pub.dev/packages/infinite_scroll_pagination) — paged library views
