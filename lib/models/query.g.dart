// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'query.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Pagination _$PaginationFromJson(Map<String, dynamic> json) => _Pagination(
  limit: (json['limit'] as num).toInt(),
  offset: (json['offset'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$PaginationToJson(_Pagination instance) =>
    <String, dynamic>{'limit': instance.limit, 'offset': instance.offset};

_SortBy _$SortByFromJson(Map<String, dynamic> json) => _SortBy(
  column: json['column'] as String,
  dir:
      $enumDecodeNullable(_$SortDirectionEnumMap, json['dir']) ??
      SortDirection.asc,
);

Map<String, dynamic> _$SortByToJson(_SortBy instance) => <String, dynamic>{
  'column': instance.column,
  'dir': _$SortDirectionEnumMap[instance.dir]!,
};

const _$SortDirectionEnumMap = {
  SortDirection.asc: 'asc',
  SortDirection.desc: 'desc',
};

_FilterWithIsNull _$FilterWithIsNullFromJson(Map<String, dynamic> json) =>
    _FilterWithIsNull(
      column: json['column'] as String,
      invert: json['invert'] as bool? ?? false,
    );

Map<String, dynamic> _$FilterWithIsNullToJson(_FilterWithIsNull instance) =>
    <String, dynamic>{'column': instance.column, 'invert': instance.invert};

_ListQuery _$ListQueryFromJson(Map<String, dynamic> json) => _ListQuery(
  page: json['page'] == null
      ? const Pagination(limit: -1, offset: 0)
      : Pagination.fromJson(json['page'] as Map<String, dynamic>),
  sort: json['sort'] == null
      ? null
      : SortBy.fromJson(json['sort'] as Map<String, dynamic>),
  filters: json['filters'] == null
      ? const IListConst([])
      : IList<FilterWith>.fromJson(
          json['filters'],
          (value) => FilterWith.fromJson(value as Map<String, dynamic>),
        ),
);

Map<String, dynamic> _$ListQueryToJson(_ListQuery instance) =>
    <String, dynamic>{
      'page': instance.page,
      'sort': instance.sort,
      'filters': instance.filters.toJson((value) => value),
    };
