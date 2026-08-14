# subsynic (repo: `subsonic-sync`) — Architecture & Current State

> The app is named **subsynic** (pubspec `name: subsynic`, Subsonic client id
> `c=subsynic`) and lives in the repo `subsonic-sync`. It is a Flutter app that
> **downloads music from one self-hosted Subsonic-compatible server** (e.g.
> gonic) as **server-transcoded Ogg/Opus 128k** audio + album covers into a
> structured local library, tracks on-disk state in a local presence DB, and
> offers a remote browse/search UI over that library. It is **not** a player.
>
> **This document is the living architecture + state-of-the-code record.** The
> original "blueprint vs. subtracks" framing is superseded: the app has shipped
> a full **remote-source-of-truth** refactor (see §1) that removed the
> subtracks metadata-mirror model entirely. `docs/` now carries the authoritative
> design trail (see §3); treat anything in this repo that still describes a
> "DB mirror + SyncService" (notably `docs/architecture.md`,
> `docs/subtracks-architecture.md`) as **historical**.

---

## 1. Current architecture (remote source of truth)

```
server ──► SubsonicClient ──► list/detail/search providers (remote, per page)
          ▲                        │                          ▲
          │                        ▼                          │ presence
          │                UI (paged lists, detail,          │ lookup by id
          │                 search box, sort/filter)         │
          │                        │                          │
          │                        ▼                          │
          │                 MediaDownloadService / LibraryScanService
          │                        │
          └────────► local files (library_root)  ──►  DB: downloads + album_covers
                                          (presence index — the ONLY local data)
```

**Invariants**

- The remote Subsonic server is **always** the source of truth for what items
  (artists / albums / playlists / songs) exist and what their metadata is.
- The DB is **never** read to answer "what items exist" — that question is
  answered only by a Subsonic API call. The DB is only read to answer "is this
  id on disk / downloaded / in what state".
- **No offline browse of un-downloaded items** — accepted consequence (not a
  player; offline browsing of the library is not required).
- Download target is always Opus 128k via the `stream` endpoint; `download`
  endpoint never used.

Consequences that shape the code:

| Area | Consequence |
|---|---|
| Query engine | Server-side paging for **albums only** (`getAlbumList2`); artists/playlists are one-shot fetches (`getArtists`/`getPlaylists`) sliced/filtered client-side; search routes to `search3` (albums/artists) or a client-side playlist filter. |
| Models | Pure DTOs (`models/music.dart`, `models/remote_query.dart`) — no local-state fields; `Song` carries `coverArt` so song tiles never fetch an album. |
| DB | 5 tables, all presence/state only (schemaVersion 3). |
| State | Remote `AsyncValue` providers (`state/remote_library.dart`) + reactive presence stream providers (`state/presence.dart`), merged per item. |
| Services | `SyncService` deleted; `MediaDownloadService`/`LibraryScanService` retarget at remote items + presence tables. |
| Refresh | `LibraryRefresh` (`state/server.dart`) invalidates remote providers and bumps a timestamp — the paging-hook invalidation signal (the old `syncServiceProvider`/`state = DateTime.now()` pattern). |

---

## 2. Reference material

### 2.1 This repo's design trail (authoritative — read first)

| Doc | Covers |
|---|---|
| `docs/refactor/remote-sot.md` | The remote-source-of-truth refactor (implemented; `status: Done`). Post-implementation note: **starred fully removed**. |
| `docs/refactor/saf.md` | SAF storage refactor (implemented; the `saf` package replaces `file_picker`/`permission_handler`). |
| `docs/refactor/api_vs_memory.md` | API-vs-state audit; all ten recommended changes implemented (note: the "features" probe/column dropped → schema v3). |
| `docs/refactor/unify.md` | Rename/merge tasks A–D + B.3 — **all done**: A → `app/ui.dart`, B starred removed, B.3 `tryParseUtc` → `source.dart`, C `support` → `download`, D `_service` dropped. |
| `docs/refactor/try_catch.md` | try/catch reduction — **research done, not implemented** (§11). |
| `docs/feature/downloads.md` | Album-grouped Downloads page (implemented). |
| `docs/feature/album-ui.md` | Album detail redesign — gradient backdrop, labeled back chip, bold titles (implemented). |
| `docs/feature/multi-select.md` | Feature request — **not started** (§11). |

