// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'query.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Pagination {

 int get limit; int get offset;
/// Create a copy of Pagination
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaginationCopyWith<Pagination> get copyWith => _$PaginationCopyWithImpl<Pagination>(this as Pagination, _$identity);

  /// Serializes this Pagination to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Pagination&&(identical(other.limit, limit) || other.limit == limit)&&(identical(other.offset, offset) || other.offset == offset));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,limit,offset);

@override
String toString() {
  return 'Pagination(limit: $limit, offset: $offset)';
}


}

/// @nodoc
abstract mixin class $PaginationCopyWith<$Res>  {
  factory $PaginationCopyWith(Pagination value, $Res Function(Pagination) _then) = _$PaginationCopyWithImpl;
@useResult
$Res call({
 int limit, int offset
});




}
/// @nodoc
class _$PaginationCopyWithImpl<$Res>
    implements $PaginationCopyWith<$Res> {
  _$PaginationCopyWithImpl(this._self, this._then);

  final Pagination _self;
  final $Res Function(Pagination) _then;

/// Create a copy of Pagination
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? limit = null,Object? offset = null,}) {
  return _then(_self.copyWith(
limit: null == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int,offset: null == offset ? _self.offset : offset // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [Pagination].
extension PaginationPatterns on Pagination {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Pagination value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Pagination() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Pagination value)  $default,){
final _that = this;
switch (_that) {
case _Pagination():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Pagination value)?  $default,){
final _that = this;
switch (_that) {
case _Pagination() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int limit,  int offset)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Pagination() when $default != null:
return $default(_that.limit,_that.offset);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int limit,  int offset)  $default,) {final _that = this;
switch (_that) {
case _Pagination():
return $default(_that.limit,_that.offset);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int limit,  int offset)?  $default,) {final _that = this;
switch (_that) {
case _Pagination() when $default != null:
return $default(_that.limit,_that.offset);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Pagination implements Pagination {
  const _Pagination({required this.limit, this.offset = 0});
  factory _Pagination.fromJson(Map<String, dynamic> json) => _$PaginationFromJson(json);

@override final  int limit;
@override@JsonKey() final  int offset;

/// Create a copy of Pagination
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaginationCopyWith<_Pagination> get copyWith => __$PaginationCopyWithImpl<_Pagination>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PaginationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Pagination&&(identical(other.limit, limit) || other.limit == limit)&&(identical(other.offset, offset) || other.offset == offset));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,limit,offset);

@override
String toString() {
  return 'Pagination(limit: $limit, offset: $offset)';
}


}

/// @nodoc
abstract mixin class _$PaginationCopyWith<$Res> implements $PaginationCopyWith<$Res> {
  factory _$PaginationCopyWith(_Pagination value, $Res Function(_Pagination) _then) = __$PaginationCopyWithImpl;
@override @useResult
$Res call({
 int limit, int offset
});




}
/// @nodoc
class __$PaginationCopyWithImpl<$Res>
    implements _$PaginationCopyWith<$Res> {
  __$PaginationCopyWithImpl(this._self, this._then);

  final _Pagination _self;
  final $Res Function(_Pagination) _then;

/// Create a copy of Pagination
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? limit = null,Object? offset = null,}) {
  return _then(_Pagination(
limit: null == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int,offset: null == offset ? _self.offset : offset // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$SortBy {

 String get column; SortDirection get dir;
/// Create a copy of SortBy
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SortByCopyWith<SortBy> get copyWith => _$SortByCopyWithImpl<SortBy>(this as SortBy, _$identity);

  /// Serializes this SortBy to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SortBy&&(identical(other.column, column) || other.column == column)&&(identical(other.dir, dir) || other.dir == dir));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,column,dir);

@override
String toString() {
  return 'SortBy(column: $column, dir: $dir)';
}


}

/// @nodoc
abstract mixin class $SortByCopyWith<$Res>  {
  factory $SortByCopyWith(SortBy value, $Res Function(SortBy) _then) = _$SortByCopyWithImpl;
@useResult
$Res call({
 String column, SortDirection dir
});




}
/// @nodoc
class _$SortByCopyWithImpl<$Res>
    implements $SortByCopyWith<$Res> {
  _$SortByCopyWithImpl(this._self, this._then);

  final SortBy _self;
  final $Res Function(SortBy) _then;

/// Create a copy of SortBy
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? column = null,Object? dir = null,}) {
  return _then(_self.copyWith(
column: null == column ? _self.column : column // ignore: cast_nullable_to_non_nullable
as String,dir: null == dir ? _self.dir : dir // ignore: cast_nullable_to_non_nullable
as SortDirection,
  ));
}

}


