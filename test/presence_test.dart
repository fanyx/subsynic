import 'package:drift/native.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:subsynic/database/database.dart';
import 'package:subsynic/models/download.dart';
import 'package:subsynic/models/music.dart';
import 'package:subsynic/models/query.dart';
import 'package:subsynic/models/remote_query.dart';
import 'package:subsynic/services/library_scan.dart';
import 'package:subsynic/sources/music_source.dart';
import 'package:subsynic/state/presence.dart';
import 'package:subsynic/state/remote_library.dart';
import 'package:subsynic/state/server.dart';

class _FakeSource implements BaseMusicSource {
  final AlbumDetail albumDetail;
  final ArtistDetail artistDetail;
  final PlaylistDetail playlistDetail;
  final List<Artist> allArtists;

  int artistsCalls = 0;

  _FakeSource({
    required this.albumDetail,
    required this.artistDetail,
    required this.playlistDetail,
    this.allArtists = const [],
  });

  @override
  Future<AlbumDetail> album(String id) async => albumDetail;

  @override
  Future<ArtistDetail> artist(String id) async => artistDetail;

  @override
  Future<PlaylistDetail> playlist(String id) async => playlistDetail;

  @override
  Future<List<Album>> albums(AlbumListRequest request) async => throw UnimplementedError();

  @override
  Future<void> ping() async {}

  @override
  Future<List<Album>> searchAlbums(String query,
          {int count = 20, int offset = 0}) async =>
      const [];

  @override
  Future<List<Artist>> searchArtists(String query,
          {int count = 20, int offset = 0}) async =>
      const [];

  @override
  Future<List<Artist>> artists() async {
    artistsCalls++;
    return allArtists;
  }

  @override
  Future<List<Playlist>> playlists() async => const [];

  @override
  Uri streamUri(String songId) => Uri.parse('https://x/stream?id=$songId');

  @override
  Uri coverArtUri(String coverArtId) => Uri.parse('https://x/cover?id=$coverArtId');
}

Song _song(String id) => Song(id: id, title: 'Song $id', albumId: 'a1');