Historical (describes the pre-refactor mirror architecture — do not implement
from these): `docs/architecture.md`, `docs/subtracks-architecture.md`.

### 2.2 The subtracks codebase (original reference)

```bash
git clone --depth 1 https://github.com/austinried/subtracks /tmp/opencode/subtracks
```

Subtracks used **Riverpod 2 + drift 2.6 + auto_route 5 + `http`**. We are on
**newer majors** (Riverpod 3, drift 2.31, auto_route 11, `dio`). Subtracks
v1.3.0's *remote-first* model (paged `getAlbumList2`, `search3` per entity,
fetch-all + client slice, remote detail pages, cover disk cache + cache buster)
is what remote-SoT adopted; its Flutter `main`-branch mirror model is what we
deleted. Read subtracks for *structure*; follow the current package docs.

### 2.3 Online docs (current, authoritative — consult when writing code)

- **Riverpod 3/4** (state): <https://riverpod.dev/docs/introduction/getting_started>, breaking changes: <https://riverpod.dev/docs/whats_new>
- **Drift** (SQLite): <https://drift.simonbinder.eu/>
- **auto_route 11** (routing): <https://pub.dev/packages/auto_route>
- **freezed 3**: <https://pub.dev/packages/freezed>
- **dio 5** (HTTP): <https://pub.dev/packages/dio>
- **flutter_taglib** (Ogg/Opus tag+cover write): <https://pub.dev/packages/flutter_taglib>
- **saf** (SAF storage; picker, persisted grants, streaming, FDs): <https://pub.dev/packages/saf>
- **infinite_scroll_pagination**: <https://pub.dev/packages/infinite_scroll_pagination>
- **Subsonic REST API** (`stream` params `format`, `maxBitRate`): <https://subsonic.github.io/>
- **Ogg cover art** (`METADATA_BLOCK_PICTURE`): <https://wiki.xiph.org/VorbisComment>, picture block: <https://xiph.org/flac/format.html#metadata_block_picture>
- **Android Storage Access Framework**: <https://developer.android.com/guide/topics/providers/document-provider>

---

## 3. Frozen decisions (do not re-litigate)

| # | Decision |
|---|---|
| 1 | **Single server.** No `sources`/`subsonic_sources` tables, no `source_id` columns, no ID prefixes. PKs are bare `id`. |
| 2 | **`dio` for all HTTP** (SubsonicClient + downloads). One shared `Dio` instance. No `http` package. |
| 3 | **Download = server-transcoded Opus.** `stream` endpoint with `format=opus&maxBitRate=128`; `download` endpoint NOT used. Optional embed after download via `flutter_taglib` (`METADATA_BLOCK_PICTURE`); default off, `cover.jpg` is the exclusive art source for the UI. |
| 4 | **Filename policy.** `[<Year>] <Album>` folder under `<Album Artist>`; fall back to `Various Artists/[<Year>] <Album>` when no album artist and tracks differ; else common track artist. `<Year>` omitted when unknown. Track filename `<disc>-<track> - <title>.opus`. Implemented in `services/filename_policy.dart`. |
| 5 | **No resumable downloads.** Interrupted downloads restart from scratch (tmp discarded). Cancel → job status `incomplete`, never `failed`. |
| 6 | **No export / relocation.** Files always live in `library_root`. |
| 7 | **One combined library page** (bottom tab "Library") with **3 tabs** — Albums / Artists / Playlists — and an **inline debounced search box** (300 ms) that routes to `search3`. **No songs tab** (no all-songs browse) and no separate search screen. |
| 8 | **Android storage = SAF tree grant via the `saf` package.** `saf.pickDirectory()` (persistable permission), URI stored in `app_settings.library_root_uri`, restored on launch, all writes through `SafStorageProvider`. `MANAGE_EXTERNAL_STORAGE` rejected. The app targets **Android only**; the picker is exclusively SAF (no `file_picker`). |
| 9 | **No playback** anywhere. |
| 10 | **No export of media; `LibraryScanService` only verifies DB ↔ filesystem within `library_root`.** |
| 11 | **Remote source of truth.** No metadata mirror in the DB; server answers "what exists", DB answers "what is on disk" (§1). |
| 12 | **No starred anywhere.** `StarredItems`, `getStarred2`, `AlbumListType.starred`, the `starred` filter, `Artist.starred` — all removed (unify B). |

