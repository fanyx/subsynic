import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/download.dart';
import '../services/media_download.dart';

part 'downloads.g.dart';

@Riverpod(keepAlive: true)
DownloadState downloads(Ref ref) {
  return ref.watch(mediaDownloadServiceProvider);
}

const _looseKey = '';

/// Groups the flat session jobs by album (first-appearance order, never
/// re-sorted) and derives each group's combined status. Loose songs (no
/// `albumId`) bucket under a single null-keyed group.
@riverpod
IList<DownloadGroup> downloadGroups(Ref ref) {
  final state = ref.watch(downloadsProvider);
  final jobs = state.downloads;
  if (jobs.isEmpty) return const IListConst([]);

  final buckets = <String, List<Download>>{};
  final order = <String>[];
  for (final job in jobs) {
    final key = job.albumId ?? _looseKey;
    if (!buckets.containsKey(key)) {
      buckets[key] = [];
      order.add(key);
    }
    buckets[key]!.add(job);
  }

  return order
      .map(
        (key) => DownloadGroup(
          albumId: key == _looseKey ? null : key,
          downloads: buckets[key]!.toIList(),
          status: downloadGroupStatus(buckets[key]!),
        ),
      )
      .toIList();
}
