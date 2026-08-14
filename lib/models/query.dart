import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'query.freezed.dart';
part 'query.g.dart';

enum SortDirection {
  asc('ASC'),
  desc('DESC');

  const SortDirection(this.value);
  final String value;
}

@freezed
abstract class Pagination with _$Pagination {
  const factory Pagination({
    required int limit,
    @Default(0) int offset,
  }) = _Pagination;

  factory Pagination.fromJson(Map<String, dynamic> json) =>
      _$PaginationFromJson(json);
}

@freezed
abstract class SortBy with _$SortBy {
  const factory SortBy({
    required String column,
    @Default(SortDirection.asc) SortDirection dir,
  }) = _SortBy;

  factory SortBy.fromJson(Map<String, dynamic> json) => _$SortByFromJson(json);
}

@freezed
abstract class FilterWith with _$FilterWith {
  const factory FilterWith.isNull({
    required String column,
    @Default(false) bool invert,
  }) = _FilterWithIsNull;

  factory FilterWith.fromJson(Map<String, dynamic> json) =>
      _$FilterWithFromJson(json);
}

@freezed
abstract class ListQuery with _$ListQuery {
  const factory ListQuery({
    @Default(Pagination(limit: -1, offset: 0)) Pagination page,
    SortBy? sort,
    @Default(IListConst([])) IList<FilterWith> filters,
  }) = _ListQuery;

  factory ListQuery.fromJson(Map<String, dynamic> json) =>
      _$ListQueryFromJson(json);
}

@freezed
abstract class ListQueryOptions with _$ListQueryOptions {
  const factory ListQueryOptions({
    required IList<String> sortColumns,
    required IList<String> filterColumns,
  }) = _ListQueryOptions;
}

@freezed
abstract class LibraryListQuery with _$LibraryListQuery {
  const factory LibraryListQuery({
    required ListQueryOptions options,
    required ListQuery query,
  }) = _LibraryListQuery;
}