---

## 4. Directory layout (current, actual)

```
lib/
├── main.dart                     # runApp(ProviderScope(child: App))
├── log.dart                      # file + console, redaction
├── app/
│   ├── app.dart                  # MaterialApp.router + init gate
│   ├── app_router.dart           # auto_route 11: bottom-nav shell + tabs + details
│   ├── ui.dart                   # app shell chrome: theme, covers, clips, gradients, menus, dialogs, snackbars, albumGradientHigh (unify A)
│   ├── items.dart                # grid/list tiles + badges + remove actions
│   ├── lists.dart                # paged query views + RemoteRefresh
│   ├── hooks/
│   │   ├── use_paging_controller.dart
│   │   ├── use_list_query_paging_controller.dart
│   │   └── use_download_actions.dart   # download/cancel/delete actions per item
│   └── pages/
│       ├── library_page.dart         # LibraryTabsPage (3 tabs) + LibrarySearch* + LibraryLists + sort/filter sheet
│       ├── library_albums_page.dart / library_artists_page.dart / library_playlists_page.dart
│       ├── songs_page.dart           # album / artist / playlist detail (+ gradient backdrop, labeled back chip)
│       ├── artist_page.dart
│       ├── downloads_page.dart       # album-grouped job cards + retry
│       ├── settings_page.dart        # server + SAF library_root + embed toggle + scan
│       ├── source_page.dart          # server add/edit
│       └── bottom_nav_page.dart      # bottom nav: Library | Downloads | Settings
├── state/
│   ├── init.dart                 # settings init + library-lists restore (no SAF re-init needed)
│   ├── server.dart               # musicSource, LibraryRefresh, coverCacheBuster
│   ├── remote_library.dart       # remote list/detail/search providers + memo indexes
│   ├── presence.dart             # reactive presence streams + download summaries
│   └── downloads.dart            # downloadsProvider → service; downloadGroupsProvider
├── services/
│   ├── settings.dart             # server row + app_settings
│   ├── media_download.dart       # download engine (album/playlist/song, cancel, delete)
│   ├── library_scan.dart         # scan + pruneStalePresence
│   ├── filename_policy.dart      # album-folder policy (pure)
│   ├── remote_query_mapper.dart  # ListQuery → remote params / client slice (pure)
│   └── network/
│       ├── client.dart           # shared Dio + auth headers
│       └── storage.dart          # LibraryStorage + File/SafStorageProvider + createStorage
├── sources/
│   ├── music_source.dart         # BaseMusicSource (read-only query API)
│   └── subsonic/
│       ├── client.dart           # Dio-based SubsonicClient (v=1.13.0, c=subsynic)
│       ├── source.dart           # SubsonicSource (maps XML → DTOs)
│       └── xml.dart              # SubsonicResponse/Status
├── models/
│   ├── music.dart                # Artist/Album/Playlist/Song (pure DTOs)
│   ├── settings.dart             # ServerSettings, AppSettings
│   ├── query.dart                # ListQuery/Pagination/SortBy/FilterWith (+ LibraryListQuery)
│   ├── remote_query.dart         # AlbumListType, AlbumListRequest, *Detail
│   ├── download.dart             # SongDownload, Download, DownloadGroup*, DownloadState, DownloadCounts, ListDownloadStatus (unify C)
└── database/
    ├── tables.drift              # presence schema (v3)
    ├── database.dart             # SyncDatabase: presence CRUD + grouped counts
    ├── converters.dart           # UriConverter, DownloadStatusConverter, ...
    └── error_logging_database.dart
```

