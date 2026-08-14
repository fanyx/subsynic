// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'remote_query.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AlbumListRequest {

 AlbumListType get type; Pagination get page; int? get fromYear; int? get toYear; String? get genre; String? get musicFolderId;
/// Create a copy of AlbumListRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AlbumListRequestCopyWith<AlbumListRequest> get copyWith => _$AlbumListRequestCopyWithImpl<AlbumListRequest>(this as AlbumListRequest, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AlbumListRequest&&(identical(other.type, type) || other.type == type)&&(identical(other.page, page) || other.page == page)&&(identical(other.fromYear, fromYear) || other.fromYear == fromYear)&&(identical(other.toYear, toYear) || other.toYear == toYear)&&(identical(other.genre, genre) || other.genre == genre)&&(identical(other.musicFolderId, musicFolderId) || other.musicFolderId == musicFolderId));
}


@override
int get hashCode => Object.hash(runtimeType,type,page,fromYear,toYear,genre,musicFolderId);

@override
String toString() {
  return 'AlbumListRequest(type: $type, page: $page, fromYear: $fromYear, toYear: $toYear, genre: $genre, musicFolderId: $musicFolderId)';
}


}

/// @nodoc
abstract mixin class $AlbumListRequestCopyWith<$Res>  {
  factory $AlbumListRequestCopyWith(AlbumListRequest value, $Res Function(AlbumListRequest) _then) = _$AlbumListRequestCopyWithImpl;
@useResult
$Res call({
 AlbumListType type, Pagination page, int? fromYear, int? toYear, String? genre, String? musicFolderId
});


$PaginationCopyWith<$Res> get page;

}
/// @nodoc
class _$AlbumListRequestCopyWithImpl<$Res>
    implements $AlbumListRequestCopyWith<$Res> {
  _$AlbumListRequestCopyWithImpl(this._self, this._then);

  final AlbumListRequest _self;
  final $Res Function(AlbumListRequest) _then;

/// Create a copy of AlbumListRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? page = null,Object? fromYear = freezed,Object? toYear = freezed,Object? genre = freezed,Object? musicFolderId = freezed,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as AlbumListType,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as Pagination,fromYear: freezed == fromYear ? _self.fromYear : fromYear // ignore: cast_nullable_to_non_nullable
as int?,toYear: freezed == toYear ? _self.toYear : toYear // ignore: cast_nullable_to_non_nullable
as int?,genre: freezed == genre ? _self.genre : genre // ignore: cast_nullable_to_non_nullable
as String?,musicFolderId: freezed == musicFolderId ? _self.musicFolderId : musicFolderId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of AlbumListRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaginationCopyWith<$Res> get page {
  
  return $PaginationCopyWith<$Res>(_self.page, (value) {
    return _then(_self.copyWith(page: value));
  });
}
}


/// Adds pattern-matching-related methods to [AlbumListRequest].
extension AlbumListRequestPatterns on AlbumListRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AlbumListRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AlbumListRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AlbumListRequest value)  $default,){
final _that = this;
switch (_that) {
case _AlbumListRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AlbumListRequest value)?  $default,){
final _that = this;
switch (_that) {
case _AlbumListRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AlbumListType type,  Pagination page,  int? fromYear,  int? toYear,  String? genre,  String? musicFolderId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AlbumListRequest() when $default != null:
return $default(_that.type,_that.page,_that.fromYear,_that.toYear,_that.genre,_that.musicFolderId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AlbumListType type,  Pagination page,  int? fromYear,  int? toYear,  String? genre,  String? musicFolderId)  $default,) {final _that = this;
switch (_that) {
case _AlbumListRequest():
return $default(_that.type,_that.page,_that.fromYear,_that.toYear,_that.genre,_that.musicFolderId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AlbumListType type,  Pagination page,  int? fromYear,  int? toYear,  String? genre,  String? musicFolderId)?  $default,) {final _that = this;
switch (_that) {
case _AlbumListRequest() when $default != null:
return $default(_that.type,_that.page,_that.fromYear,_that.toYear,_that.genre,_that.musicFolderId);case _:
  return null;

}
}

}

/// @nodoc


class _AlbumListRequest implements AlbumListRequest {
  const _AlbumListRequest({required this.type, this.page = const Pagination(limit: 60), this.fromYear, this.toYear, this.genre, this.musicFolderId});
  

@override final  AlbumListType type;
@override@JsonKey() final  Pagination page;
@override final  int? fromYear;
@override final  int? toYear;
@override final  String? genre;
@override final  String? musicFolderId;

/// Create a copy of AlbumListRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AlbumListRequestCopyWith<_AlbumListRequest> get copyWith => __$AlbumListRequestCopyWithImpl<_AlbumListRequest>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AlbumListRequest&&(identical(other.type, type) || other.type == type)&&(identical(other.page, page) || other.page == page)&&(identical(other.fromYear, fromYear) || other.fromYear == fromYear)&&(identical(other.toYear, toYear) || other.toYear == toYear)&&(identical(other.genre, genre) || other.genre == genre)&&(identical(other.musicFolderId, musicFolderId) || other.musicFolderId == musicFolderId));
}


@override
int get hashCode => Object.hash(runtimeType,type,page,fromYear,toYear,genre,musicFolderId);

@override
String toString() {
  return 'AlbumListRequest(type: $type, page: $page, fromYear: $fromYear, toYear: $toYear, genre: $genre, musicFolderId: $musicFolderId)';
}


}