void main() {
  late SyncDatabase db;
  late _FakeSource source;

  setUp(() {
    db = SyncDatabase.connection(NativeDatabase.memory());
    source = _FakeSource(
      albumDetail: AlbumDetail(
        album: Album(
          id: 'a1',
          name: 'Alpha',
          songCount: 3,
        ),
        songs: IList([_song('s1'), _song('s2'), _song('s3')]),
      ),
      artistDetail: ArtistDetail(
        artist: Artist(id: 'ar1', name: 'Artist', albumCount: 1),
        albums: IList([
          Album(
            id: 'a1',
            name: 'Alpha',
            songCount: 3,
          ),
          Album(
            id: 'a2',
            name: 'Beta',
            songCount: 2,
          ),
        ]),
      ),
      playlistDetail: PlaylistDetail(
        playlist: Playlist(
          id: 'p1',
          name: 'Mix',
          songCount: 2,
        ),
        songs: IList([_song('s1'), _song('s2')]),
      ),
    );
  });

  tearDown(() async {
    await db.close();
  });

  Future<void> settle([int ms = 100]) =>
      Future<void>.delayed(Duration(milliseconds: ms));

  test('albumDownloadStatus = remote total x reactive counts', () async {
    final container = ProviderContainer(overrides: [
      databaseProvider.overrideWithValue(db),
      musicSourceProvider.overrideWithValue(source),
    ]);
    addTearDown(container.dispose);

    final emissions = <ListDownloadStatus>[];
    container.listen(
      albumDownloadStatusProvider('a1'),
      (_, next) {
        final value = next.value;
        if (value != null) emissions.add(value);
      },
      fireImmediately: true,
    );
    await settle();

    expect(emissions, isNotEmpty);
    expect(emissions.last.total, 3);
    expect(emissions.last.downloaded, 0);

    // Completing one download re-emits with the new count.
    await db.completeSongDownload('s1', 'p.opus', albumId: 'a1');
    await settle();
    expect(emissions.last.downloaded, 1);

    // A downloading song counts as downloading.
    await db.setSongDownloadStatus('s2', DownloadStatus.downloading,
        albumId: 'a1', progress: 40);
    await settle();
    expect(emissions.last.downloading, 1);
  });

  test('playlistDownloadStatus counts per song presence', () async {
    final container = ProviderContainer(overrides: [
      databaseProvider.overrideWithValue(db),
      musicSourceProvider.overrideWithValue(source),
    ]);
    addTearDown(container.dispose);

    await db.completeSongDownload('s1', 'p.opus', albumId: 'a1');
    await db.setSongDownloadStatus('s2', DownloadStatus.downloading,
        albumId: 'a1', progress: 50);

    final emissions = <ListDownloadStatus>[];
    container.listen(
      playlistDownloadStatusProvider('p1'),
      (_, next) {
        final value = next.value;
        if (value != null) emissions.add(value);
      },
      fireImmediately: true,
    );
    await settle();

    expect(emissions.last.total, 2);
    expect(emissions.last.downloaded, 1);
    expect(emissions.last.downloading, 1);
  });

  test('artistDownloadStatus sums album counts without per-album getAlbum',
      () async {
    final container = ProviderContainer(overrides: [
      databaseProvider.overrideWithValue(db),
      musicSourceProvider.overrideWithValue(source),
    ]);
    addTearDown(container.dispose);

    await db.completeSongDownload('s1', 'p.opus', albumId: 'a1');

    final emissions = <ListDownloadStatus>[];
    container.listen(
      artistDownloadStatusProvider('ar1'),
      (_, next) {
        final value = next.value;
        if (value != null) emissions.add(value);
      },
      fireImmediately: true,
    );
    await settle();

    expect(emissions.last.total, 5);
    expect(emissions.last.downloaded, 1);
  });

  test('fetch-all-once: page 2 of a tab reuses the memoized fetch-all (B2)',
      () async {
    source = _FakeSource(
      albumDetail: source.albumDetail,
      artistDetail: source.artistDetail,
      playlistDetail: source.playlistDetail,
      allArtists: [
        for (var i = 0; i < 100; i++)
          Artist(id: 'ar$i', name: 'Artist $i', albumCount: 1),
      ],
    );
    final container = ProviderContainer(overrides: [
      databaseProvider.overrideWithValue(db),
      musicSourceProvider.overrideWithValue(source),
    ]);
    addTearDown(container.dispose);

    final page1 = await container.read(remoteArtistListProvider(
      const ListQuery(
        page: Pagination(limit: 30),
        sort: SortBy(column: 'artists.name'),
      ),
    ).future);
    final page2 = await container.read(remoteArtistListProvider(
      const ListQuery(
        page: Pagination(limit: 30, offset: 30),
        sort: SortBy(column: 'artists.name'),
      ),
    ).future);

    expect(page1, hasLength(30));
    expect(page2, hasLength(30));
    // One getArtists call served both pages.
    expect(source.artistsCalls, 1);
  });

  test('LibraryRefresh invalidates the fetch-all caches', () async {
    source = _FakeSource(
      albumDetail: source.albumDetail,
      artistDetail: source.artistDetail,
      playlistDetail: source.playlistDetail,
      allArtists: [
        Artist(id: 'ar1', name: 'Artist', albumCount: 1),
      ],
    );
    final container = ProviderContainer(overrides: [
      databaseProvider.overrideWithValue(db),
      musicSourceProvider.overrideWithValue(source),
    ]);
    addTearDown(container.dispose);

    await container.read(allArtistsProvider.future);
    expect(source.artistsCalls, 1);

    await container.read(libraryRefreshProvider.notifier).refresh();
    await container.read(allArtistsProvider.future);
    expect(source.artistsCalls, 2);
  });

  test('pruneStalePresence skips the sweep when there is no presence (R-5b)',
      () async {
    final container = ProviderContainer(overrides: [
      databaseProvider.overrideWithValue(db),
      musicSourceProvider.overrideWithValue(source),
    ]);
    addTearDown(container.dispose);

    // `_FakeSource.albums` throws, so a sweep here would fail the test —
    // an empty presence table must short-circuit it entirely.
    await container.read(libraryScanServiceProvider.notifier).pruneStalePresence();
  });

  test('artist badge memo is populated once and cleared on refresh (B-1)',
      () async {
    final container = ProviderContainer(overrides: [
      databaseProvider.overrideWithValue(db),
      musicSourceProvider.overrideWithValue(source),
    ]);
    addTearDown(container.dispose);

    final emissions = <ListDownloadStatus>[];
    container.listen(
      artistDownloadStatusProvider('ar1'),
      (_, next) {
        final value = next.value;
        if (value != null) emissions.add(value);
      },
      fireImmediately: true,
    );
    await settle();

    expect(emissions.last.total, 5);
    expect(container.read(artistBadgeIndexProvider), contains('ar1'));

    await container.read(libraryRefreshProvider.notifier).refresh();
    expect(container.read(artistBadgeIndexProvider), isEmpty);
  });

  test('playlist detail memo is populated once and cleared on refresh (B-1)',
      () async {
    final container = ProviderContainer(overrides: [
      databaseProvider.overrideWithValue(db),
      musicSourceProvider.overrideWithValue(source),
    ]);
    addTearDown(container.dispose);

    final emissions = <ListDownloadStatus>[];
    container.listen(
      playlistDownloadStatusProvider('p1'),
      (_, next) {
        final value = next.value;
        if (value != null) emissions.add(value);
      },
      fireImmediately: true,
    );
    await settle();

    expect(emissions.last.total, 2);
    expect(container.read(playlistDetailMemoProvider), contains('p1'));

    await container.read(libraryRefreshProvider.notifier).refresh();
    expect(container.read(playlistDetailMemoProvider), isEmpty);
  });
}