Note: `app_router.gr.dart`, `*.g.dart`, `*.freezed.dart` are generated — never
hand-edit; run build_runner (§13).

---

## 5. Database (Drift — presence index only, schemaVersion 3)

`SyncDatabase` (`database/database.dart`), `schemaVersion => 3`. Migrations:
`1→2` created `downloads` + `album_covers` (seeding from the old mirror's
`songs`/`albums` rows that had local files) and dropped all metadata/FTS
tables; `2→3` dropped `server.features` (the `emptyQuerySearch` probe — see
`docs/refactor/api_vs_memory.md` S-1).

Tables (`database/tables.drift`):

- `server` — **single row** (`id = 1`): `address` (MAPPED Uri), `username`,
  `password`, `use_token_auth`. **No `features` column.**
- `app_settings` (`id = 1`): `library_root_uri` (MAPPED Uri — the SAF
  `content://` tree URI or a `file://` path on desktop), `embed_cover`.
- `last_library_state`: persisted per-tab `ListQuery` JSON (sort/filter restore).
- `downloads(song_id PK, album_id, local_path, download_status, download_progress, cover_embedded, updated)`
  — `album_id` is a **denormalized grouping key**, not a FK.
- `album_covers(album_id PK, cover_path, updated)` — relative path of `cover.jpg`.

Key queries: `downloadCountsByAlbum` (one grouped COUNT query powers every
badge/summary), `songDownloadById`/`songDownloadsByIds`, `downloadsByAlbum`,
`allDownloads`/`countDownloads`, `albumCoverByAlbum`, `allAlbumCovers`/
`countAlbumCovers`, `getServer`, `getAppSettings`.

CRUD (all in `SyncDatabase`): `upsertSongDownload`, `setSongDownloadStatus`,
`completeSongDownload`, `clearSongDownload`, `removeSongDownload`,
`deleteDownloadsByAlbum`, `upsertAlbumCover`, `deleteAlbumCover`,
`deleteDownloadsNotInAlbums`/`deleteAlbumCoversNotIn` (the tombstone diff,
used by `pruneStalePresence`).

`download_status` maps to `DownloadStatus` (`none/queued/downloading/completed/
failed/removed`) via `DownloadStatusConverter`.

---

## 6. Sources layer (read-only query API)

`BaseMusicSource` (`sources/music_source.dart`):

```dart
abstract class BaseMusicSource {
  Future<void> ping();
  Future<List<Album>> albums(AlbumListRequest request);        // getAlbumList2
  Future<List<Artist>> searchArtists(String q, {int count, int offset}); // search3
  Future<List<Album>>  searchAlbums(String q, {int count, int offset});
  Future<ArtistDetail> artist(String id);                       // getArtist
  Future<AlbumDetail>  album(String id);                        // getAlbum
  Future<PlaylistDetail> playlist(String id);                   // getPlaylist
  Future<List<Artist>> artists();                               // getArtists (one-shot)
  Future<List<Playlist>> playlists();                           // getPlaylists (one-shot)
  Uri streamUri(String songId);      // stream?id=..&format=opus&maxBitRate=128
  Uri coverArtUri(String coverArtId);
}
```

- `SubsonicClient` (`sources/subsonic/client.dart`): Dio-based, `v=1.13.0`,
  `c=subsynic`, MD5 token auth (`s`/`t`) or plaintext `p`. `get()` returns
  `SubsonicResponse`; `ping()`/`test()` for validation.
- `SubsonicSource` (`sources/subsonic/source.dart`): maps XML → DTOs (bare
  ids, no prefixes), `_mapSong` reads `coverArt`. Playlist detail uses a
  `Pool(10)` fan-out when needed.
