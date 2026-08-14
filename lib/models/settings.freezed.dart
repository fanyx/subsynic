// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppSettings {

 Uri? get libraryRootUri; bool get embedCover;
/// Create a copy of AppSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppSettingsCopyWith<AppSettings> get copyWith => _$AppSettingsCopyWithImpl<AppSettings>(this as AppSettings, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppSettings&&(identical(other.libraryRootUri, libraryRootUri) || other.libraryRootUri == libraryRootUri)&&(identical(other.embedCover, embedCover) || other.embedCover == embedCover));
}


@override
int get hashCode => Object.hash(runtimeType,libraryRootUri,embedCover);

@override
String toString() {
  return 'AppSettings(libraryRootUri: $libraryRootUri, embedCover: $embedCover)';
}


}

/// @nodoc
abstract mixin class $AppSettingsCopyWith<$Res>  {
  factory $AppSettingsCopyWith(AppSettings value, $Res Function(AppSettings) _then) = _$AppSettingsCopyWithImpl;
@useResult
$Res call({
 Uri? libraryRootUri, bool embedCover
});




}
/// @nodoc
class _$AppSettingsCopyWithImpl<$Res>
    implements $AppSettingsCopyWith<$Res> {
  _$AppSettingsCopyWithImpl(this._self, this._then);

  final AppSettings _self;
  final $Res Function(AppSettings) _then;

/// Create a copy of AppSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? libraryRootUri = freezed,Object? embedCover = null,}) {
  return _then(_self.copyWith(
libraryRootUri: freezed == libraryRootUri ? _self.libraryRootUri : libraryRootUri // ignore: cast_nullable_to_non_nullable
as Uri?,embedCover: null == embedCover ? _self.embedCover : embedCover // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [AppSettings].
extension AppSettingsPatterns on AppSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppSettings value)  $default,){
final _that = this;
switch (_that) {
case _AppSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppSettings value)?  $default,){
final _that = this;
switch (_that) {
case _AppSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Uri? libraryRootUri,  bool embedCover)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppSettings() when $default != null:
return $default(_that.libraryRootUri,_that.embedCover);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Uri? libraryRootUri,  bool embedCover)  $default,) {final _that = this;
switch (_that) {
case _AppSettings():
return $default(_that.libraryRootUri,_that.embedCover);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Uri? libraryRootUri,  bool embedCover)?  $default,) {final _that = this;
switch (_that) {
case _AppSettings() when $default != null:
return $default(_that.libraryRootUri,_that.embedCover);case _:
  return null;

}
}

}

/// @nodoc


class _AppSettings extends AppSettings {
  const _AppSettings({this.libraryRootUri, this.embedCover = false}): super._();
  

@override final  Uri? libraryRootUri;
@override@JsonKey() final  bool embedCover;

/// Create a copy of AppSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppSettingsCopyWith<_AppSettings> get copyWith => __$AppSettingsCopyWithImpl<_AppSettings>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppSettings&&(identical(other.libraryRootUri, libraryRootUri) || other.libraryRootUri == libraryRootUri)&&(identical(other.embedCover, embedCover) || other.embedCover == embedCover));
}


@override
int get hashCode => Object.hash(runtimeType,libraryRootUri,embedCover);

@override
String toString() {
  return 'AppSettings(libraryRootUri: $libraryRootUri, embedCover: $embedCover)';
}


}

