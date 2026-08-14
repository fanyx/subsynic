// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'download.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SongDownload {

 String get songId; String? get albumId; String? get localPath; DownloadStatus get downloadStatus; int get downloadProgress; bool get coverEmbedded;
/// Create a copy of SongDownload
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SongDownloadCopyWith<SongDownload> get copyWith => _$SongDownloadCopyWithImpl<SongDownload>(this as SongDownload, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SongDownload&&(identical(other.songId, songId) || other.songId == songId)&&(identical(other.albumId, albumId) || other.albumId == albumId)&&(identical(other.localPath, localPath) || other.localPath == localPath)&&(identical(other.downloadStatus, downloadStatus) || other.downloadStatus == downloadStatus)&&(identical(other.downloadProgress, downloadProgress) || other.downloadProgress == downloadProgress)&&(identical(other.coverEmbedded, coverEmbedded) || other.coverEmbedded == coverEmbedded));
}


@override
int get hashCode => Object.hash(runtimeType,songId,albumId,localPath,downloadStatus,downloadProgress,coverEmbedded);

@override
String toString() {
  return 'SongDownload(songId: $songId, albumId: $albumId, localPath: $localPath, downloadStatus: $downloadStatus, downloadProgress: $downloadProgress, coverEmbedded: $coverEmbedded)';
}


}

/// @nodoc
abstract mixin class $SongDownloadCopyWith<$Res>  {
  factory $SongDownloadCopyWith(SongDownload value, $Res Function(SongDownload) _then) = _$SongDownloadCopyWithImpl;
@useResult
$Res call({
 String songId, String? albumId, String? localPath, DownloadStatus downloadStatus, int downloadProgress, bool coverEmbedded
});




}
/// @nodoc
class _$SongDownloadCopyWithImpl<$Res>
    implements $SongDownloadCopyWith<$Res> {
  _$SongDownloadCopyWithImpl(this._self, this._then);

  final SongDownload _self;
  final $Res Function(SongDownload) _then;

/// Create a copy of SongDownload
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? songId = null,Object? albumId = freezed,Object? localPath = freezed,Object? downloadStatus = null,Object? downloadProgress = null,Object? coverEmbedded = null,}) {
  return _then(_self.copyWith(
songId: null == songId ? _self.songId : songId // ignore: cast_nullable_to_non_nullable
as String,albumId: freezed == albumId ? _self.albumId : albumId // ignore: cast_nullable_to_non_nullable
as String?,localPath: freezed == localPath ? _self.localPath : localPath // ignore: cast_nullable_to_non_nullable
as String?,downloadStatus: null == downloadStatus ? _self.downloadStatus : downloadStatus // ignore: cast_nullable_to_non_nullable
as DownloadStatus,downloadProgress: null == downloadProgress ? _self.downloadProgress : downloadProgress // ignore: cast_nullable_to_non_nullable
as int,coverEmbedded: null == coverEmbedded ? _self.coverEmbedded : coverEmbedded // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SongDownload].
extension SongDownloadPatterns on SongDownload {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SongDownload value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SongDownload() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SongDownload value)  $default,){
final _that = this;
switch (_that) {
case _SongDownload():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SongDownload value)?  $default,){
final _that = this;
switch (_that) {
case _SongDownload() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String songId,  String? albumId,  String? localPath,  DownloadStatus downloadStatus,  int downloadProgress,  bool coverEmbedded)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SongDownload() when $default != null:
return $default(_that.songId,_that.albumId,_that.localPath,_that.downloadStatus,_that.downloadProgress,_that.coverEmbedded);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String songId,  String? albumId,  String? localPath,  DownloadStatus downloadStatus,  int downloadProgress,  bool coverEmbedded)  $default,) {final _that = this;
switch (_that) {
case _SongDownload():
return $default(_that.songId,_that.albumId,_that.localPath,_that.downloadStatus,_that.downloadProgress,_that.coverEmbedded);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String songId,  String? albumId,  String? localPath,  DownloadStatus downloadStatus,  int downloadProgress,  bool coverEmbedded)?  $default,) {final _that = this;
switch (_that) {
case _SongDownload() when $default != null:
return $default(_that.songId,_that.albumId,_that.localPath,_that.downloadStatus,_that.downloadProgress,_that.coverEmbedded);case _:
  return null;

}
}

}

/// @nodoc