- `streamUri` = `uri('stream', {'id': id, 'format': 'opus', 'maxBitRate': '128'})`.

---

## 7. State layer (remote + presence)

### `state/server.dart`
- `musicSourceProvider` (keepAlive) → `SubsonicSource(opt, dio)` or `null`.
- `LibraryRefresh` (keepAlive): `refresh()` invalidates `allArtistsProvider`,
  `allPlaylistsProvider`, the whole `remoteAlbumListProvider` **family** (Riverpod
  ≥ 3 family invalidation), clears the memo indexes, runs
  `pruneStalePresence()`, then `state = DateTime.now()` (the paging signal).
- `coverCacheBusterProvider`: `md5(address|username)` — namespaces the cover
  disk cache per server.

### `state/remote_library.dart`
- **Albums** (server-paged): `remoteAlbumListProvider(AlbumListRequest)` —
  keepAlive family; each `(type, page)` instance = one `getAlbumList2`.
- **Artists/Playlists** (fetch-all-once): keepAlive `allArtistsProvider` /
  `allPlaylistsProvider`; `remoteArtistListProvider(ListQuery)` /
  `remotePlaylistListProvider(ListQuery)` slice + sort the cached list via
  `remote_query_mapper.dart`.
- **Search**: `remoteAlbumSearch` / `remoteArtistSearch` (`search3`, paged);
  `remotePlaylistSearch` (client-side filter over `allPlaylists`).
- **Details** (autoDispose): `remoteAlbumDetail` / `remoteArtistDetail` /
  `remotePlaylistDetail`; throw `noServer` (`StateError`) when no source.
- **Memo indexes** (keepAlive, cleared on refresh): `ArtistArtIndex`
  (artistId → first-album coverArt, caches negatives), `ArtistBadgeIndex`
  (artistId → Σ songCount + albumId set), `PlaylistDetailMemo`
  (playlistId → detail). These stop tile badges/covers re-firing `getArtist`/
  `getPlaylist` on scroll re-entry (`api_vs_memory` B-1).
- `artistCoverArt` (index-gated N+1 `getArtist`), `albumsByArtistId`.

### `state/presence.dart` (reactive, Drift-backed)
- `downloadCountsByAlbumProvider` (keepAlive): one grouped COUNT stream → `IMap`.
- `songDownloadsByIdsProvider`, `songPresenceProvider`, `albumCoverPathProvider`.
- `albumDownloadStatus` (remote total × grouped index), `playlistDownloadStatus`
  (memoized detail × per-song presence), `artistDownloadStatus` (badge memo ×
  grouped index).

### `state/downloads.dart`
- `downloadsProvider` → `mediaDownloadServiceProvider` state.
- `downloadGroupsProvider`: groups flat session jobs by `albumId`
  (first-appearance order, never re-sorted) and derives `DownloadGroupStatus`
  (`downloadGroupStatus` in `models/download.dart`).

### `state/init.dart`
`init` → `settingsServiceProvider.init()` → `libraryListsProvider.init()`
(sort/filter restore). **No SAF re-init** — the persisted grant is restored by
the system on launch.

---

## 8. Services

### `media_download.dart` (`MediaDownloadService`)
- `downloadAlbum(AlbumDetail)`, `downloadPlaylist(PlaylistDetail)`,
  `downloadSong(Song, {AlbumDetail? detail})` — detail passed by callers that
  hold it (album/playlist page) to avoid re-fetching `getAlbum`/`getPlaylist`
  (api_vs_memory R-1/R-4).
- `cancelAlbum/cancelPlaylist({detail})/cancelSong`, `deleteAlbum/deletePlaylist({detail})/deleteSong`.
- **Cancel → `incomplete`** (never `failed`); partial tmp files discarded.
- Completed jobs are TTL'd (2 min) and pruned by a low-frequency sweep;
  `clearCompleted()` manual clear.
