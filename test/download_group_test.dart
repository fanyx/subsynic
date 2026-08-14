import 'package:drift/native.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:subsynic/app/pages/downloads_page.dart';
import 'package:subsynic/database/database.dart' hide Download;
import 'package:subsynic/models/download.dart';
import 'package:subsynic/services/media_download.dart';
import 'package:subsynic/state/downloads.dart';
import 'package:subsynic/state/server.dart';

Download _job(
  String songId, {
  String? albumId,
  String? title,
  String? artist,
  String? album,
  String? albumArtist,
  DownloadStatus status = DownloadStatus.none,
  int progress = 0,
  DateTime? completedAt,
}) {
  return Download(
    songId: songId,
    title: title,
    artist: artist,
    album: album,
    albumArtist: albumArtist,
    albumId: albumId,
    completedAt: completedAt,
    progress: progress,
    status: status,
  );
}

IList<DownloadGroup> _groups(DownloadState state) {
  final container = ProviderContainer(
    overrides: [downloadsProvider.overrideWithValue(state)],
  );
  addTearDown(container.dispose);
  return container.read(downloadGroupsProvider);
}

/// Real [MediaDownloadService] with a seeded initial [DownloadState]; the base
/// [MediaDownloadService.build] still wires the 30s sweep timer.
class SeededService extends MediaDownloadService {
  SeededService(this.seed);

  final DownloadState seed;

  @override
  DownloadState build() {
    super.build();
    return seed;
  }
}