/// @nodoc
abstract mixin class _$AppSettingsCopyWith<$Res> implements $AppSettingsCopyWith<$Res> {
  factory _$AppSettingsCopyWith(_AppSettings value, $Res Function(_AppSettings) _then) = __$AppSettingsCopyWithImpl;
@override @useResult
$Res call({
 Uri? libraryRootUri, bool embedCover
});




}
/// @nodoc
class __$AppSettingsCopyWithImpl<$Res>
    implements _$AppSettingsCopyWith<$Res> {
  __$AppSettingsCopyWithImpl(this._self, this._then);

  final _AppSettings _self;
  final $Res Function(_AppSettings) _then;

/// Create a copy of AppSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? libraryRootUri = freezed,Object? embedCover = null,}) {
  return _then(_AppSettings(
libraryRootUri: freezed == libraryRootUri ? _self.libraryRootUri : libraryRootUri // ignore: cast_nullable_to_non_nullable
as Uri?,embedCover: null == embedCover ? _self.embedCover : embedCover // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$SettingsState {

 ServerSettings? get server; AppSettings get app;
/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SettingsStateCopyWith<SettingsState> get copyWith => _$SettingsStateCopyWithImpl<SettingsState>(this as SettingsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettingsState&&(identical(other.server, server) || other.server == server)&&(identical(other.app, app) || other.app == app));
}


@override
int get hashCode => Object.hash(runtimeType,server,app);

@override
String toString() {
  return 'SettingsState(server: $server, app: $app)';
}


}

/// @nodoc
abstract mixin class $SettingsStateCopyWith<$Res>  {
  factory $SettingsStateCopyWith(SettingsState value, $Res Function(SettingsState) _then) = _$SettingsStateCopyWithImpl;
@useResult
$Res call({
 ServerSettings? server, AppSettings app
});


$ServerSettingsCopyWith<$Res>? get server;$AppSettingsCopyWith<$Res> get app;

}
/// @nodoc
class _$SettingsStateCopyWithImpl<$Res>
    implements $SettingsStateCopyWith<$Res> {
  _$SettingsStateCopyWithImpl(this._self, this._then);

  final SettingsState _self;
  final $Res Function(SettingsState) _then;

/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? server = freezed,Object? app = null,}) {
  return _then(_self.copyWith(
server: freezed == server ? _self.server : server // ignore: cast_nullable_to_non_nullable
as ServerSettings?,app: null == app ? _self.app : app // ignore: cast_nullable_to_non_nullable
as AppSettings,
  ));
}
/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ServerSettingsCopyWith<$Res>? get server {
    if (_self.server == null) {
    return null;
  }

  return $ServerSettingsCopyWith<$Res>(_self.server!, (value) {
    return _then(_self.copyWith(server: value));
  });
}/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AppSettingsCopyWith<$Res> get app {
  
  return $AppSettingsCopyWith<$Res>(_self.app, (value) {
    return _then(_self.copyWith(app: value));
  });
}
}


/// Adds pattern-matching-related methods to [SettingsState].
extension SettingsStatePatterns on SettingsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SettingsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SettingsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SettingsState value)  $default,){
final _that = this;
switch (_that) {
case _SettingsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SettingsState value)?  $default,){
final _that = this;
switch (_that) {
case _SettingsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ServerSettings? server,  AppSettings app)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SettingsState() when $default != null:
return $default(_that.server,_that.app);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ServerSettings? server,  AppSettings app)  $default,) {final _that = this;
switch (_that) {
case _SettingsState():
return $default(_that.server,_that.app);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ServerSettings? server,  AppSettings app)?  $default,) {final _that = this;
switch (_that) {
case _SettingsState() when $default != null:
return $default(_that.server,_that.app);case _:
  return null;

}
}

}

/// @nodoc


class _SettingsState implements SettingsState {
  const _SettingsState({this.server, this.app = const AppSettings()});
  

@override final  ServerSettings? server;
@override@JsonKey() final  AppSettings app;

/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SettingsStateCopyWith<_SettingsState> get copyWith => __$SettingsStateCopyWithImpl<_SettingsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SettingsState&&(identical(other.server, server) || other.server == server)&&(identical(other.app, app) || other.app == app));
}


@override
int get hashCode => Object.hash(runtimeType,server,app);

@override
String toString() {
  return 'SettingsState(server: $server, app: $app)';
}


}

/// @nodoc
abstract mixin class _$SettingsStateCopyWith<$Res> implements $SettingsStateCopyWith<$Res> {
  factory _$SettingsStateCopyWith(_SettingsState value, $Res Function(_SettingsState) _then) = __$SettingsStateCopyWithImpl;
@override @useResult
$Res call({
 ServerSettings? server, AppSettings app
});


@override $ServerSettingsCopyWith<$Res>? get server;@override $AppSettingsCopyWith<$Res> get app;

}
/// @nodoc
class __$SettingsStateCopyWithImpl<$Res>
    implements _$SettingsStateCopyWith<$Res> {
  __$SettingsStateCopyWithImpl(this._self, this._then);

  final _SettingsState _self;
  final $Res Function(_SettingsState) _then;

/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? server = freezed,Object? app = null,}) {
  return _then(_SettingsState(
server: freezed == server ? _self.server : server // ignore: cast_nullable_to_non_nullable
as ServerSettings?,app: null == app ? _self.app : app // ignore: cast_nullable_to_non_nullable
as AppSettings,
  ));
}

/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ServerSettingsCopyWith<$Res>? get server {
    if (_self.server == null) {
    return null;
  }

  return $ServerSettingsCopyWith<$Res>(_self.server!, (value) {
    return _then(_self.copyWith(server: value));
  });
}/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AppSettingsCopyWith<$Res> get app {
  
  return $AppSettingsCopyWith<$Res>(_self.app, (value) {
    return _then(_self.copyWith(app: value));
  });
}
}