- Pool(3) song concurrency, `CancelToken` per job, per-song progress via
  `onReceiveProgress`; presence rows written through `SyncDatabase`.
- `_excludeCompleted` skips already-downloaded songs on re-download;
  `_albumDetailsFor` resolves playlist album folders via `getAlbum` (gonic
  emits no `albumArtist` on playlist entries), short-circuiting from an
  existing `local_path` dirname for partially-downloaded albums.

### `library_scan.dart` (`LibraryScanService`)
- `scan()`: walks `library_root` (via `LibraryStorage`) and reconciles DB
  `downloads`/`album_covers`; missing files → `removed` (row kept for
  re-download); orphans ignored.
- `pruneStalePresence()`: tombstones `downloads`/`album_covers` rows whose
  album no longer exists on the server (bounded `getAlbumList2` sweep), called
  from `LibraryRefresh.refresh()`; early-returns when presence is empty.

### `filename_policy.dart`
Pure `resolveAlbumFolder(albumArtist, year, albumName, trackArtists)` + track
filename policy (decision 4). Unit-tested.

### `remote_query_mapper.dart`
Pure `mapAlbumsQuery(ListQuery, {search})` → `AlbumListRequest`
(`albums.name`→`alphabeticalByName`, `albums.created`→`newest`,
`albums.year`→`byYear(1,9999)`, `albums.album_artist`→`alphabeticalByArtist`);
`mapArtistsQuery`/`mapPlaylistsQuery` (client-side sort/slice);
`slice(List<T>, Pagination)`.

### `settings.dart` (`SettingsService`)
Single `server` row + `app_settings`. `saveServer` pings to validate; no
feature probe (column dropped). Non-functional `init()` (DB open + settings
load).

### `network/`
- `client.dart`: shared `Dio` + `dioProvider`.
- `storage.dart`: `LibraryStorage` interface; `FileStorageProvider`
  (desktop/tests/unconfigured) and `SafStorageProvider` (the `saf` package over
  the persistable `content://` tree grant — `mkdirp`, `child`, `writeFileStream`,
  `delete`, `walk`, FDs). `createStorage` routes by scheme (`content` → SAF,
  `file` → file, `file` on **Android** → unconfigured); `humanizeLibraryRootUri`
  for the settings label; `safProvider`/`storageProvider` (keepAlive).

---

## 9. UI

- **Routing** (`auto_route 11`): `BottomNavTabsRoute` (Library | Downloads |
  Settings) → `LibraryTabsRoute` (Albums | Artists | Playlists) +
  `AlbumSongsRoute`/`ArtistRoute`/`PlaylistSongsRoute` detail routes +
  `SourceRoute`.
- **Library page** (`library_page.dart`): `LibrarySearch` (raw input, 300 ms
  debounce) → `LibrarySearchQuery` (drives `search3` vs browse); `LibraryLists`
  holds the 3 persisted `ListQuery`s; sort/filter sheet hides options with no
  remote equivalent (no `genre`/`album_artist` "is not null" filters, no
  starred).
- **Detail pages** (`songs_page.dart`, `artist_page.dart`): remote detail
  providers; seeded from the tapped list row (`placeholderData` style) so the
  header renders instantly; art-derived gradient backdrop
  (`ui.dart` `albumGradientHigh` via `palette_generator` in an isolate),
  labeled back chip (previous route name),
  bold song titles, `· <year>` in the album header.
- **Downloads page** (`downloads_page.dart`): album-grouped cards
  (auto-expand while downloading, auto-collapse on success, user pin override),
  per-song rows in stable insertion order, retry on error/incomplete, Cancel
  all + Clear completed. Card text comes from job fields only (no metadata
  lookups).
- **Items** (`items.dart`): three-tier download badges — album grid card is
  **call-free** (`songCount` from `getAlbumList2` + grouped index); artist tile
  uses the badge memo; playlist tile uses the detail memo. Song tiles read
  `songPresenceProvider`; covers render `coverArt` directly with `albumId` for
  local-first resolution.