/// Adds pattern-matching-related methods to [SortBy].
extension SortByPatterns on SortBy {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SortBy value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SortBy() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SortBy value)  $default,){
final _that = this;
switch (_that) {
case _SortBy():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SortBy value)?  $default,){
final _that = this;
switch (_that) {
case _SortBy() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String column,  SortDirection dir)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SortBy() when $default != null:
return $default(_that.column,_that.dir);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String column,  SortDirection dir)  $default,) {final _that = this;
switch (_that) {
case _SortBy():
return $default(_that.column,_that.dir);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String column,  SortDirection dir)?  $default,) {final _that = this;
switch (_that) {
case _SortBy() when $default != null:
return $default(_that.column,_that.dir);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SortBy implements SortBy {
  const _SortBy({required this.column, this.dir = SortDirection.asc});
  factory _SortBy.fromJson(Map<String, dynamic> json) => _$SortByFromJson(json);

@override final  String column;
@override@JsonKey() final  SortDirection dir;

/// Create a copy of SortBy
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SortByCopyWith<_SortBy> get copyWith => __$SortByCopyWithImpl<_SortBy>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SortByToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SortBy&&(identical(other.column, column) || other.column == column)&&(identical(other.dir, dir) || other.dir == dir));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,column,dir);

@override
String toString() {
  return 'SortBy(column: $column, dir: $dir)';
}


}

/// @nodoc
abstract mixin class _$SortByCopyWith<$Res> implements $SortByCopyWith<$Res> {
  factory _$SortByCopyWith(_SortBy value, $Res Function(_SortBy) _then) = __$SortByCopyWithImpl;
@override @useResult
$Res call({
 String column, SortDirection dir
});




}
/// @nodoc
class __$SortByCopyWithImpl<$Res>
    implements _$SortByCopyWith<$Res> {
  __$SortByCopyWithImpl(this._self, this._then);

  final _SortBy _self;
  final $Res Function(_SortBy) _then;

/// Create a copy of SortBy
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? column = null,Object? dir = null,}) {
  return _then(_SortBy(
column: null == column ? _self.column : column // ignore: cast_nullable_to_non_nullable
as String,dir: null == dir ? _self.dir : dir // ignore: cast_nullable_to_non_nullable
as SortDirection,
  ));
}


}

FilterWith _$FilterWithFromJson(
  Map<String, dynamic> json
) {
    return _FilterWithIsNull.fromJson(
      json
    );
}

/// @nodoc
mixin _$FilterWith {

 String get column; bool get invert;
/// Create a copy of FilterWith
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FilterWithCopyWith<FilterWith> get copyWith => _$FilterWithCopyWithImpl<FilterWith>(this as FilterWith, _$identity);

  /// Serializes this FilterWith to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FilterWith&&(identical(other.column, column) || other.column == column)&&(identical(other.invert, invert) || other.invert == invert));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,column,invert);

@override
String toString() {
  return 'FilterWith(column: $column, invert: $invert)';
}


}

