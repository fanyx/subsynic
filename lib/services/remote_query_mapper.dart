import '../models/music.dart';
import '../models/query.dart';
import '../models/remote_query.dart';

AlbumListRequest mapAlbumsQuery(ListQuery q, {String? search}) {
  var type = _albumTypeFor(q.sort?.column);

  for (final f in q.filters) {
    f.whenOrNull(isNull: (column, invert) {
      if (!invert) return;
      switch (column) {
        case 'albums.year':
          type = AlbumListType.byYear;
      }
    });
  }

  int? fromYear;
  int? toYear;
  if (type == AlbumListType.byYear) {
    fromYear = 1;
    toYear = 9999;
  }

  return AlbumListRequest(
    type: type,
    page: q.page,
    fromYear: fromYear,
    toYear: toYear,
  );
}

AlbumListType _albumTypeFor(String? column) {
  switch (column) {
    case 'albums.year':
      return AlbumListType.byYear;
    case 'albums.album_artist':
      return AlbumListType.alphabeticalByArtist;
    case 'albums.name':
    default:
      return AlbumListType.alphabeticalByName;
  }
}

List<Artist> mapArtistsQuery(List<Artist> all, ListQuery q) {
  var result = List<Artist>.of(all);

  final sort = q.sort;
  if (sort != null) {
    switch (sort.column) {
      case 'artists.album_count':
        result.sort((a, b) => a.albumCount.compareTo(b.albumCount));
      case 'artists.name':
      default:
        result.sort(
            (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    }
    if (sort.dir == SortDirection.desc) {
      result = result.reversed.toList();
    }
  }

  return result;
}

List<Playlist> mapPlaylistsQuery(List<Playlist> all, ListQuery q) {
  var result = List<Playlist>.of(all);

  for (final f in q.filters) {
    result = f.whenOrNull(
          isNull: (column, invert) => result
              .where((p) => invert == (_playlistValue(p, column) != null))
              .toList(),
        ) ??
        result;
  }

  final sort = q.sort;
  if (sort != null) {
    switch (sort.column) {
      case 'playlists.name':
      default:
        result.sort(
            (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    }
    if (sort.dir == SortDirection.desc) {
      result = result.reversed.toList();
    }
  }

  return result;
}

Object? _playlistValue(Playlist p, String column) {
  switch (column) {
    case 'playlists.name':
      return p.name;
    default:
      return null;
  }
}

List<Playlist> filterPlaylistsBySearch(List<Playlist> all, String query) {
  final q = query.toLowerCase();
  return all.where((p) => p.name.toLowerCase().contains(q)).toList();
}

List<T> slice<T>(List<T> all, Pagination page) {
  if (page.limit <= 0) return List.of(all);
  final start = page.offset.clamp(0, all.length);
  final end = (page.offset + page.limit).clamp(0, all.length);
  return all.sublist(start, end);
}