/// @nodoc
mixin _$ServerSettings {

 Uri get address; String get username; String get password; bool get useTokenAuth;
/// Create a copy of ServerSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServerSettingsCopyWith<ServerSettings> get copyWith => _$ServerSettingsCopyWithImpl<ServerSettings>(this as ServerSettings, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServerSettings&&(identical(other.address, address) || other.address == address)&&(identical(other.username, username) || other.username == username)&&(identical(other.password, password) || other.password == password)&&(identical(other.useTokenAuth, useTokenAuth) || other.useTokenAuth == useTokenAuth));
}


@override
int get hashCode => Object.hash(runtimeType,address,username,password,useTokenAuth);

@override
String toString() {
  return 'ServerSettings(address: $address, username: $username, password: $password, useTokenAuth: $useTokenAuth)';
}


}

/// @nodoc
abstract mixin class $ServerSettingsCopyWith<$Res>  {
  factory $ServerSettingsCopyWith(ServerSettings value, $Res Function(ServerSettings) _then) = _$ServerSettingsCopyWithImpl;
@useResult
$Res call({
 Uri address, String username, String password, bool useTokenAuth
});




}
/// @nodoc
class _$ServerSettingsCopyWithImpl<$Res>
    implements $ServerSettingsCopyWith<$Res> {
  _$ServerSettingsCopyWithImpl(this._self, this._then);

  final ServerSettings _self;
  final $Res Function(ServerSettings) _then;

/// Create a copy of ServerSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? address = null,Object? username = null,Object? password = null,Object? useTokenAuth = null,}) {
  return _then(_self.copyWith(
address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as Uri,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,useTokenAuth: null == useTokenAuth ? _self.useTokenAuth : useTokenAuth // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ServerSettings].
extension ServerSettingsPatterns on ServerSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ServerSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ServerSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ServerSettings value)  $default,){
final _that = this;
switch (_that) {
case _ServerSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ServerSettings value)?  $default,){
final _that = this;
switch (_that) {
case _ServerSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Uri address,  String username,  String password,  bool useTokenAuth)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ServerSettings() when $default != null:
return $default(_that.address,_that.username,_that.password,_that.useTokenAuth);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Uri address,  String username,  String password,  bool useTokenAuth)  $default,) {final _that = this;
switch (_that) {
case _ServerSettings():
return $default(_that.address,_that.username,_that.password,_that.useTokenAuth);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Uri address,  String username,  String password,  bool useTokenAuth)?  $default,) {final _that = this;
switch (_that) {
case _ServerSettings() when $default != null:
return $default(_that.address,_that.username,_that.password,_that.useTokenAuth);case _:
  return null;

}
}

}

/// @nodoc


class _ServerSettings extends ServerSettings {
  const _ServerSettings({required this.address, required this.username, required this.password, this.useTokenAuth = true}): super._();
  

@override final  Uri address;
@override final  String username;
@override final  String password;
@override@JsonKey() final  bool useTokenAuth;

/// Create a copy of ServerSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ServerSettingsCopyWith<_ServerSettings> get copyWith => __$ServerSettingsCopyWithImpl<_ServerSettings>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ServerSettings&&(identical(other.address, address) || other.address == address)&&(identical(other.username, username) || other.username == username)&&(identical(other.password, password) || other.password == password)&&(identical(other.useTokenAuth, useTokenAuth) || other.useTokenAuth == useTokenAuth));
}


@override
int get hashCode => Object.hash(runtimeType,address,username,password,useTokenAuth);

@override
String toString() {
  return 'ServerSettings(address: $address, username: $username, password: $password, useTokenAuth: $useTokenAuth)';
}


}

/// @nodoc
abstract mixin class _$ServerSettingsCopyWith<$Res> implements $ServerSettingsCopyWith<$Res> {
  factory _$ServerSettingsCopyWith(_ServerSettings value, $Res Function(_ServerSettings) _then) = __$ServerSettingsCopyWithImpl;
@override @useResult
$Res call({
 Uri address, String username, String password, bool useTokenAuth
});




}
/// @nodoc
class __$ServerSettingsCopyWithImpl<$Res>
    implements _$ServerSettingsCopyWith<$Res> {
  __$ServerSettingsCopyWithImpl(this._self, this._then);

  final _ServerSettings _self;
  final $Res Function(_ServerSettings) _then;

/// Create a copy of ServerSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? address = null,Object? username = null,Object? password = null,Object? useTokenAuth = null,}) {
  return _then(_ServerSettings(
address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as Uri,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,useTokenAuth: null == useTokenAuth ? _self.useTokenAuth : useTokenAuth // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