/// @nodoc
abstract mixin class $FilterWithCopyWith<$Res>  {
  factory $FilterWithCopyWith(FilterWith value, $Res Function(FilterWith) _then) = _$FilterWithCopyWithImpl;
@useResult
$Res call({
 String column, bool invert
});




}
/// @nodoc
class _$FilterWithCopyWithImpl<$Res>
    implements $FilterWithCopyWith<$Res> {
  _$FilterWithCopyWithImpl(this._self, this._then);

  final FilterWith _self;
  final $Res Function(FilterWith) _then;

/// Create a copy of FilterWith
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? column = null,Object? invert = null,}) {
  return _then(_self.copyWith(
column: null == column ? _self.column : column // ignore: cast_nullable_to_non_nullable
as String,invert: null == invert ? _self.invert : invert // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [FilterWith].
extension FilterWithPatterns on FilterWith {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _FilterWithIsNull value)?  isNull,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FilterWithIsNull() when isNull != null:
return isNull(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _FilterWithIsNull value)  isNull,}){
final _that = this;
switch (_that) {
case _FilterWithIsNull():
return isNull(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _FilterWithIsNull value)?  isNull,}){
final _that = this;
switch (_that) {
case _FilterWithIsNull() when isNull != null:
return isNull(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String column,  bool invert)?  isNull,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FilterWithIsNull() when isNull != null:
return isNull(_that.column,_that.invert);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String column,  bool invert)  isNull,}) {final _that = this;
switch (_that) {
case _FilterWithIsNull():
return isNull(_that.column,_that.invert);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String column,  bool invert)?  isNull,}) {final _that = this;
switch (_that) {
case _FilterWithIsNull() when isNull != null:
return isNull(_that.column,_that.invert);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FilterWithIsNull implements FilterWith {
  const _FilterWithIsNull({required this.column, this.invert = false});
  factory _FilterWithIsNull.fromJson(Map<String, dynamic> json) => _$FilterWithIsNullFromJson(json);

@override final  String column;
@override@JsonKey() final  bool invert;

/// Create a copy of FilterWith
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FilterWithIsNullCopyWith<_FilterWithIsNull> get copyWith => __$FilterWithIsNullCopyWithImpl<_FilterWithIsNull>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FilterWithIsNullToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FilterWithIsNull&&(identical(other.column, column) || other.column == column)&&(identical(other.invert, invert) || other.invert == invert));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,column,invert);

@override
String toString() {
  return 'FilterWith.isNull(column: $column, invert: $invert)';
}


}

