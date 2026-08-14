import 'package:path/path.dart' as p;

/// Strips characters that are illegal in file/folder names on common
/// filesystems and collapses whitespace runs.
String sanitizePathSegment(String input) {
  final cleaned = input
      .replaceAll(RegExp(r'[/\\:*?"<>|\x00-\x1F]'), ' ')
      .trim()
      .replaceAll(RegExp(r'\s+'), ' ');
  return cleaned.isEmpty ? 'Unknown' : cleaned;
}

/// `<Album>` or `[<Year>] <Album>` (year omitted when unknown).
String albumFolderName(String albumName, int? year) {
  final name = sanitizePathSegment(albumName);
  if (year == null) return name;
  return '[$year] $name';
}

/// `<disc>-<track> - <title>.opus`, disc omitted when unknown or `1`.
String trackFileName(int? disc, int? track, String title) {
  final sanitized = sanitizePathSegment(title);
  final prefix = [
    if (disc != null && disc > 1) disc.toString().padLeft(2, '0'),
    if (track != null) track.toString().padLeft(2, '0'),
  ].join('-');
  return prefix.isEmpty ? '$sanitized.opus' : '$prefix - $sanitized.opus';
}

/// Album folder policy (blueprint §2#4 / §4.1).
///
/// Returns a **relative** path under `library_root`:
/// 1. `<Album Artist>/[<Year>] <Album>` when an album artist is present;
/// 2. `Various Artists/[<Year>] <Album>` when track artists differ;
/// 3. otherwise the common (single) track artist;
/// 4. fall back to `Unknown Artist`.
String resolveAlbumFolder({
  String? albumArtist,
  int? year,
  required String albumName,
  required Iterable<String?> trackArtists,
}) {
  final folder = albumFolderName(albumName, year);

  if (albumArtist != null && albumArtist.isNotEmpty) {
    return p.join(sanitizePathSegment(albumArtist), folder);
  }

  final artists = trackArtists
      .whereType<String>()
      .map((e) => e.trim())
      .where((e) => e.isNotEmpty)
      .toSet();

  if (artists.length == 1) {
    return p.join(sanitizePathSegment(artists.first), folder);
  }

  return p.join('Various Artists', folder);
}