class _SongDownload implements SongDownload {
  const _SongDownload({required this.songId, this.albumId, this.localPath, this.downloadStatus = DownloadStatus.none, this.downloadProgress = 0, this.coverEmbedded = false});
  

@override final  String songId;
@override final  String? albumId;
@override final  String? localPath;
@override@JsonKey() final  DownloadStatus downloadStatus;
@override@JsonKey() final  int downloadProgress;
@override@JsonKey() final  bool coverEmbedded;

/// Create a copy of SongDownload
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SongDownloadCopyWith<_SongDownload> get copyWith => __$SongDownloadCopyWithImpl<_SongDownload>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SongDownload&&(identical(other.songId, songId) || other.songId == songId)&&(identical(other.albumId, albumId) || other.albumId == albumId)&&(identical(other.localPath, localPath) || other.localPath == localPath)&&(identical(other.downloadStatus, downloadStatus) || other.downloadStatus == downloadStatus)&&(identical(other.downloadProgress, downloadProgress) || other.downloadProgress == downloadProgress)&&(identical(other.coverEmbedded, coverEmbedded) || other.coverEmbedded == coverEmbedded));
}


@override
int get hashCode => Object.hash(runtimeType,songId,albumId,localPath,downloadStatus,downloadProgress,coverEmbedded);

@override
String toString() {
  return 'SongDownload(songId: $songId, albumId: $albumId, localPath: $localPath, downloadStatus: $downloadStatus, downloadProgress: $downloadProgress, coverEmbedded: $coverEmbedded)';
}


}

/// @nodoc
abstract mixin class _$SongDownloadCopyWith<$Res> implements $SongDownloadCopyWith<$Res> {
  factory _$SongDownloadCopyWith(_SongDownload value, $Res Function(_SongDownload) _then) = __$SongDownloadCopyWithImpl;
@override @useResult
$Res call({
 String songId, String? albumId, String? localPath, DownloadStatus downloadStatus, int downloadProgress, bool coverEmbedded
});




}
/// @nodoc
class __$SongDownloadCopyWithImpl<$Res>
    implements _$SongDownloadCopyWith<$Res> {
  __$SongDownloadCopyWithImpl(this._self, this._then);

  final _SongDownload _self;
  final $Res Function(_SongDownload) _then;

/// Create a copy of SongDownload
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? songId = null,Object? albumId = freezed,Object? localPath = freezed,Object? downloadStatus = null,Object? downloadProgress = null,Object? coverEmbedded = null,}) {
  return _then(_SongDownload(
songId: null == songId ? _self.songId : songId // ignore: cast_nullable_to_non_nullable
as String,albumId: freezed == albumId ? _self.albumId : albumId // ignore: cast_nullable_to_non_nullable
as String?,localPath: freezed == localPath ? _self.localPath : localPath // ignore: cast_nullable_to_non_nullable
as String?,downloadStatus: null == downloadStatus ? _self.downloadStatus : downloadStatus // ignore: cast_nullable_to_non_nullable
as DownloadStatus,downloadProgress: null == downloadProgress ? _self.downloadProgress : downloadProgress // ignore: cast_nullable_to_non_nullable
as int,coverEmbedded: null == coverEmbedded ? _self.coverEmbedded : coverEmbedded // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$Download {

 String get songId; String? get title; String? get artist; String? get album; String? get albumArtist; String? get coverArt; String? get albumId; DateTime? get completedAt; int get progress; DownloadStatus get status; String? get localPath; String? get error;
/// Create a copy of Download
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DownloadCopyWith<Download> get copyWith => _$DownloadCopyWithImpl<Download>(this as Download, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Download&&(identical(other.songId, songId) || other.songId == songId)&&(identical(other.title, title) || other.title == title)&&(identical(other.artist, artist) || other.artist == artist)&&(identical(other.album, album) || other.album == album)&&(identical(other.albumArtist, albumArtist) || other.albumArtist == albumArtist)&&(identical(other.coverArt, coverArt) || other.coverArt == coverArt)&&(identical(other.albumId, albumId) || other.albumId == albumId)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.status, status) || other.status == status)&&(identical(other.localPath, localPath) || other.localPath == localPath)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,songId,title,artist,album,albumArtist,coverArt,albumId,completedAt,progress,status,localPath,error);

@override
String toString() {
  return 'Download(songId: $songId, title: $title, artist: $artist, album: $album, albumArtist: $albumArtist, coverArt: $coverArt, albumId: $albumId, completedAt: $completedAt, progress: $progress, status: $status, localPath: $localPath, error: $error)';
}


}