/// @nodoc
abstract mixin class _$FilterWithIsNullCopyWith<$Res> implements $FilterWithCopyWith<$Res> {
  factory _$FilterWithIsNullCopyWith(_FilterWithIsNull value, $Res Function(_FilterWithIsNull) _then) = __$FilterWithIsNullCopyWithImpl;
@override @useResult
$Res call({
 String column, bool invert
});




}
/// @nodoc
class __$FilterWithIsNullCopyWithImpl<$Res>
    implements _$FilterWithIsNullCopyWith<$Res> {
  __$FilterWithIsNullCopyWithImpl(this._self, this._then);

  final _FilterWithIsNull _self;
  final $Res Function(_FilterWithIsNull) _then;

/// Create a copy of FilterWith
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? column = null,Object? invert = null,}) {
  return _then(_FilterWithIsNull(
column: null == column ? _self.column : column // ignore: cast_nullable_to_non_nullable
as String,invert: null == invert ? _self.invert : invert // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$ListQuery {

 Pagination get page; SortBy? get sort; IList<FilterWith> get filters;
/// Create a copy of ListQuery
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ListQueryCopyWith<ListQuery> get copyWith => _$ListQueryCopyWithImpl<ListQuery>(this as ListQuery, _$identity);

  /// Serializes this ListQuery to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ListQuery&&(identical(other.page, page) || other.page == page)&&(identical(other.sort, sort) || other.sort == sort)&&const DeepCollectionEquality().equals(other.filters, filters));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,page,sort,const DeepCollectionEquality().hash(filters));

@override
String toString() {
  return 'ListQuery(page: $page, sort: $sort, filters: $filters)';
}


}

/// @nodoc
abstract mixin class $ListQueryCopyWith<$Res>  {
  factory $ListQueryCopyWith(ListQuery value, $Res Function(ListQuery) _then) = _$ListQueryCopyWithImpl;
@useResult
$Res call({
 Pagination page, SortBy? sort, IList<FilterWith> filters
});


$PaginationCopyWith<$Res> get page;$SortByCopyWith<$Res>? get sort;

}
/// @nodoc
class _$ListQueryCopyWithImpl<$Res>
    implements $ListQueryCopyWith<$Res> {
  _$ListQueryCopyWithImpl(this._self, this._then);

  final ListQuery _self;
  final $Res Function(ListQuery) _then;

/// Create a copy of ListQuery
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? page = null,Object? sort = freezed,Object? filters = null,}) {
  return _then(_self.copyWith(
page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as Pagination,sort: freezed == sort ? _self.sort : sort // ignore: cast_nullable_to_non_nullable
as SortBy?,filters: null == filters ? _self.filters : filters // ignore: cast_nullable_to_non_nullable
as IList<FilterWith>,
  ));
}
/// Create a copy of ListQuery
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaginationCopyWith<$Res> get page {
  
  return $PaginationCopyWith<$Res>(_self.page, (value) {
    return _then(_self.copyWith(page: value));
  });
}/// Create a copy of ListQuery
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SortByCopyWith<$Res>? get sort {
    if (_self.sort == null) {
    return null;
  }

  return $SortByCopyWith<$Res>(_self.sort!, (value) {
    return _then(_self.copyWith(sort: value));
  });
}
}


/// Adds pattern-matching-related methods to [ListQuery].
extension ListQueryPatterns on ListQuery {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ListQuery value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ListQuery() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ListQuery value)  $default,){
final _that = this;
switch (_that) {
case _ListQuery():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ListQuery value)?  $default,){
final _that = this;
switch (_that) {
case _ListQuery() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Pagination page,  SortBy? sort,  IList<FilterWith> filters)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ListQuery() when $default != null:
return $default(_that.page,_that.sort,_that.filters);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Pagination page,  SortBy? sort,  IList<FilterWith> filters)  $default,) {final _that = this;
switch (_that) {
case _ListQuery():
return $default(_that.page,_that.sort,_that.filters);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Pagination page,  SortBy? sort,  IList<FilterWith> filters)?  $default,) {final _that = this;
switch (_that) {
case _ListQuery() when $default != null:
return $default(_that.page,_that.sort,_that.filters);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ListQuery implements ListQuery {
  const _ListQuery({this.page = const Pagination(limit: -1, offset: 0), this.sort, this.filters = const IListConst([])});
  factory _ListQuery.fromJson(Map<String, dynamic> json) => _$ListQueryFromJson(json);

@override@JsonKey() final  Pagination page;
@override final  SortBy? sort;
@override@JsonKey() final  IList<FilterWith> filters;

/// Create a copy of ListQuery
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ListQueryCopyWith<_ListQuery> get copyWith => __$ListQueryCopyWithImpl<_ListQuery>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ListQueryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ListQuery&&(identical(other.page, page) || other.page == page)&&(identical(other.sort, sort) || other.sort == sort)&&const DeepCollectionEquality().equals(other.filters, filters));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,page,sort,const DeepCollectionEquality().hash(filters));

@override
String toString() {
  return 'ListQuery(page: $page, sort: $sort, filters: $filters)';
}


}