void main() {
  group('downloadGroupStatus', () {
    test('all completed -> successful', () {
      expect(
        downloadGroupStatus([
          _job('s1', status: DownloadStatus.completed),
          _job('s2', status: DownloadStatus.completed),
        ]),
        DownloadGroupStatus.successful,
      );
    });

    test('any active -> downloading', () {
      expect(
        downloadGroupStatus([
          _job('s1', status: DownloadStatus.completed),
          _job('s2', status: DownloadStatus.downloading),
        ]),
        DownloadGroupStatus.downloading,
      );
      expect(
        downloadGroupStatus([_job('s1', status: DownloadStatus.queued)]),
        DownloadGroupStatus.downloading,
      );
    });

    test('all failed -> error', () {
      expect(
        downloadGroupStatus([_job('s1', status: DownloadStatus.failed)]),
        DownloadGroupStatus.error,
      );
    });

    test('mixed or none/removed only -> incomplete', () {
      expect(
        downloadGroupStatus([
          _job('s1', status: DownloadStatus.completed),
          _job('s2', status: DownloadStatus.failed),
        ]),
        DownloadGroupStatus.incomplete,
      );
      expect(
        downloadGroupStatus([_job('s1', status: DownloadStatus.removed)]),
        DownloadGroupStatus.incomplete,
      );
      expect(
        downloadGroupStatus([_job('s1', status: DownloadStatus.none)]),
        DownloadGroupStatus.incomplete,
      );
    });

    test('empty input -> incomplete', () {
      expect(downloadGroupStatus([]), DownloadGroupStatus.incomplete);
    });
  });

  group('downloadGroupsProvider', () {
    test('groups by first-appearance album order, keeps insertion order', () {
      final groups = _groups(
        DownloadState(
          downloads: IList([
            _job('s1', albumId: 'a', status: DownloadStatus.queued),
            _job('s2', albumId: 'b', status: DownloadStatus.queued),
            _job('s3', albumId: 'a', status: DownloadStatus.downloading),
          ]),
        ),
      );

      expect(groups.map((g) => g.albumId).toList(), ['a', 'b']);
      expect(groups.first.downloads.map((d) => d.songId).toList(), [
        's1',
        's3',
      ]);
      expect(groups[1].downloads.map((d) => d.songId).toList(), ['s2']);
    });

    test('status transitions never re-sort groups or rows', () {
      final before = _groups(
        DownloadState(
          downloads: IList([
            _job('s1', albumId: 'a', status: DownloadStatus.queued),
            _job('s2', albumId: 'b', status: DownloadStatus.downloading),
            _job('s3', albumId: 'a', status: DownloadStatus.completed),
          ]),
        ),
      );
      final after = _groups(
        DownloadState(
          downloads: IList([
            _job('s1', albumId: 'a', status: DownloadStatus.downloading),
            _job('s2', albumId: 'b', status: DownloadStatus.completed),
            _job('s3', albumId: 'a', status: DownloadStatus.completed),
          ]),
        ),
      );

      expect(
        before.map((g) => g.albumId).toList(),
        after.map((g) => g.albumId).toList(),
      );
      expect(
        before.first.downloads.map((d) => d.songId).toList(),
        after.first.downloads.map((d) => d.songId).toList(),
      );
    });

    test('loose songs bucket into a single null-keyed group', () {
      final groups = _groups(
        DownloadState(
          downloads: IList([
            _job('s1', status: DownloadStatus.failed),
            _job('s2', status: DownloadStatus.queued),
          ]),
        ),
      );

      expect(groups, hasLength(1));
      expect(groups.single.albumId, isNull);
      expect(groups.single.downloads.map((d) => d.songId).toList(), [
        's1',
        's2',
      ]);
      expect(groups.single.status, DownloadGroupStatus.downloading);
    });
  });

  group('TTL + clear', () {
    testWidgets('sweep prunes expired completed jobs, retains fresh + active', (
      tester,
    ) async {
      final now = DateTime.now();
      final container = ProviderContainer(
        overrides: [
          mediaDownloadServiceProvider.overrideWith(
            () => SeededService(
              DownloadState(
                downloads: IList([
                  _job(
                    'expired',
                    status: DownloadStatus.completed,
                    completedAt: now.subtract(const Duration(minutes: 3)),
                  ),
                  _job(
                    'fresh',
                    status: DownloadStatus.completed,
                    completedAt: now.subtract(const Duration(minutes: 1)),
                  ),
                  _job('failed', status: DownloadStatus.failed),
                ]),
              ),
            ),
          ),
        ],
      );
      addTearDown(container.dispose);

      container.read(mediaDownloadServiceProvider);
      expect(
        container.read(mediaDownloadServiceProvider).downloads,
        hasLength(3),
      );

      // First sweep at 30s drops the job whose completedAt is past the TTL.
      await tester.pump(const Duration(seconds: 31));

      final downloads = container.read(mediaDownloadServiceProvider).downloads;
      expect(downloads.map((d) => d.songId), ['fresh', 'failed']);
      container.dispose();
    });

    testWidgets('completed jobs are retained before expiry', (tester) async {
      final now = DateTime.now();
      final container = ProviderContainer(
        overrides: [
          mediaDownloadServiceProvider.overrideWith(
            () => SeededService(
              DownloadState(
                downloads: IList([
                  _job(
                    'fresh',
                    status: DownloadStatus.completed,
                    completedAt: now.subtract(const Duration(seconds: 30)),
                  ),
                ]),
              ),
            ),
          ),
        ],
      );
      addTearDown(container.dispose);

      container.read(mediaDownloadServiceProvider);
      await tester.pump(const Duration(seconds: 31));

      expect(
        container.read(mediaDownloadServiceProvider).downloads,
        hasLength(1),
      );
      container.dispose();
    });

    testWidgets('clearCompleted removes all completed jobs immediately', (
      tester,
    ) async {
      final now = DateTime.now();
      final container = ProviderContainer(
        overrides: [
          mediaDownloadServiceProvider.overrideWith(
            () => SeededService(
              DownloadState(
                downloads: IList([
                  _job(
                    'done',
                    status: DownloadStatus.completed,
                    completedAt: now,
                  ),
                  _job('failed', status: DownloadStatus.failed),
                ]),
              ),
            ),
          ),
        ],
      );
      addTearDown(container.dispose);

      container.read(mediaDownloadServiceProvider.notifier).clearCompleted();

      final downloads = container.read(mediaDownloadServiceProvider).downloads;
      expect(downloads.map((d) => d.songId), ['failed']);
      container.dispose();
    });
  });

  group('DownloadsPage', () {
    Future<void> pump(WidgetTester tester, DownloadState state) async {
      final db = SyncDatabase.connection(NativeDatabase.memory());
      addTearDown(db.close);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            downloadsProvider.overrideWithValue(state),
            musicSourceProvider.overrideWithValue(null),
            databaseProvider.overrideWithValue(db),
          ],
          child: const MaterialApp(home: DownloadsPage()),
        ),
      );
      await tester.pump();
    }

    testWidgets('album with active jobs auto-expands and shows per-song rows', (
      tester,
    ) async {
      await pump(
        tester,
        DownloadState(
          downloads: IList([
            _job(
              's1',
              albumId: 'a',
              status: DownloadStatus.queued,
              title: 'Track One',
              album: 'Alpha',
              albumArtist: 'Artist',
              artist: 'Artist',
            ),
            _job(
              's2',
              albumId: 'a',
              status: DownloadStatus.downloading,
              progress: 42,
              title: 'Track Two',
              album: 'Alpha',
              albumArtist: 'Artist',
              artist: 'Artist',
            ),
          ]),
        ),
      );

      expect(find.text('Alpha'), findsOneWidget);
      expect(find.text('Track One'), findsOneWidget);
      expect(find.text('Track Two'), findsOneWidget);
      expect(find.text('42%'), findsOneWidget);
      expect(find.text('Downloading'), findsOneWidget);
    });

    testWidgets('album auto-collapses with successful when all jobs complete', (
      tester,
    ) async {
      await pump(
        tester,
        DownloadState(
          downloads: IList([
            _job(
              's1',
              albumId: 'a',
              status: DownloadStatus.completed,
              progress: 100,
              title: 'Track One',
              album: 'Alpha',
              albumArtist: 'Artist',
            ),
            _job(
              's2',
              albumId: 'a',
              status: DownloadStatus.completed,
              progress: 100,
              title: 'Track Two',
              album: 'Alpha',
              albumArtist: 'Artist',
            ),
          ]),
        ),
      );

      expect(find.text('Alpha'), findsOneWidget);
      expect(find.text('2/2'), findsOneWidget);
      expect(find.text('Successful'), findsOneWidget);
      expect(find.text('Track One'), findsNothing);
    });

    testWidgets('loose songs render under the fixed "Other downloads" bucket', (
      tester,
    ) async {
      await pump(
        tester,
        DownloadState(
          downloads: IList([
            _job('s1', status: DownloadStatus.failed, title: 'Loose One'),
            _job('s2', status: DownloadStatus.queued, title: 'Loose Two'),
          ]),
        ),
      );

      expect(find.text('Other downloads'), findsOneWidget);
      expect(find.text('Loose One'), findsOneWidget);
      expect(find.text('Loose Two'), findsOneWidget);
    });
  });
}