/// @nodoc
abstract mixin class _$AlbumListRequestCopyWith<$Res> implements $AlbumListRequestCopyWith<$Res> {
  factory _$AlbumListRequestCopyWith(_AlbumListRequest value, $Res Function(_AlbumListRequest) _then) = __$AlbumListRequestCopyWithImpl;
@override @useResult
$Res call({
 AlbumListType type, Pagination page, int? fromYear, int? toYear, String? genre, String? musicFolderId
});


@override $PaginationCopyWith<$Res> get page;

}
/// @nodoc
class __$AlbumListRequestCopyWithImpl<$Res>
    implements _$AlbumListRequestCopyWith<$Res> {
  __$AlbumListRequestCopyWithImpl(this._self, this._then);

  final _AlbumListRequest _self;
  final $Res Function(_AlbumListRequest) _then;

/// Create a copy of AlbumListRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? page = null,Object? fromYear = freezed,Object? toYear = freezed,Object? genre = freezed,Object? musicFolderId = freezed,}) {
  return _then(_AlbumListRequest(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as AlbumListType,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as Pagination,fromYear: freezed == fromYear ? _self.fromYear : fromYear // ignore: cast_nullable_to_non_nullable
as int?,toYear: freezed == toYear ? _self.toYear : toYear // ignore: cast_nullable_to_non_nullable
as int?,genre: freezed == genre ? _self.genre : genre // ignore: cast_nullable_to_non_nullable
as String?,musicFolderId: freezed == musicFolderId ? _self.musicFolderId : musicFolderId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of AlbumListRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaginationCopyWith<$Res> get page {
  
  return $PaginationCopyWith<$Res>(_self.page, (value) {
    return _then(_self.copyWith(page: value));
  });
}
}

/// @nodoc
mixin _$ArtistDetail {

 Artist get artist; IList<Album> get albums;
/// Create a copy of ArtistDetail
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ArtistDetailCopyWith<ArtistDetail> get copyWith => _$ArtistDetailCopyWithImpl<ArtistDetail>(this as ArtistDetail, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ArtistDetail&&(identical(other.artist, artist) || other.artist == artist)&&const DeepCollectionEquality().equals(other.albums, albums));
}


@override
int get hashCode => Object.hash(runtimeType,artist,const DeepCollectionEquality().hash(albums));

@override
String toString() {
  return 'ArtistDetail(artist: $artist, albums: $albums)';
}


}

/// @nodoc
abstract mixin class $ArtistDetailCopyWith<$Res>  {
  factory $ArtistDetailCopyWith(ArtistDetail value, $Res Function(ArtistDetail) _then) = _$ArtistDetailCopyWithImpl;
@useResult
$Res call({
 Artist artist, IList<Album> albums
});


$ArtistCopyWith<$Res> get artist;

}
/// @nodoc
class _$ArtistDetailCopyWithImpl<$Res>
    implements $ArtistDetailCopyWith<$Res> {
  _$ArtistDetailCopyWithImpl(this._self, this._then);

  final ArtistDetail _self;
  final $Res Function(ArtistDetail) _then;

/// Create a copy of ArtistDetail
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? artist = null,Object? albums = null,}) {
  return _then(_self.copyWith(
artist: null == artist ? _self.artist : artist // ignore: cast_nullable_to_non_nullable
as Artist,albums: null == albums ? _self.albums : albums // ignore: cast_nullable_to_non_nullable
as IList<Album>,
  ));
}
/// Create a copy of ArtistDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ArtistCopyWith<$Res> get artist {
  
  return $ArtistCopyWith<$Res>(_self.artist, (value) {
    return _then(_self.copyWith(artist: value));
  });
}
}