/// @nodoc
abstract mixin class $DownloadCopyWith<$Res>  {
  factory $DownloadCopyWith(Download value, $Res Function(Download) _then) = _$DownloadCopyWithImpl;
@useResult
$Res call({
 String songId, String? title, String? artist, String? album, String? albumArtist, String? coverArt, String? albumId, DateTime? completedAt, int progress, DownloadStatus status, String? localPath, String? error
});




}
/// @nodoc
class _$DownloadCopyWithImpl<$Res>
    implements $DownloadCopyWith<$Res> {
  _$DownloadCopyWithImpl(this._self, this._then);

  final Download _self;
  final $Res Function(Download) _then;

/// Create a copy of Download
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? songId = null,Object? title = freezed,Object? artist = freezed,Object? album = freezed,Object? albumArtist = freezed,Object? coverArt = freezed,Object? albumId = freezed,Object? completedAt = freezed,Object? progress = null,Object? status = null,Object? localPath = freezed,Object? error = freezed,}) {
  return _then(_self.copyWith(
songId: null == songId ? _self.songId : songId // ignore: cast_nullable_to_non_nullable
as String,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,artist: freezed == artist ? _self.artist : artist // ignore: cast_nullable_to_non_nullable
as String?,album: freezed == album ? _self.album : album // ignore: cast_nullable_to_non_nullable
as String?,albumArtist: freezed == albumArtist ? _self.albumArtist : albumArtist // ignore: cast_nullable_to_non_nullable
as String?,coverArt: freezed == coverArt ? _self.coverArt : coverArt // ignore: cast_nullable_to_non_nullable
as String?,albumId: freezed == albumId ? _self.albumId : albumId // ignore: cast_nullable_to_non_nullable
as String?,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as DownloadStatus,localPath: freezed == localPath ? _self.localPath : localPath // ignore: cast_nullable_to_non_nullable
as String?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Download].
extension DownloadPatterns on Download {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Download value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Download() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Download value)  $default,){
final _that = this;
switch (_that) {
case _Download():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Download value)?  $default,){
final _that = this;
switch (_that) {
case _Download() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String songId,  String? title,  String? artist,  String? album,  String? albumArtist,  String? coverArt,  String? albumId,  DateTime? completedAt,  int progress,  DownloadStatus status,  String? localPath,  String? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Download() when $default != null:
return $default(_that.songId,_that.title,_that.artist,_that.album,_that.albumArtist,_that.coverArt,_that.albumId,_that.completedAt,_that.progress,_that.status,_that.localPath,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String songId,  String? title,  String? artist,  String? album,  String? albumArtist,  String? coverArt,  String? albumId,  DateTime? completedAt,  int progress,  DownloadStatus status,  String? localPath,  String? error)  $default,) {final _that = this;
switch (_that) {
case _Download():
return $default(_that.songId,_that.title,_that.artist,_that.album,_that.albumArtist,_that.coverArt,_that.albumId,_that.completedAt,_that.progress,_that.status,_that.localPath,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String songId,  String? title,  String? artist,  String? album,  String? albumArtist,  String? coverArt,  String? albumId,  DateTime? completedAt,  int progress,  DownloadStatus status,  String? localPath,  String? error)?  $default,) {final _that = this;
switch (_that) {
case _Download() when $default != null:
return $default(_that.songId,_that.title,_that.artist,_that.album,_that.albumArtist,_that.coverArt,_that.albumId,_that.completedAt,_that.progress,_that.status,_that.localPath,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _Download extends Download {
  const _Download({required this.songId, this.title, this.artist, this.album, this.albumArtist, this.coverArt, this.albumId, this.completedAt, required this.progress, required this.status, this.localPath, this.error}): super._();
  

@override final  String songId;
@override final  String? title;
@override final  String? artist;
@override final  String? album;
@override final  String? albumArtist;
@override final  String? coverArt;
@override final  String? albumId;
@override final  DateTime? completedAt;
@override final  int progress;
@override final  DownloadStatus status;
@override final  String? localPath;
@override final  String? error;

/// Create a copy of Download
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DownloadCopyWith<_Download> get copyWith => __$DownloadCopyWithImpl<_Download>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Download&&(identical(other.songId, songId) || other.songId == songId)&&(identical(other.title, title) || other.title == title)&&(identical(other.artist, artist) || other.artist == artist)&&(identical(other.album, album) || other.album == album)&&(identical(other.albumArtist, albumArtist) || other.albumArtist == albumArtist)&&(identical(other.coverArt, coverArt) || other.coverArt == coverArt)&&(identical(other.albumId, albumId) || other.albumId == albumId)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.status, status) || other.status == status)&&(identical(other.localPath, localPath) || other.localPath == localPath)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,songId,title,artist,album,albumArtist,coverArt,albumId,completedAt,progress,status,localPath,error);

@override
String toString() {
  return 'Download(songId: $songId, title: $title, artist: $artist, album: $album, albumArtist: $albumArtist, coverArt: $coverArt, albumId: $albumId, completedAt: $completedAt, progress: $progress, status: $status, localPath: $localPath, error: $error)';
}


}

/// @nodoc
abstract mixin class _$DownloadCopyWith<$Res> implements $DownloadCopyWith<$Res> {
  factory _$DownloadCopyWith(_Download value, $Res Function(_Download) _then) = __$DownloadCopyWithImpl;
@override @useResult
$Res call({
 String songId, String? title, String? artist, String? album, String? albumArtist, String? coverArt, String? albumId, DateTime? completedAt, int progress, DownloadStatus status, String? localPath, String? error
});




}
/// @nodoc
class __$DownloadCopyWithImpl<$Res>
    implements _$DownloadCopyWith<$Res> {
  __$DownloadCopyWithImpl(this._self, this._then);

  final _Download _self;
  final $Res Function(_Download) _then;

/// Create a copy of Download
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? songId = null,Object? title = freezed,Object? artist = freezed,Object? album = freezed,Object? albumArtist = freezed,Object? coverArt = freezed,Object? albumId = freezed,Object? completedAt = freezed,Object? progress = null,Object? status = null,Object? localPath = freezed,Object? error = freezed,}) {
  return _then(_Download(
songId: null == songId ? _self.songId : songId // ignore: cast_nullable_to_non_nullable
as String,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,artist: freezed == artist ? _self.artist : artist // ignore: cast_nullable_to_non_nullable
as String?,album: freezed == album ? _self.album : album // ignore: cast_nullable_to_non_nullable
as String?,albumArtist: freezed == albumArtist ? _self.albumArtist : albumArtist // ignore: cast_nullable_to_non_nullable
as String?,coverArt: freezed == coverArt ? _self.coverArt : coverArt // ignore: cast_nullable_to_non_nullable
as String?,albumId: freezed == albumId ? _self.albumId : albumId // ignore: cast_nullable_to_non_nullable
as String?,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as DownloadStatus,localPath: freezed == localPath ? _self.localPath : localPath // ignore: cast_nullable_to_non_nullable
as String?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$DownloadGroup {

 String? get albumId; IList<Download> get downloads; DownloadGroupStatus get status;
/// Create a copy of DownloadGroup
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DownloadGroupCopyWith<DownloadGroup> get copyWith => _$DownloadGroupCopyWithImpl<DownloadGroup>(this as DownloadGroup, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DownloadGroup&&(identical(other.albumId, albumId) || other.albumId == albumId)&&const DeepCollectionEquality().equals(other.downloads, downloads)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,albumId,const DeepCollectionEquality().hash(downloads),status);

@override
String toString() {
  return 'DownloadGroup(albumId: $albumId, downloads: $downloads, status: $status)';
}


}

/// @nodoc
abstract mixin class $DownloadGroupCopyWith<$Res>  {
  factory $DownloadGroupCopyWith(DownloadGroup value, $Res Function(DownloadGroup) _then) = _$DownloadGroupCopyWithImpl;
@useResult
$Res call({
 String? albumId, IList<Download> downloads, DownloadGroupStatus status
});




}
/// @nodoc
class _$DownloadGroupCopyWithImpl<$Res>
    implements $DownloadGroupCopyWith<$Res> {
  _$DownloadGroupCopyWithImpl(this._self, this._then);

  final DownloadGroup _self;
  final $Res Function(DownloadGroup) _then;

/// Create a copy of DownloadGroup
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? albumId = freezed,Object? downloads = null,Object? status = null,}) {
  return _then(_self.copyWith(
albumId: freezed == albumId ? _self.albumId : albumId // ignore: cast_nullable_to_non_nullable
as String?,downloads: null == downloads ? _self.downloads : downloads // ignore: cast_nullable_to_non_nullable
as IList<Download>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as DownloadGroupStatus,
  ));
}

}


/// Adds pattern-matching-related methods to [DownloadGroup].
extension DownloadGroupPatterns on DownloadGroup {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DownloadGroup value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DownloadGroup() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DownloadGroup value)  $default,){
final _that = this;
switch (_that) {
case _DownloadGroup():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DownloadGroup value)?  $default,){
final _that = this;
switch (_that) {
case _DownloadGroup() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? albumId,  IList<Download> downloads,  DownloadGroupStatus status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DownloadGroup() when $default != null:
return $default(_that.albumId,_that.downloads,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? albumId,  IList<Download> downloads,  DownloadGroupStatus status)  $default,) {final _that = this;
switch (_that) {
case _DownloadGroup():
return $default(_that.albumId,_that.downloads,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? albumId,  IList<Download> downloads,  DownloadGroupStatus status)?  $default,) {final _that = this;
switch (_that) {
case _DownloadGroup() when $default != null:
return $default(_that.albumId,_that.downloads,_that.status);case _:
  return null;

}
}

}

/// @nodoc


class _DownloadGroup implements DownloadGroup {
  const _DownloadGroup({this.albumId, required this.downloads, required this.status});
  

@override final  String? albumId;
@override final  IList<Download> downloads;
@override final  DownloadGroupStatus status;

/// Create a copy of DownloadGroup
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DownloadGroupCopyWith<_DownloadGroup> get copyWith => __$DownloadGroupCopyWithImpl<_DownloadGroup>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DownloadGroup&&(identical(other.albumId, albumId) || other.albumId == albumId)&&const DeepCollectionEquality().equals(other.downloads, downloads)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,albumId,const DeepCollectionEquality().hash(downloads),status);

@override
String toString() {
  return 'DownloadGroup(albumId: $albumId, downloads: $downloads, status: $status)';
}


}

/// @nodoc
abstract mixin class _$DownloadGroupCopyWith<$Res> implements $DownloadGroupCopyWith<$Res> {
  factory _$DownloadGroupCopyWith(_DownloadGroup value, $Res Function(_DownloadGroup) _then) = __$DownloadGroupCopyWithImpl;
@override @useResult
$Res call({
 String? albumId, IList<Download> downloads, DownloadGroupStatus status
});




}
/// @nodoc
class __$DownloadGroupCopyWithImpl<$Res>
    implements _$DownloadGroupCopyWith<$Res> {
  __$DownloadGroupCopyWithImpl(this._self, this._then);

  final _DownloadGroup _self;
  final $Res Function(_DownloadGroup) _then;

/// Create a copy of DownloadGroup
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? albumId = freezed,Object? downloads = null,Object? status = null,}) {
  return _then(_DownloadGroup(
albumId: freezed == albumId ? _self.albumId : albumId // ignore: cast_nullable_to_non_nullable
as String?,downloads: null == downloads ? _self.downloads : downloads // ignore: cast_nullable_to_non_nullable
as IList<Download>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as DownloadGroupStatus,
  ));
}


}