/// @nodoc
abstract mixin class _$ListQueryCopyWith<$Res> implements $ListQueryCopyWith<$Res> {
  factory _$ListQueryCopyWith(_ListQuery value, $Res Function(_ListQuery) _then) = __$ListQueryCopyWithImpl;
@override @useResult
$Res call({
 Pagination page, SortBy? sort, IList<FilterWith> filters
});


@override $PaginationCopyWith<$Res> get page;@override $SortByCopyWith<$Res>? get sort;

}
/// @nodoc
class __$ListQueryCopyWithImpl<$Res>
    implements _$ListQueryCopyWith<$Res> {
  __$ListQueryCopyWithImpl(this._self, this._then);

  final _ListQuery _self;
  final $Res Function(_ListQuery) _then;

/// Create a copy of ListQuery
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? page = null,Object? sort = freezed,Object? filters = null,}) {
  return _then(_ListQuery(
page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as Pagination,sort: freezed == sort ? _self.sort : sort // ignore: cast_nullable_to_non_nullable
as SortBy?,filters: null == filters ? _self.filters : filters // ignore: cast_nullable_to_non_nullable
as IList<FilterWith>,
  ));
}

/// Create a copy of ListQuery
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaginationCopyWith<$Res> get page {
  
  return $PaginationCopyWith<$Res>(_self.page, (value) {
    return _then(_self.copyWith(page: value));
  });
}/// Create a copy of ListQuery
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SortByCopyWith<$Res>? get sort {
    if (_self.sort == null) {
    return null;
  }

  return $SortByCopyWith<$Res>(_self.sort!, (value) {
    return _then(_self.copyWith(sort: value));
  });
}
}

/// @nodoc
mixin _$ListQueryOptions {

 IList<String> get sortColumns; IList<String> get filterColumns;
/// Create a copy of ListQueryOptions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ListQueryOptionsCopyWith<ListQueryOptions> get copyWith => _$ListQueryOptionsCopyWithImpl<ListQueryOptions>(this as ListQueryOptions, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ListQueryOptions&&const DeepCollectionEquality().equals(other.sortColumns, sortColumns)&&const DeepCollectionEquality().equals(other.filterColumns, filterColumns));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(sortColumns),const DeepCollectionEquality().hash(filterColumns));

@override
String toString() {
  return 'ListQueryOptions(sortColumns: $sortColumns, filterColumns: $filterColumns)';
}


}