- **Covers** (`ui.dart`): `coverBytesProvider` keyed by `coverArt` id +
  size, disk-cached under the `coverCacheBuster` namespace, local `cover.jpg`
  (via `album_covers`) preferred. `CoverArt` falls back to `PlaceholderArt`.
- **Settings** (`settings_page.dart`): server URL/user/pass, `library_root`
  via `_saf.pickDirectory()` (SAF; releases the old grant on re-pick),
  `embed_cover` toggle, scan button.
- **Lists** (`lists.dart`): paged list/grid views; `RemoteRefresh` calls
  `LibraryRefresh.refresh()`.

---

## 10. Implemented refactors & features — status

| Doc | Status |
|---|---|
| `docs/refactor/remote-sot.md` | **Done** — full remote-source-of-truth (DB mirror + `SyncService` deleted; presence DB; remote providers). |
| `docs/refactor/saf.md` | **Done** — `saf` package `SafStorageProvider`; SAF picker in settings; legacy perms removed. |
| `docs/refactor/api_vs_memory.md` | **Done** — all 10 items (R-5 family invalidation, R-1/R-4 detail passing, R-2 cover short-circuit, B-1 memo indexes, P-1 presence-derived folder, F-1 song-tile `albumId`, S-1 `features` dropped, R-5b empty-presence short-circuit, S-6 `searchSongs` removed, S-2 starred removed). |
| `docs/feature/downloads.md` | **Done** — album-grouped downloads page, TTL, `downloadGroupsProvider`, cancel→incomplete. |
| `docs/feature/album-ui.md` | **Done** — gradient backdrop, labeled back chip, bold titles, header year (`palette_generator` re-added). |
| `docs/refactor/unify.md` | **Done** — A (7 files → `app/ui.dart`), B (starred removed), B.3 (`tryParseUtc` → `source.dart`), C (`support.dart` → `download.dart`), D (`_service` dropped). |
| `docs/refactor/try_catch.md` | **Pending** — research done; no code changed (no `runGuarded`/`ignoreErrors`; `SubsonicException` still try/catch). |
| `docs/feature/multi-select.md` | **Pending** — feature request only, not started. |

---

## 11. Pending work (next tasks, in suggested order)

1. **try_catch** — implement `docs/refactor/try_catch.md`: `runGuarded` in
   `ui.dart` (merged `snackbars.dart`), `ignoreErrors()` helper,
   `AsyncValue.guard` for the cover fetch, null-aware `SubsonicException`,
   split cancel vs failure in `_downloadSong`, `saf.withFileDescriptor` for
   the embed FD path.
2. **multi-select** — long-press multi-select + bottom action bar
   (download/remove/cancel) across visible items; see `docs/feature/multi-select.md`.

Also **docs drift**: `docs/architecture.md` still describes the old mirror
architecture (`file_picker`, `SyncService`, 6 metadata tables); update or mark
historical.

---

## 12. Dependencies (current `pubspec.yaml`)

| Package | Role | Version |
|---|---|---|
| `hooks_riverpod`, `riverpod_annotation` | state | 3.3.2 / 4.0.3 |
| `flutter_hooks` | hooks | ^0.21.3 |
| `drift`, `drift_dev` | DB + codegen | 2.34.3 / 2.34.0 |
| `sqlite3` | native SQLite (native-asset build; no `sqlite3_flutter_libs`) | 3.5.1 |
| `freezed_annotation`, `freezed` | models | ^3.1.0 / 3.2.6-dev.1 |
| `json_annotation`, `json_serializable` | JSON | 4.12.0 / 6.14.1 |
| `fast_immutable_collections` | `IList`/`ISet`/`IMap` | 11.2.0 |
| `dio` | all HTTP + downloads | ^5.11.0 |
| `xml` | Subsonic response parsing | 7.0.1 |
| `crypto` | MD5 token auth + cache buster | ^3.0.7 |
| `auto_route`, `auto_route_generator` | routing | 11.1.0 / 10.6.0 |
| `flutter_taglib` | embed cover into Opus | ^1.5.2 |
| `saf` | SAF storage (picker, grants, streaming, FDs) | ^2.1.0 |
| `palette_generator` | album art → gradient color | ^0.3.3+7 |
| `path`, `path_provider`, `collection`, `pool`, `logging` | utilities | latest |
| `infinite_scroll_pagination` | paged lists | ^5.1.1 |
| `build_runner`, `riverpod_generator`, `auto_route_generator`, `drift_dev`, `json_serializable`, `sqlite3` (dev) | codegen/test | 2.15.1 / 4.0.4 / 10.6.0 / 2.34.0 / 6.14.1 / ^3.5.1 |