/// @nodoc
mixin _$DownloadState {

 IList<Download> get downloads; IList<String> get listDownloads; IList<String> get listCancels; IList<String> get deletes;
/// Create a copy of DownloadState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DownloadStateCopyWith<DownloadState> get copyWith => _$DownloadStateCopyWithImpl<DownloadState>(this as DownloadState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DownloadState&&const DeepCollectionEquality().equals(other.downloads, downloads)&&const DeepCollectionEquality().equals(other.listDownloads, listDownloads)&&const DeepCollectionEquality().equals(other.listCancels, listCancels)&&const DeepCollectionEquality().equals(other.deletes, deletes));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(downloads),const DeepCollectionEquality().hash(listDownloads),const DeepCollectionEquality().hash(listCancels),const DeepCollectionEquality().hash(deletes));

@override
String toString() {
  return 'DownloadState(downloads: $downloads, listDownloads: $listDownloads, listCancels: $listCancels, deletes: $deletes)';
}


}

/// @nodoc
abstract mixin class $DownloadStateCopyWith<$Res>  {
  factory $DownloadStateCopyWith(DownloadState value, $Res Function(DownloadState) _then) = _$DownloadStateCopyWithImpl;
@useResult
$Res call({
 IList<Download> downloads, IList<String> listDownloads, IList<String> listCancels, IList<String> deletes
});




}
/// @nodoc
class _$DownloadStateCopyWithImpl<$Res>
    implements $DownloadStateCopyWith<$Res> {
  _$DownloadStateCopyWithImpl(this._self, this._then);

  final DownloadState _self;
  final $Res Function(DownloadState) _then;

/// Create a copy of DownloadState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? downloads = null,Object? listDownloads = null,Object? listCancels = null,Object? deletes = null,}) {
  return _then(_self.copyWith(
downloads: null == downloads ? _self.downloads : downloads // ignore: cast_nullable_to_non_nullable
as IList<Download>,listDownloads: null == listDownloads ? _self.listDownloads : listDownloads // ignore: cast_nullable_to_non_nullable
as IList<String>,listCancels: null == listCancels ? _self.listCancels : listCancels // ignore: cast_nullable_to_non_nullable
as IList<String>,deletes: null == deletes ? _self.deletes : deletes // ignore: cast_nullable_to_non_nullable
as IList<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [DownloadState].
extension DownloadStatePatterns on DownloadState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DownloadState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DownloadState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DownloadState value)  $default,){
final _that = this;
switch (_that) {
case _DownloadState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DownloadState value)?  $default,){
final _that = this;
switch (_that) {
case _DownloadState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( IList<Download> downloads,  IList<String> listDownloads,  IList<String> listCancels,  IList<String> deletes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DownloadState() when $default != null:
return $default(_that.downloads,_that.listDownloads,_that.listCancels,_that.deletes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( IList<Download> downloads,  IList<String> listDownloads,  IList<String> listCancels,  IList<String> deletes)  $default,) {final _that = this;
switch (_that) {
case _DownloadState():
return $default(_that.downloads,_that.listDownloads,_that.listCancels,_that.deletes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( IList<Download> downloads,  IList<String> listDownloads,  IList<String> listCancels,  IList<String> deletes)?  $default,) {final _that = this;
switch (_that) {
case _DownloadState() when $default != null:
return $default(_that.downloads,_that.listDownloads,_that.listCancels,_that.deletes);case _:
  return null;

}
}

}

/// @nodoc


class _DownloadState extends DownloadState {
  const _DownloadState({this.downloads = const IListConst([]), this.listDownloads = const IListConst([]), this.listCancels = const IListConst([]), this.deletes = const IListConst([])}): super._();
  

@override@JsonKey() final  IList<Download> downloads;
@override@JsonKey() final  IList<String> listDownloads;
@override@JsonKey() final  IList<String> listCancels;
@override@JsonKey() final  IList<String> deletes;

/// Create a copy of DownloadState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DownloadStateCopyWith<_DownloadState> get copyWith => __$DownloadStateCopyWithImpl<_DownloadState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DownloadState&&const DeepCollectionEquality().equals(other.downloads, downloads)&&const DeepCollectionEquality().equals(other.listDownloads, listDownloads)&&const DeepCollectionEquality().equals(other.listCancels, listCancels)&&const DeepCollectionEquality().equals(other.deletes, deletes));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(downloads),const DeepCollectionEquality().hash(listDownloads),const DeepCollectionEquality().hash(listCancels),const DeepCollectionEquality().hash(deletes));

@override
String toString() {
  return 'DownloadState(downloads: $downloads, listDownloads: $listDownloads, listCancels: $listCancels, deletes: $deletes)';
}


}

/// @nodoc
abstract mixin class _$DownloadStateCopyWith<$Res> implements $DownloadStateCopyWith<$Res> {
  factory _$DownloadStateCopyWith(_DownloadState value, $Res Function(_DownloadState) _then) = __$DownloadStateCopyWithImpl;
@override @useResult
$Res call({
 IList<Download> downloads, IList<String> listDownloads, IList<String> listCancels, IList<String> deletes
});




}
/// @nodoc
class __$DownloadStateCopyWithImpl<$Res>
    implements _$DownloadStateCopyWith<$Res> {
  __$DownloadStateCopyWithImpl(this._self, this._then);

  final _DownloadState _self;
  final $Res Function(_DownloadState) _then;

/// Create a copy of DownloadState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? downloads = null,Object? listDownloads = null,Object? listCancels = null,Object? deletes = null,}) {
  return _then(_DownloadState(
downloads: null == downloads ? _self.downloads : downloads // ignore: cast_nullable_to_non_nullable
as IList<Download>,listDownloads: null == listDownloads ? _self.listDownloads : listDownloads // ignore: cast_nullable_to_non_nullable
as IList<String>,listCancels: null == listCancels ? _self.listCancels : listCancels // ignore: cast_nullable_to_non_nullable
as IList<String>,deletes: null == deletes ? _self.deletes : deletes // ignore: cast_nullable_to_non_nullable
as IList<String>,
  ));
}


}

/// @nodoc
mixin _$DownloadCounts {

 int get downloaded; int get downloading;
/// Create a copy of DownloadCounts
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DownloadCountsCopyWith<DownloadCounts> get copyWith => _$DownloadCountsCopyWithImpl<DownloadCounts>(this as DownloadCounts, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DownloadCounts&&(identical(other.downloaded, downloaded) || other.downloaded == downloaded)&&(identical(other.downloading, downloading) || other.downloading == downloading));
}


@override
int get hashCode => Object.hash(runtimeType,downloaded,downloading);

@override
String toString() {
  return 'DownloadCounts(downloaded: $downloaded, downloading: $downloading)';
}


}

/// @nodoc
abstract mixin class $DownloadCountsCopyWith<$Res>  {
  factory $DownloadCountsCopyWith(DownloadCounts value, $Res Function(DownloadCounts) _then) = _$DownloadCountsCopyWithImpl;
@useResult
$Res call({
 int downloaded, int downloading
});




}
/// @nodoc
class _$DownloadCountsCopyWithImpl<$Res>
    implements $DownloadCountsCopyWith<$Res> {
  _$DownloadCountsCopyWithImpl(this._self, this._then);

  final DownloadCounts _self;
  final $Res Function(DownloadCounts) _then;

/// Create a copy of DownloadCounts
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? downloaded = null,Object? downloading = null,}) {
  return _then(_self.copyWith(
downloaded: null == downloaded ? _self.downloaded : downloaded // ignore: cast_nullable_to_non_nullable
as int,downloading: null == downloading ? _self.downloading : downloading // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [DownloadCounts].
extension DownloadCountsPatterns on DownloadCounts {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DownloadCounts value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DownloadCounts() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DownloadCounts value)  $default,){
final _that = this;
switch (_that) {
case _DownloadCounts():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DownloadCounts value)?  $default,){
final _that = this;
switch (_that) {
case _DownloadCounts() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int downloaded,  int downloading)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DownloadCounts() when $default != null:
return $default(_that.downloaded,_that.downloading);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int downloaded,  int downloading)  $default,) {final _that = this;
switch (_that) {
case _DownloadCounts():
return $default(_that.downloaded,_that.downloading);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int downloaded,  int downloading)?  $default,) {final _that = this;
switch (_that) {
case _DownloadCounts() when $default != null:
return $default(_that.downloaded,_that.downloading);case _:
  return null;

}
}

}

/// @nodoc


class _DownloadCounts implements DownloadCounts {
  const _DownloadCounts({this.downloaded = 0, this.downloading = 0});
  

@override@JsonKey() final  int downloaded;
@override@JsonKey() final  int downloading;

/// Create a copy of DownloadCounts
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DownloadCountsCopyWith<_DownloadCounts> get copyWith => __$DownloadCountsCopyWithImpl<_DownloadCounts>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DownloadCounts&&(identical(other.downloaded, downloaded) || other.downloaded == downloaded)&&(identical(other.downloading, downloading) || other.downloading == downloading));
}


@override
int get hashCode => Object.hash(runtimeType,downloaded,downloading);

@override
String toString() {
  return 'DownloadCounts(downloaded: $downloaded, downloading: $downloading)';
}


}