/// Adds pattern-matching-related methods to [ArtistDetail].
extension ArtistDetailPatterns on ArtistDetail {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ArtistDetail value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ArtistDetail() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ArtistDetail value)  $default,){
final _that = this;
switch (_that) {
case _ArtistDetail():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ArtistDetail value)?  $default,){
final _that = this;
switch (_that) {
case _ArtistDetail() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Artist artist,  IList<Album> albums)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ArtistDetail() when $default != null:
return $default(_that.artist,_that.albums);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Artist artist,  IList<Album> albums)  $default,) {final _that = this;
switch (_that) {
case _ArtistDetail():
return $default(_that.artist,_that.albums);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Artist artist,  IList<Album> albums)?  $default,) {final _that = this;
switch (_that) {
case _ArtistDetail() when $default != null:
return $default(_that.artist,_that.albums);case _:
  return null;

}
}

}

/// @nodoc


class _ArtistDetail implements ArtistDetail {
  const _ArtistDetail({required this.artist, required this.albums});
  

@override final  Artist artist;
@override final  IList<Album> albums;

/// Create a copy of ArtistDetail
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ArtistDetailCopyWith<_ArtistDetail> get copyWith => __$ArtistDetailCopyWithImpl<_ArtistDetail>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ArtistDetail&&(identical(other.artist, artist) || other.artist == artist)&&const DeepCollectionEquality().equals(other.albums, albums));
}


@override
int get hashCode => Object.hash(runtimeType,artist,const DeepCollectionEquality().hash(albums));

@override
String toString() {
  return 'ArtistDetail(artist: $artist, albums: $albums)';
}


}

/// @nodoc
abstract mixin class _$ArtistDetailCopyWith<$Res> implements $ArtistDetailCopyWith<$Res> {
  factory _$ArtistDetailCopyWith(_ArtistDetail value, $Res Function(_ArtistDetail) _then) = __$ArtistDetailCopyWithImpl;
@override @useResult
$Res call({
 Artist artist, IList<Album> albums
});


@override $ArtistCopyWith<$Res> get artist;

}
/// @nodoc
class __$ArtistDetailCopyWithImpl<$Res>
    implements _$ArtistDetailCopyWith<$Res> {
  __$ArtistDetailCopyWithImpl(this._self, this._then);

  final _ArtistDetail _self;
  final $Res Function(_ArtistDetail) _then;

/// Create a copy of ArtistDetail
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? artist = null,Object? albums = null,}) {
  return _then(_ArtistDetail(
artist: null == artist ? _self.artist : artist // ignore: cast_nullable_to_non_nullable
as Artist,albums: null == albums ? _self.albums : albums // ignore: cast_nullable_to_non_nullable
as IList<Album>,
  ));
}

/// Create a copy of ArtistDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ArtistCopyWith<$Res> get artist {
  
  return $ArtistCopyWith<$Res>(_self.artist, (value) {
    return _then(_self.copyWith(artist: value));
  });
}
}

/// @nodoc
mixin _$AlbumDetail {

 Album get album; IList<Song> get songs;
/// Create a copy of AlbumDetail
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AlbumDetailCopyWith<AlbumDetail> get copyWith => _$AlbumDetailCopyWithImpl<AlbumDetail>(this as AlbumDetail, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AlbumDetail&&(identical(other.album, album) || other.album == album)&&const DeepCollectionEquality().equals(other.songs, songs));
}


@override
int get hashCode => Object.hash(runtimeType,album,const DeepCollectionEquality().hash(songs));

@override
String toString() {
  return 'AlbumDetail(album: $album, songs: $songs)';
}


}