**Dependency-generation note (do not "fix")**: the codegen stack is pinned to
the **analyzer-12 generation** (analyzer 12.1.0) because `riverpod` drags in
`test`, which is capped at 1.31.0 by `flutter_test`'s `test_api 0.7.11` pin,
and `test 1.31.0` allows only analyzer <13. Analyzer 12 supports the Dart 3.12
language version — the fix for build_runner hanging. `meta` is overridden to
1.18.3 (flutter_test pins 1.18.0; the patch bump is API-compatible). Bumping
`build_runner` ≥2.15.2, `riverpod_generator` ≥4.0.6, `drift_dev` ≥2.34.1, or
`freezed` to a stable >3.2.5 would pull analyzer ≥13 and break the solve.

**Dependency overrides**: `meta` 1.18.3 (flutter_test pins 1.18.0).

**Not used (verified absent)**: `http`, `just_audio`, `audio_service`,
`cached_network_image`, `flutter_cache_manager`, `worker_manager`,
`flutter_downloader`, `flutter_staggered_grid_view`, `flutter_svg`,
`text_scroll`, `auto_size_text`, `share_plus`, `connectivity_plus`,
`flutter_keyboard_visibility`, `package_info_plus`, `url_launcher`,
`flutter_dotenv`, `permission_handler`, `file_picker`, `synchronized`, `mime`, `rxdart`,
`intl`.

---

## 13. Build, codegen & verification

```bash
flutter pub get
dart run build_runner build   # drift + freezed + riverpod + auto_route + json
flutter analyze
flutter test
```

- Codegen output (`*.g.dart`, `*.freezed.dart`, `app_router.gr.dart`) is
  committed; regenerate after any change to a file with a `part` directive.
- Tests live in `test/` (10 files): `app_startup_test.dart`, `database_test.dart`
  (presence schema), `download_group_test.dart` (grouping/status/TTL),
  `filename_policy_test.dart`, `grid_paging_test.dart`, `migration_test.dart`
  (v1→v2→v3), `presence_test.dart` (remote×presence summaries, memo indexes),
  `remote_query_mapper_test.dart`, `subsonic_client_test.dart` (URI/auth),
  `subsonic_source_test.dart` (XML mapping).

---

## 14. Do / don't

- **Do** keep the DB as a **presence index only** — never add metadata/FTS
  tables back; the server answers "what exists".
- **Do** keep `saveX`-style batched upserts and the tombstone pattern
  (`deleteDownloadsNotInAlbums`/`deleteAlbumCoversNotIn`) for presence.
- **Do** keep `state = DateTime.now()` (via `LibraryRefresh`) as the paging
  invalidation signal, and `ref.invalidate(family)` for keepAlive families.
- **Do** keep freezed immutable models + `fast_immutable_collections`.
- **Do** add pure, unit-testable logic to `services/` (filename policy,
  remote_query_mapper, download group status) with tests.
- **Don't** reintroduce player/multi-server/SyncService code.
- **Don't** embed secrets; password lives in the DB (plaintext tradeoff,
  noted in README).
- **Don't** guess package APIs — consult the online docs (§2.3) and the
  repo's refactor trail (§2.1) first.
- **Don't** use `dart:io` path writes on Android for a user-picked root —
  always through `LibraryStorage` (SAF).