/// @nodoc
abstract mixin class _$DownloadCountsCopyWith<$Res> implements $DownloadCountsCopyWith<$Res> {
  factory _$DownloadCountsCopyWith(_DownloadCounts value, $Res Function(_DownloadCounts) _then) = __$DownloadCountsCopyWithImpl;
@override @useResult
$Res call({
 int downloaded, int downloading
});




}
/// @nodoc
class __$DownloadCountsCopyWithImpl<$Res>
    implements _$DownloadCountsCopyWith<$Res> {
  __$DownloadCountsCopyWithImpl(this._self, this._then);

  final _DownloadCounts _self;
  final $Res Function(_DownloadCounts) _then;

/// Create a copy of DownloadCounts
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? downloaded = null,Object? downloading = null,}) {
  return _then(_DownloadCounts(
downloaded: null == downloaded ? _self.downloaded : downloaded // ignore: cast_nullable_to_non_nullable
as int,downloading: null == downloading ? _self.downloading : downloading // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$ListDownloadStatus {

 int get total; int get downloaded; int get downloading;
/// Create a copy of ListDownloadStatus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ListDownloadStatusCopyWith<ListDownloadStatus> get copyWith => _$ListDownloadStatusCopyWithImpl<ListDownloadStatus>(this as ListDownloadStatus, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ListDownloadStatus&&(identical(other.total, total) || other.total == total)&&(identical(other.downloaded, downloaded) || other.downloaded == downloaded)&&(identical(other.downloading, downloading) || other.downloading == downloading));
}


@override
int get hashCode => Object.hash(runtimeType,total,downloaded,downloading);

@override
String toString() {
  return 'ListDownloadStatus(total: $total, downloaded: $downloaded, downloading: $downloading)';
}


}

/// @nodoc
abstract mixin class $ListDownloadStatusCopyWith<$Res>  {
  factory $ListDownloadStatusCopyWith(ListDownloadStatus value, $Res Function(ListDownloadStatus) _then) = _$ListDownloadStatusCopyWithImpl;
@useResult
$Res call({
 int total, int downloaded, int downloading
});




}
/// @nodoc
class _$ListDownloadStatusCopyWithImpl<$Res>
    implements $ListDownloadStatusCopyWith<$Res> {
  _$ListDownloadStatusCopyWithImpl(this._self, this._then);

  final ListDownloadStatus _self;
  final $Res Function(ListDownloadStatus) _then;

/// Create a copy of ListDownloadStatus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? total = null,Object? downloaded = null,Object? downloading = null,}) {
  return _then(_self.copyWith(
total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,downloaded: null == downloaded ? _self.downloaded : downloaded // ignore: cast_nullable_to_non_nullable
as int,downloading: null == downloading ? _self.downloading : downloading // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ListDownloadStatus].
extension ListDownloadStatusPatterns on ListDownloadStatus {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ListDownloadStatus value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ListDownloadStatus() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ListDownloadStatus value)  $default,){
final _that = this;
switch (_that) {
case _ListDownloadStatus():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ListDownloadStatus value)?  $default,){
final _that = this;
switch (_that) {
case _ListDownloadStatus() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int total,  int downloaded,  int downloading)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ListDownloadStatus() when $default != null:
return $default(_that.total,_that.downloaded,_that.downloading);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int total,  int downloaded,  int downloading)  $default,) {final _that = this;
switch (_that) {
case _ListDownloadStatus():
return $default(_that.total,_that.downloaded,_that.downloading);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int total,  int downloaded,  int downloading)?  $default,) {final _that = this;
switch (_that) {
case _ListDownloadStatus() when $default != null:
return $default(_that.total,_that.downloaded,_that.downloading);case _:
  return null;

}
}

}

/// @nodoc


class _ListDownloadStatus implements ListDownloadStatus {
  const _ListDownloadStatus({required this.total, required this.downloaded, required this.downloading});
  

@override final  int total;
@override final  int downloaded;
@override final  int downloading;

/// Create a copy of ListDownloadStatus
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ListDownloadStatusCopyWith<_ListDownloadStatus> get copyWith => __$ListDownloadStatusCopyWithImpl<_ListDownloadStatus>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ListDownloadStatus&&(identical(other.total, total) || other.total == total)&&(identical(other.downloaded, downloaded) || other.downloaded == downloaded)&&(identical(other.downloading, downloading) || other.downloading == downloading));
}