/// @nodoc
abstract mixin class $AlbumDetailCopyWith<$Res>  {
  factory $AlbumDetailCopyWith(AlbumDetail value, $Res Function(AlbumDetail) _then) = _$AlbumDetailCopyWithImpl;
@useResult
$Res call({
 Album album, IList<Song> songs
});


$AlbumCopyWith<$Res> get album;

}
/// @nodoc
class _$AlbumDetailCopyWithImpl<$Res>
    implements $AlbumDetailCopyWith<$Res> {
  _$AlbumDetailCopyWithImpl(this._self, this._then);

  final AlbumDetail _self;
  final $Res Function(AlbumDetail) _then;

/// Create a copy of AlbumDetail
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? album = null,Object? songs = null,}) {
  return _then(_self.copyWith(
album: null == album ? _self.album : album // ignore: cast_nullable_to_non_nullable
as Album,songs: null == songs ? _self.songs : songs // ignore: cast_nullable_to_non_nullable
as IList<Song>,
  ));
}
/// Create a copy of AlbumDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AlbumCopyWith<$Res> get album {
  
  return $AlbumCopyWith<$Res>(_self.album, (value) {
    return _then(_self.copyWith(album: value));
  });
}
}


/// Adds pattern-matching-related methods to [AlbumDetail].
extension AlbumDetailPatterns on AlbumDetail {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AlbumDetail value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AlbumDetail() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AlbumDetail value)  $default,){
final _that = this;
switch (_that) {
case _AlbumDetail():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AlbumDetail value)?  $default,){
final _that = this;
switch (_that) {
case _AlbumDetail() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Album album,  IList<Song> songs)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AlbumDetail() when $default != null:
return $default(_that.album,_that.songs);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Album album,  IList<Song> songs)  $default,) {final _that = this;
switch (_that) {
case _AlbumDetail():
return $default(_that.album,_that.songs);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Album album,  IList<Song> songs)?  $default,) {final _that = this;
switch (_that) {
case _AlbumDetail() when $default != null:
return $default(_that.album,_that.songs);case _:
  return null;

}
}

}

/// @nodoc


class _AlbumDetail implements AlbumDetail {
  const _AlbumDetail({required this.album, required this.songs});
  

@override final  Album album;
@override final  IList<Song> songs;

/// Create a copy of AlbumDetail
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AlbumDetailCopyWith<_AlbumDetail> get copyWith => __$AlbumDetailCopyWithImpl<_AlbumDetail>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AlbumDetail&&(identical(other.album, album) || other.album == album)&&const DeepCollectionEquality().equals(other.songs, songs));
}


@override
int get hashCode => Object.hash(runtimeType,album,const DeepCollectionEquality().hash(songs));

@override
String toString() {
  return 'AlbumDetail(album: $album, songs: $songs)';
}


}

/// @nodoc
abstract mixin class _$AlbumDetailCopyWith<$Res> implements $AlbumDetailCopyWith<$Res> {
  factory _$AlbumDetailCopyWith(_AlbumDetail value, $Res Function(_AlbumDetail) _then) = __$AlbumDetailCopyWithImpl;
@override @useResult
$Res call({
 Album album, IList<Song> songs
});


@override $AlbumCopyWith<$Res> get album;

}
/// @nodoc
class __$AlbumDetailCopyWithImpl<$Res>
    implements _$AlbumDetailCopyWith<$Res> {
  __$AlbumDetailCopyWithImpl(this._self, this._then);

  final _AlbumDetail _self;
  final $Res Function(_AlbumDetail) _then;

/// Create a copy of AlbumDetail
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? album = null,Object? songs = null,}) {
  return _then(_AlbumDetail(
album: null == album ? _self.album : album // ignore: cast_nullable_to_non_nullable
as Album,songs: null == songs ? _self.songs : songs // ignore: cast_nullable_to_non_nullable
as IList<Song>,
  ));
}

/// Create a copy of AlbumDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AlbumCopyWith<$Res> get album {
  
  return $AlbumCopyWith<$Res>(_self.album, (value) {
    return _then(_self.copyWith(album: value));
  });
}
}

/// @nodoc
mixin _$PlaylistDetail {

 Playlist get playlist; IList<Song> get songs;
/// Create a copy of PlaylistDetail
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlaylistDetailCopyWith<PlaylistDetail> get copyWith => _$PlaylistDetailCopyWithImpl<PlaylistDetail>(this as PlaylistDetail, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlaylistDetail&&(identical(other.playlist, playlist) || other.playlist == playlist)&&const DeepCollectionEquality().equals(other.songs, songs));
}


@override
int get hashCode => Object.hash(runtimeType,playlist,const DeepCollectionEquality().hash(songs));

@override
String toString() {
  return 'PlaylistDetail(playlist: $playlist, songs: $songs)';
}


}