/// @nodoc
abstract mixin class $ListQueryOptionsCopyWith<$Res>  {
  factory $ListQueryOptionsCopyWith(ListQueryOptions value, $Res Function(ListQueryOptions) _then) = _$ListQueryOptionsCopyWithImpl;
@useResult
$Res call({
 IList<String> sortColumns, IList<String> filterColumns
});




}
/// @nodoc
class _$ListQueryOptionsCopyWithImpl<$Res>
    implements $ListQueryOptionsCopyWith<$Res> {
  _$ListQueryOptionsCopyWithImpl(this._self, this._then);

  final ListQueryOptions _self;
  final $Res Function(ListQueryOptions) _then;

/// Create a copy of ListQueryOptions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sortColumns = null,Object? filterColumns = null,}) {
  return _then(_self.copyWith(
sortColumns: null == sortColumns ? _self.sortColumns : sortColumns // ignore: cast_nullable_to_non_nullable
as IList<String>,filterColumns: null == filterColumns ? _self.filterColumns : filterColumns // ignore: cast_nullable_to_non_nullable
as IList<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [ListQueryOptions].
extension ListQueryOptionsPatterns on ListQueryOptions {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ListQueryOptions value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ListQueryOptions() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ListQueryOptions value)  $default,){
final _that = this;
switch (_that) {
case _ListQueryOptions():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ListQueryOptions value)?  $default,){
final _that = this;
switch (_that) {
case _ListQueryOptions() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( IList<String> sortColumns,  IList<String> filterColumns)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ListQueryOptions() when $default != null:
return $default(_that.sortColumns,_that.filterColumns);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( IList<String> sortColumns,  IList<String> filterColumns)  $default,) {final _that = this;
switch (_that) {
case _ListQueryOptions():
return $default(_that.sortColumns,_that.filterColumns);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( IList<String> sortColumns,  IList<String> filterColumns)?  $default,) {final _that = this;
switch (_that) {
case _ListQueryOptions() when $default != null:
return $default(_that.sortColumns,_that.filterColumns);case _:
  return null;

}
}

}

/// @nodoc


class _ListQueryOptions implements ListQueryOptions {
  const _ListQueryOptions({required this.sortColumns, required this.filterColumns});
  

@override final  IList<String> sortColumns;
@override final  IList<String> filterColumns;

/// Create a copy of ListQueryOptions
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ListQueryOptionsCopyWith<_ListQueryOptions> get copyWith => __$ListQueryOptionsCopyWithImpl<_ListQueryOptions>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ListQueryOptions&&const DeepCollectionEquality().equals(other.sortColumns, sortColumns)&&const DeepCollectionEquality().equals(other.filterColumns, filterColumns));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(sortColumns),const DeepCollectionEquality().hash(filterColumns));

@override
String toString() {
  return 'ListQueryOptions(sortColumns: $sortColumns, filterColumns: $filterColumns)';
}


}

/// @nodoc
abstract mixin class _$ListQueryOptionsCopyWith<$Res> implements $ListQueryOptionsCopyWith<$Res> {
  factory _$ListQueryOptionsCopyWith(_ListQueryOptions value, $Res Function(_ListQueryOptions) _then) = __$ListQueryOptionsCopyWithImpl;
@override @useResult
$Res call({
 IList<String> sortColumns, IList<String> filterColumns
});




}
/// @nodoc
class __$ListQueryOptionsCopyWithImpl<$Res>
    implements _$ListQueryOptionsCopyWith<$Res> {
  __$ListQueryOptionsCopyWithImpl(this._self, this._then);

  final _ListQueryOptions _self;
  final $Res Function(_ListQueryOptions) _then;

/// Create a copy of ListQueryOptions
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sortColumns = null,Object? filterColumns = null,}) {
  return _then(_ListQueryOptions(
sortColumns: null == sortColumns ? _self.sortColumns : sortColumns // ignore: cast_nullable_to_non_nullable
as IList<String>,filterColumns: null == filterColumns ? _self.filterColumns : filterColumns // ignore: cast_nullable_to_non_nullable
as IList<String>,
  ));
}


}

/// @nodoc
mixin _$LibraryListQuery {

 ListQueryOptions get options; ListQuery get query;
/// Create a copy of LibraryListQuery
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LibraryListQueryCopyWith<LibraryListQuery> get copyWith => _$LibraryListQueryCopyWithImpl<LibraryListQuery>(this as LibraryListQuery, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LibraryListQuery&&(identical(other.options, options) || other.options == options)&&(identical(other.query, query) || other.query == query));
}


@override
int get hashCode => Object.hash(runtimeType,options,query);

@override
String toString() {
  return 'LibraryListQuery(options: $options, query: $query)';
}


}

/// @nodoc
abstract mixin class $LibraryListQueryCopyWith<$Res>  {
  factory $LibraryListQueryCopyWith(LibraryListQuery value, $Res Function(LibraryListQuery) _then) = _$LibraryListQueryCopyWithImpl;
@useResult
$Res call({
 ListQueryOptions options, ListQuery query
});


$ListQueryOptionsCopyWith<$Res> get options;$ListQueryCopyWith<$Res> get query;

}
/// @nodoc
class _$LibraryListQueryCopyWithImpl<$Res>
    implements $LibraryListQueryCopyWith<$Res> {
  _$LibraryListQueryCopyWithImpl(this._self, this._then);

  final LibraryListQuery _self;
  final $Res Function(LibraryListQuery) _then;

/// Create a copy of LibraryListQuery
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? options = null,Object? query = null,}) {
  return _then(_self.copyWith(
options: null == options ? _self.options : options // ignore: cast_nullable_to_non_nullable
as ListQueryOptions,query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as ListQuery,
  ));
}
/// Create a copy of LibraryListQuery
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ListQueryOptionsCopyWith<$Res> get options {
  
  return $ListQueryOptionsCopyWith<$Res>(_self.options, (value) {
    return _then(_self.copyWith(options: value));
  });
}/// Create a copy of LibraryListQuery
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ListQueryCopyWith<$Res> get query {
  
  return $ListQueryCopyWith<$Res>(_self.query, (value) {
    return _then(_self.copyWith(query: value));
  });
}
}


