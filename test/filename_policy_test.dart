import 'package:flutter_test/flutter_test.dart';
import 'package:subsynic/services/filename_policy.dart';

void main() {
  group('sanitizePathSegment', () {
    test('strips illegal filesystem characters', () {
      expect(sanitizePathSegment('A/B:C*D?E"F<G>H|I'), 'A B C D E F G H I');
    });

    test('collapses whitespace runs', () {
      expect(sanitizePathSegment('  Some   Album  '), 'Some Album');
    });

    test('falls back to Unknown for empty input', () {
      expect(sanitizePathSegment('   '), 'Unknown');
    });
  });

  group('albumFolderName', () {
    test('omits year when unknown', () {
      expect(albumFolderName('Album Name', null), 'Album Name');
    });

    test('includes year when known', () {
      expect(albumFolderName('Album Name', 2001), '[2001] Album Name');
    });
  });

  group('trackFileName', () {
    test('omits disc when unknown or 1', () {
      expect(trackFileName(null, 3, 'Song'), '03 - Song.opus');
      expect(trackFileName(1, 3, 'Song'), '03 - Song.opus');
    });

    test('includes disc when > 1', () {
      expect(trackFileName(2, 3, 'Song'), '02-03 - Song.opus');
    });

    test('handles missing track', () {
      expect(trackFileName(1, null, 'Song'), 'Song.opus');
    });

    test('sanitizes the title', () {
      expect(trackFileName(1, 1, 'A/B:C'), '01 - A B C.opus');
    });
  });

  group('resolveAlbumFolder', () {
    test('prefers album artist', () {
      final folder = resolveAlbumFolder(
        albumArtist: 'Radiohead',
        year: 1997,
        albumName: 'OK Computer',
        trackArtists: const ['Radiohead'],
      );
      expect(folder, 'Radiohead/[1997] OK Computer');
    });

    test('uses Various Artists when track artists differ and no album artist',
        () {
      final folder = resolveAlbumFolder(
        albumArtist: null,
        year: 2000,
        albumName: 'Compilation',
        trackArtists: const ['Artist A', 'Artist B'],
      );
      expect(folder, 'Various Artists/[2000] Compilation');
    });

    test('uses the common track artist when no album artist', () {
      final folder = resolveAlbumFolder(
        albumArtist: null,
        year: null,
        albumName: 'Album',
        trackArtists: const ['Artist X', 'Artist X'],
      );
      expect(folder, 'Artist X/Album');
    });

    test('falls back to Various Artists with no artists at all', () {
      final folder = resolveAlbumFolder(
        albumArtist: null,
        year: null,
        albumName: 'Album',
        trackArtists: const [],
      );
      expect(folder, 'Various Artists/Album');
    });

    test('strips illegal characters from artist and album names', () {
      final folder = resolveAlbumFolder(
        albumArtist: 'A/B',
        year: 1999,
        albumName: 'C:D',
        trackArtists: const [],
      );
      expect(folder, 'A B/[1999] C D');
    });
  });
}