/// @nodoc
abstract mixin class $PlaylistDetailCopyWith<$Res>  {
  factory $PlaylistDetailCopyWith(PlaylistDetail value, $Res Function(PlaylistDetail) _then) = _$PlaylistDetailCopyWithImpl;
@useResult
$Res call({
 Playlist playlist, IList<Song> songs
});


$PlaylistCopyWith<$Res> get playlist;

}
/// @nodoc
class _$PlaylistDetailCopyWithImpl<$Res>
    implements $PlaylistDetailCopyWith<$Res> {
  _$PlaylistDetailCopyWithImpl(this._self, this._then);

  final PlaylistDetail _self;
  final $Res Function(PlaylistDetail) _then;

/// Create a copy of PlaylistDetail
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? playlist = null,Object? songs = null,}) {
  return _then(_self.copyWith(
playlist: null == playlist ? _self.playlist : playlist // ignore: cast_nullable_to_non_nullable
as Playlist,songs: null == songs ? _self.songs : songs // ignore: cast_nullable_to_non_nullable
as IList<Song>,
  ));
}
/// Create a copy of PlaylistDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlaylistCopyWith<$Res> get playlist {
  
  return $PlaylistCopyWith<$Res>(_self.playlist, (value) {
    return _then(_self.copyWith(playlist: value));
  });
}
}


/// Adds pattern-matching-related methods to [PlaylistDetail].
extension PlaylistDetailPatterns on PlaylistDetail {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlaylistDetail value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlaylistDetail() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlaylistDetail value)  $default,){
final _that = this;
switch (_that) {
case _PlaylistDetail():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlaylistDetail value)?  $default,){
final _that = this;
switch (_that) {
case _PlaylistDetail() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Playlist playlist,  IList<Song> songs)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlaylistDetail() when $default != null:
return $default(_that.playlist,_that.songs);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Playlist playlist,  IList<Song> songs)  $default,) {final _that = this;
switch (_that) {
case _PlaylistDetail():
return $default(_that.playlist,_that.songs);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Playlist playlist,  IList<Song> songs)?  $default,) {final _that = this;
switch (_that) {
case _PlaylistDetail() when $default != null:
return $default(_that.playlist,_that.songs);case _:
  return null;

}
}

}

/// @nodoc


class _PlaylistDetail implements PlaylistDetail {
  const _PlaylistDetail({required this.playlist, required this.songs});
  

@override final  Playlist playlist;
@override final  IList<Song> songs;

/// Create a copy of PlaylistDetail
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlaylistDetailCopyWith<_PlaylistDetail> get copyWith => __$PlaylistDetailCopyWithImpl<_PlaylistDetail>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlaylistDetail&&(identical(other.playlist, playlist) || other.playlist == playlist)&&const DeepCollectionEquality().equals(other.songs, songs));
}


@override
int get hashCode => Object.hash(runtimeType,playlist,const DeepCollectionEquality().hash(songs));

@override
String toString() {
  return 'PlaylistDetail(playlist: $playlist, songs: $songs)';
}


}

/// @nodoc
abstract mixin class _$PlaylistDetailCopyWith<$Res> implements $PlaylistDetailCopyWith<$Res> {
  factory _$PlaylistDetailCopyWith(_PlaylistDetail value, $Res Function(_PlaylistDetail) _then) = __$PlaylistDetailCopyWithImpl;
@override @useResult
$Res call({
 Playlist playlist, IList<Song> songs
});


@override $PlaylistCopyWith<$Res> get playlist;

}
/// @nodoc
class __$PlaylistDetailCopyWithImpl<$Res>
    implements _$PlaylistDetailCopyWith<$Res> {
  __$PlaylistDetailCopyWithImpl(this._self, this._then);

  final _PlaylistDetail _self;
  final $Res Function(_PlaylistDetail) _then;

/// Create a copy of PlaylistDetail
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? playlist = null,Object? songs = null,}) {
  return _then(_PlaylistDetail(
playlist: null == playlist ? _self.playlist : playlist // ignore: cast_nullable_to_non_nullable
as Playlist,songs: null == songs ? _self.songs : songs // ignore: cast_nullable_to_non_nullable
as IList<Song>,
  ));
}

/// Create a copy of PlaylistDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlaylistCopyWith<$Res> get playlist {
  
  return $PlaylistCopyWith<$Res>(_self.playlist, (value) {
    return _then(_self.copyWith(playlist: value));
  });
}
}

// dart format on