/// Adds pattern-matching-related methods to [LibraryListQuery].
extension LibraryListQueryPatterns on LibraryListQuery {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LibraryListQuery value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LibraryListQuery() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LibraryListQuery value)  $default,){
final _that = this;
switch (_that) {
case _LibraryListQuery():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LibraryListQuery value)?  $default,){
final _that = this;
switch (_that) {
case _LibraryListQuery() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ListQueryOptions options,  ListQuery query)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LibraryListQuery() when $default != null:
return $default(_that.options,_that.query);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ListQueryOptions options,  ListQuery query)  $default,) {final _that = this;
switch (_that) {
case _LibraryListQuery():
return $default(_that.options,_that.query);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ListQueryOptions options,  ListQuery query)?  $default,) {final _that = this;
switch (_that) {
case _LibraryListQuery() when $default != null:
return $default(_that.options,_that.query);case _:
  return null;

}
}

}

/// @nodoc


class _LibraryListQuery implements LibraryListQuery {
  const _LibraryListQuery({required this.options, required this.query});
  

@override final  ListQueryOptions options;
@override final  ListQuery query;

/// Create a copy of LibraryListQuery
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LibraryListQueryCopyWith<_LibraryListQuery> get copyWith => __$LibraryListQueryCopyWithImpl<_LibraryListQuery>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LibraryListQuery&&(identical(other.options, options) || other.options == options)&&(identical(other.query, query) || other.query == query));
}


@override
int get hashCode => Object.hash(runtimeType,options,query);

@override
String toString() {
  return 'LibraryListQuery(options: $options, query: $query)';
}


}

/// @nodoc
abstract mixin class _$LibraryListQueryCopyWith<$Res> implements $LibraryListQueryCopyWith<$Res> {
  factory _$LibraryListQueryCopyWith(_LibraryListQuery value, $Res Function(_LibraryListQuery) _then) = __$LibraryListQueryCopyWithImpl;
@override @useResult
$Res call({
 ListQueryOptions options, ListQuery query
});


@override $ListQueryOptionsCopyWith<$Res> get options;@override $ListQueryCopyWith<$Res> get query;

}
/// @nodoc
class __$LibraryListQueryCopyWithImpl<$Res>
    implements _$LibraryListQueryCopyWith<$Res> {
  __$LibraryListQueryCopyWithImpl(this._self, this._then);

  final _LibraryListQuery _self;
  final $Res Function(_LibraryListQuery) _then;

/// Create a copy of LibraryListQuery
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? options = null,Object? query = null,}) {
  return _then(_LibraryListQuery(
options: null == options ? _self.options : options // ignore: cast_nullable_to_non_nullable
as ListQueryOptions,query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as ListQuery,
  ));
}

/// Create a copy of LibraryListQuery
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ListQueryOptionsCopyWith<$Res> get options {
  
  return $ListQueryOptionsCopyWith<$Res>(_self.options, (value) {
    return _then(_self.copyWith(options: value));
  });
}/// Create a copy of LibraryListQuery
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ListQueryCopyWith<$Res> get query {
  
  return $ListQueryCopyWith<$Res>(_self.query, (value) {
    return _then(_self.copyWith(query: value));
  });
}
}

// dart format on