@override
int get hashCode => Object.hash(runtimeType,total,downloaded,downloading);

@override
String toString() {
  return 'ListDownloadStatus(total: $total, downloaded: $downloaded, downloading: $downloading)';
}


}

/// @nodoc
abstract mixin class _$ListDownloadStatusCopyWith<$Res> implements $ListDownloadStatusCopyWith<$Res> {
  factory _$ListDownloadStatusCopyWith(_ListDownloadStatus value, $Res Function(_ListDownloadStatus) _then) = __$ListDownloadStatusCopyWithImpl;
@override @useResult
$Res call({
 int total, int downloaded, int downloading
});




}
/// @nodoc
class __$ListDownloadStatusCopyWithImpl<$Res>
    implements _$ListDownloadStatusCopyWith<$Res> {
  __$ListDownloadStatusCopyWithImpl(this._self, this._then);

  final _ListDownloadStatus _self;
  final $Res Function(_ListDownloadStatus) _then;

/// Create a copy of ListDownloadStatus
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? total = null,Object? downloaded = null,Object? downloading = null,}) {
  return _then(_ListDownloadStatus(
total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,downloaded: null == downloaded ? _self.downloaded : downloaded // ignore: cast_nullable_to_non_nullable
as int,downloading: null == downloading ? _self.downloading : downloading // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
