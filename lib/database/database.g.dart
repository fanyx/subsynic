// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class Server extends Table with TableInfo<Server, ServerData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Server(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL PRIMARY KEY',
  );
  late final GeneratedColumnWithTypeConverter<Uri, String> address =
      GeneratedColumn<String>(
        'address',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
        $customConstraints: 'NOT NULL',
      ).withConverter<Uri>(Server.$converteraddress);
  static const VerificationMeta _usernameMeta = const VerificationMeta(
    'username',
  );
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
    'username',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _passwordMeta = const VerificationMeta(
    'password',
  );
  late final GeneratedColumn<String> password = GeneratedColumn<String>(
    'password',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _useTokenAuthMeta = const VerificationMeta(
    'useTokenAuth',
  );
  late final GeneratedColumn<bool> useTokenAuth = GeneratedColumn<bool>(
    'use_token_auth',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL DEFAULT 1',
    defaultValue: const CustomExpression('1'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    address,
    username,
    password,
    useTokenAuth,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'server';
  @override
  VerificationContext validateIntegrity(
    Insertable<ServerData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('username')) {
      context.handle(
        _usernameMeta,
        username.isAcceptableOrUnknown(data['username']!, _usernameMeta),
      );
    } else if (isInserting) {
      context.missing(_usernameMeta);
    }
    if (data.containsKey('password')) {
      context.handle(
        _passwordMeta,
        password.isAcceptableOrUnknown(data['password']!, _passwordMeta),
      );
    } else if (isInserting) {
      context.missing(_passwordMeta);
    }
    if (data.containsKey('use_token_auth')) {
      context.handle(
        _useTokenAuthMeta,
        useTokenAuth.isAcceptableOrUnknown(
          data['use_token_auth']!,
          _useTokenAuthMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ServerData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ServerData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      address: Server.$converteraddress.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}address'],
        )!,
      ),
      username: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}username'],
      )!,
      password: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}password'],
      )!,
      useTokenAuth: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}use_token_auth'],
      )!,
    );
  }

  @override
  Server createAlias(String alias) {
    return Server(attachedDatabase, alias);
  }

  static TypeConverter<Uri, String> $converteraddress = const UriConverter();
  @override
  bool get dontWriteConstraints => true;
}

class ServerData extends DataClass implements Insertable<ServerData> {
  final int id;
  final Uri address;
  final String username;
  final String password;
  final bool useTokenAuth;
  const ServerData({
    required this.id,
    required this.address,
    required this.username,
    required this.password,
    required this.useTokenAuth,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['address'] = Variable<String>(
        Server.$converteraddress.toSql(address),
      );
    }
    map['username'] = Variable<String>(username);
    map['password'] = Variable<String>(password);
    map['use_token_auth'] = Variable<bool>(useTokenAuth);
    return map;
  }

  ServerCompanion toCompanion(bool nullToAbsent) {
    return ServerCompanion(
      id: Value(id),
      address: Value(address),
      username: Value(username),
      password: Value(password),
      useTokenAuth: Value(useTokenAuth),
    );
  }

  factory ServerData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ServerData(
      id: serializer.fromJson<int>(json['id']),
      address: serializer.fromJson<Uri>(json['address']),
      username: serializer.fromJson<String>(json['username']),
      password: serializer.fromJson<String>(json['password']),
      useTokenAuth: serializer.fromJson<bool>(json['use_token_auth']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'address': serializer.toJson<Uri>(address),
      'username': serializer.toJson<String>(username),
      'password': serializer.toJson<String>(password),
      'use_token_auth': serializer.toJson<bool>(useTokenAuth),
    };
  }

  ServerData copyWith({
    int? id,
    Uri? address,
    String? username,
    String? password,
    bool? useTokenAuth,
  }) => ServerData(
    id: id ?? this.id,
    address: address ?? this.address,
    username: username ?? this.username,
    password: password ?? this.password,
    useTokenAuth: useTokenAuth ?? this.useTokenAuth,
  );
  ServerData copyWithCompanion(ServerCompanion data) {
    return ServerData(
      id: data.id.present ? data.id.value : this.id,
      address: data.address.present ? data.address.value : this.address,
      username: data.username.present ? data.username.value : this.username,
      password: data.password.present ? data.password.value : this.password,
      useTokenAuth: data.useTokenAuth.present
          ? data.useTokenAuth.value
          : this.useTokenAuth,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ServerData(')
          ..write('id: $id, ')
          ..write('address: $address, ')
          ..write('username: $username, ')
          ..write('password: $password, ')
          ..write('useTokenAuth: $useTokenAuth')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, address, username, password, useTokenAuth);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ServerData &&
          other.id == this.id &&
          other.address == this.address &&
          other.username == this.username &&
          other.password == this.password &&
          other.useTokenAuth == this.useTokenAuth);
}

class ServerCompanion extends UpdateCompanion<ServerData> {
  final Value<int> id;
  final Value<Uri> address;
  final Value<String> username;
  final Value<String> password;
  final Value<bool> useTokenAuth;
  const ServerCompanion({
    this.id = const Value.absent(),
    this.address = const Value.absent(),
    this.username = const Value.absent(),
    this.password = const Value.absent(),
    this.useTokenAuth = const Value.absent(),
  });
  ServerCompanion.insert({
    this.id = const Value.absent(),
    required Uri address,
    required String username,
    required String password,
    this.useTokenAuth = const Value.absent(),
  }) : address = Value(address),
       username = Value(username),
       password = Value(password);
  static Insertable<ServerData> custom({
    Expression<int>? id,
    Expression<String>? address,
    Expression<String>? username,
    Expression<String>? password,
    Expression<bool>? useTokenAuth,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (address != null) 'address': address,
      if (username != null) 'username': username,
      if (password != null) 'password': password,
      if (useTokenAuth != null) 'use_token_auth': useTokenAuth,
    });
  }

  ServerCompanion copyWith({
    Value<int>? id,
    Value<Uri>? address,
    Value<String>? username,
    Value<String>? password,
    Value<bool>? useTokenAuth,
  }) {
    return ServerCompanion(
      id: id ?? this.id,
      address: address ?? this.address,
      username: username ?? this.username,
      password: password ?? this.password,
      useTokenAuth: useTokenAuth ?? this.useTokenAuth,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(
        Server.$converteraddress.toSql(address.value),
      );
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (password.present) {
      map['password'] = Variable<String>(password.value);
    }
    if (useTokenAuth.present) {
      map['use_token_auth'] = Variable<bool>(useTokenAuth.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ServerCompanion(')
          ..write('id: $id, ')
          ..write('address: $address, ')
          ..write('username: $username, ')
          ..write('password: $password, ')
          ..write('useTokenAuth: $useTokenAuth')
          ..write(')'))
        .toString();
  }
}

class AppSettingsTable extends Table
    with TableInfo<AppSettingsTable, AppSettings> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  AppSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL PRIMARY KEY',
  );
  late final GeneratedColumnWithTypeConverter<Uri?, String> libraryRootUri =
      GeneratedColumn<String>(
        'library_root_uri',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        $customConstraints: '',
      ).withConverter<Uri?>(AppSettingsTable.$converterlibraryRootUrin);
  static const VerificationMeta _embedCoverMeta = const VerificationMeta(
    'embedCover',
  );
  late final GeneratedColumn<bool> embedCover = GeneratedColumn<bool>(
    'embed_cover',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL DEFAULT 0',
    defaultValue: const CustomExpression('0'),
  );
  @override
  List<GeneratedColumn> get $columns => [id, libraryRootUri, embedCover];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppSettings> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('embed_cover')) {
      context.handle(
        _embedCoverMeta,
        embedCover.isAcceptableOrUnknown(data['embed_cover']!, _embedCoverMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AppSettings map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppSettings(
      libraryRootUri: AppSettingsTable.$converterlibraryRootUrin.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}library_root_uri'],
        ),
      ),
      embedCover: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}embed_cover'],
      )!,
    );
  }

  @override
  AppSettingsTable createAlias(String alias) {
    return AppSettingsTable(attachedDatabase, alias);
  }

  static TypeConverter<Uri, String> $converterlibraryRootUri =
      const UriConverter();
  static TypeConverter<Uri?, String?> $converterlibraryRootUrin =
      NullAwareTypeConverter.wrap($converterlibraryRootUri);
  @override
  bool get dontWriteConstraints => true;
}

class AppSettingsCompanion extends UpdateCompanion<AppSettings> {
  final Value<int> id;
  final Value<Uri?> libraryRootUri;
  final Value<bool> embedCover;
  const AppSettingsCompanion({
    this.id = const Value.absent(),
    this.libraryRootUri = const Value.absent(),
    this.embedCover = const Value.absent(),
  });
  AppSettingsCompanion.insert({
    this.id = const Value.absent(),
    this.libraryRootUri = const Value.absent(),
    this.embedCover = const Value.absent(),
  });
  static Insertable<AppSettings> custom({
    Expression<int>? id,
    Expression<String>? libraryRootUri,
    Expression<bool>? embedCover,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (libraryRootUri != null) 'library_root_uri': libraryRootUri,
      if (embedCover != null) 'embed_cover': embedCover,
    });
  }

  AppSettingsCompanion copyWith({
    Value<int>? id,
    Value<Uri?>? libraryRootUri,
    Value<bool>? embedCover,
  }) {
    return AppSettingsCompanion(
      id: id ?? this.id,
      libraryRootUri: libraryRootUri ?? this.libraryRootUri,
      embedCover: embedCover ?? this.embedCover,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (libraryRootUri.present) {
      map['library_root_uri'] = Variable<String>(
        AppSettingsTable.$converterlibraryRootUrin.toSql(libraryRootUri.value),
      );
    }
    if (embedCover.present) {
      map['embed_cover'] = Variable<bool>(embedCover.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsCompanion(')
          ..write('id: $id, ')
          ..write('libraryRootUri: $libraryRootUri, ')
          ..write('embedCover: $embedCover')
          ..write(')'))
        .toString();
  }
}

class LastLibraryState extends Table
    with TableInfo<LastLibraryState, LastLibraryStateData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  LastLibraryState(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL PRIMARY KEY',
  );
  static const VerificationMeta _tabMeta = const VerificationMeta('tab');
  late final GeneratedColumn<String> tab = GeneratedColumn<String>(
    'tab',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  late final GeneratedColumnWithTypeConverter<ListQuery, String> albumsList =
      GeneratedColumn<String>(
        'albums_list',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
        $customConstraints: 'NOT NULL',
      ).withConverter<ListQuery>(LastLibraryState.$converteralbumsList);
  late final GeneratedColumnWithTypeConverter<ListQuery, String> artistsList =
      GeneratedColumn<String>(
        'artists_list',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
        $customConstraints: 'NOT NULL',
      ).withConverter<ListQuery>(LastLibraryState.$converterartistsList);
  late final GeneratedColumnWithTypeConverter<ListQuery, String> playlistsList =
      GeneratedColumn<String>(
        'playlists_list',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
        $customConstraints: 'NOT NULL',
      ).withConverter<ListQuery>(LastLibraryState.$converterplaylistsList);
  late final GeneratedColumnWithTypeConverter<ListQuery, String> songsList =
      GeneratedColumn<String>(
        'songs_list',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
        $customConstraints: 'NOT NULL',
      ).withConverter<ListQuery>(LastLibraryState.$convertersongsList);
  @override
  List<GeneratedColumn> get $columns => [
    id,
    tab,
    albumsList,
    artistsList,
    playlistsList,
    songsList,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'last_library_state';
  @override
  VerificationContext validateIntegrity(
    Insertable<LastLibraryStateData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('tab')) {
      context.handle(
        _tabMeta,
        tab.isAcceptableOrUnknown(data['tab']!, _tabMeta),
      );
    } else if (isInserting) {
      context.missing(_tabMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LastLibraryStateData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LastLibraryStateData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      tab: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tab'],
      )!,
      albumsList: LastLibraryState.$converteralbumsList.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}albums_list'],
        )!,
      ),
      artistsList: LastLibraryState.$converterartistsList.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}artists_list'],
        )!,
      ),
      playlistsList: LastLibraryState.$converterplaylistsList.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}playlists_list'],
        )!,
      ),
      songsList: LastLibraryState.$convertersongsList.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}songs_list'],
        )!,
      ),
    );
  }

  @override
  LastLibraryState createAlias(String alias) {
    return LastLibraryState(attachedDatabase, alias);
  }

  static TypeConverter<ListQuery, String> $converteralbumsList =
      const ListQueryConverter();
  static TypeConverter<ListQuery, String> $converterartistsList =
      const ListQueryConverter();
  static TypeConverter<ListQuery, String> $converterplaylistsList =
      const ListQueryConverter();
  static TypeConverter<ListQuery, String> $convertersongsList =
      const ListQueryConverter();
  @override
  bool get dontWriteConstraints => true;
}

class LastLibraryStateData extends DataClass
    implements Insertable<LastLibraryStateData> {
  final int id;
  final String tab;
  final ListQuery albumsList;
  final ListQuery artistsList;
  final ListQuery playlistsList;
  final ListQuery songsList;
  const LastLibraryStateData({
    required this.id,
    required this.tab,
    required this.albumsList,
    required this.artistsList,
    required this.playlistsList,
    required this.songsList,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['tab'] = Variable<String>(tab);
    {
      map['albums_list'] = Variable<String>(
        LastLibraryState.$converteralbumsList.toSql(albumsList),
      );
    }
    {
      map['artists_list'] = Variable<String>(
        LastLibraryState.$converterartistsList.toSql(artistsList),
      );
    }
    {
      map['playlists_list'] = Variable<String>(
        LastLibraryState.$converterplaylistsList.toSql(playlistsList),
      );
    }
    {
      map['songs_list'] = Variable<String>(
        LastLibraryState.$convertersongsList.toSql(songsList),
      );
    }
    return map;
  }

  LastLibraryStateCompanion toCompanion(bool nullToAbsent) {
    return LastLibraryStateCompanion(
      id: Value(id),
      tab: Value(tab),
      albumsList: Value(albumsList),
      artistsList: Value(artistsList),
      playlistsList: Value(playlistsList),
      songsList: Value(songsList),
    );
  }

  factory LastLibraryStateData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LastLibraryStateData(
      id: serializer.fromJson<int>(json['id']),
      tab: serializer.fromJson<String>(json['tab']),
      albumsList: serializer.fromJson<ListQuery>(json['albums_list']),
      artistsList: serializer.fromJson<ListQuery>(json['artists_list']),
      playlistsList: serializer.fromJson<ListQuery>(json['playlists_list']),
      songsList: serializer.fromJson<ListQuery>(json['songs_list']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'tab': serializer.toJson<String>(tab),
      'albums_list': serializer.toJson<ListQuery>(albumsList),
      'artists_list': serializer.toJson<ListQuery>(artistsList),
      'playlists_list': serializer.toJson<ListQuery>(playlistsList),
      'songs_list': serializer.toJson<ListQuery>(songsList),
    };
  }

  LastLibraryStateData copyWith({
    int? id,
    String? tab,
    ListQuery? albumsList,
    ListQuery? artistsList,
    ListQuery? playlistsList,
    ListQuery? songsList,
  }) => LastLibraryStateData(
    id: id ?? this.id,
    tab: tab ?? this.tab,
    albumsList: albumsList ?? this.albumsList,
    artistsList: artistsList ?? this.artistsList,
    playlistsList: playlistsList ?? this.playlistsList,
    songsList: songsList ?? this.songsList,
  );
  LastLibraryStateData copyWithCompanion(LastLibraryStateCompanion data) {
    return LastLibraryStateData(
      id: data.id.present ? data.id.value : this.id,
      tab: data.tab.present ? data.tab.value : this.tab,
      albumsList: data.albumsList.present
          ? data.albumsList.value
          : this.albumsList,
      artistsList: data.artistsList.present
          ? data.artistsList.value
          : this.artistsList,
      playlistsList: data.playlistsList.present
          ? data.playlistsList.value
          : this.playlistsList,
      songsList: data.songsList.present ? data.songsList.value : this.songsList,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LastLibraryStateData(')
          ..write('id: $id, ')
          ..write('tab: $tab, ')
          ..write('albumsList: $albumsList, ')
          ..write('artistsList: $artistsList, ')
          ..write('playlistsList: $playlistsList, ')
          ..write('songsList: $songsList')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, tab, albumsList, artistsList, playlistsList, songsList);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LastLibraryStateData &&
          other.id == this.id &&
          other.tab == this.tab &&
          other.albumsList == this.albumsList &&
          other.artistsList == this.artistsList &&
          other.playlistsList == this.playlistsList &&
          other.songsList == this.songsList);
}

class LastLibraryStateCompanion extends UpdateCompanion<LastLibraryStateData> {
  final Value<int> id;
  final Value<String> tab;
  final Value<ListQuery> albumsList;
  final Value<ListQuery> artistsList;
  final Value<ListQuery> playlistsList;
  final Value<ListQuery> songsList;
  const LastLibraryStateCompanion({
    this.id = const Value.absent(),
    this.tab = const Value.absent(),
    this.albumsList = const Value.absent(),
    this.artistsList = const Value.absent(),
    this.playlistsList = const Value.absent(),
    this.songsList = const Value.absent(),
  });
  LastLibraryStateCompanion.insert({
    this.id = const Value.absent(),
    required String tab,
    required ListQuery albumsList,
    required ListQuery artistsList,
    required ListQuery playlistsList,
    required ListQuery songsList,
  }) : tab = Value(tab),
       albumsList = Value(albumsList),
       artistsList = Value(artistsList),
       playlistsList = Value(playlistsList),
       songsList = Value(songsList);
  static Insertable<LastLibraryStateData> custom({
    Expression<int>? id,
    Expression<String>? tab,
    Expression<String>? albumsList,
    Expression<String>? artistsList,
    Expression<String>? playlistsList,
    Expression<String>? songsList,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tab != null) 'tab': tab,
      if (albumsList != null) 'albums_list': albumsList,
      if (artistsList != null) 'artists_list': artistsList,
      if (playlistsList != null) 'playlists_list': playlistsList,
      if (songsList != null) 'songs_list': songsList,
    });
  }

  LastLibraryStateCompanion copyWith({
    Value<int>? id,
    Value<String>? tab,
    Value<ListQuery>? albumsList,
    Value<ListQuery>? artistsList,
    Value<ListQuery>? playlistsList,
    Value<ListQuery>? songsList,
  }) {
    return LastLibraryStateCompanion(
      id: id ?? this.id,
      tab: tab ?? this.tab,
      albumsList: albumsList ?? this.albumsList,
      artistsList: artistsList ?? this.artistsList,
      playlistsList: playlistsList ?? this.playlistsList,
      songsList: songsList ?? this.songsList,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (tab.present) {
      map['tab'] = Variable<String>(tab.value);
    }
    if (albumsList.present) {
      map['albums_list'] = Variable<String>(
        LastLibraryState.$converteralbumsList.toSql(albumsList.value),
      );
    }
    if (artistsList.present) {
      map['artists_list'] = Variable<String>(
        LastLibraryState.$converterartistsList.toSql(artistsList.value),
      );
    }
    if (playlistsList.present) {
      map['playlists_list'] = Variable<String>(
        LastLibraryState.$converterplaylistsList.toSql(playlistsList.value),
      );
    }
    if (songsList.present) {
      map['songs_list'] = Variable<String>(
        LastLibraryState.$convertersongsList.toSql(songsList.value),
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LastLibraryStateCompanion(')
          ..write('id: $id, ')
          ..write('tab: $tab, ')
          ..write('albumsList: $albumsList, ')
          ..write('artistsList: $artistsList, ')
          ..write('playlistsList: $playlistsList, ')
          ..write('songsList: $songsList')
          ..write(')'))
        .toString();
  }
}

class Downloads extends Table with TableInfo<Downloads, Download> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Downloads(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _songIdMeta = const VerificationMeta('songId');
  late final GeneratedColumn<String> songId = GeneratedColumn<String>(
    'song_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL PRIMARY KEY',
  );
  static const VerificationMeta _albumIdMeta = const VerificationMeta(
    'albumId',
  );
  late final GeneratedColumn<String> albumId = GeneratedColumn<String>(
    'album_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const VerificationMeta _localPathMeta = const VerificationMeta(
    'localPath',
  );
  late final GeneratedColumn<String> localPath = GeneratedColumn<String>(
    'local_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  late final GeneratedColumnWithTypeConverter<DownloadStatus, String>
  downloadStatus = GeneratedColumn<String>(
    'download_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL DEFAULT \'none\'',
    defaultValue: const CustomExpression('\'none\''),
  ).withConverter<DownloadStatus>(Downloads.$converterdownloadStatus);
  static const VerificationMeta _downloadProgressMeta = const VerificationMeta(
    'downloadProgress',
  );
  late final GeneratedColumn<int> downloadProgress = GeneratedColumn<int>(
    'download_progress',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL DEFAULT 0',
    defaultValue: const CustomExpression('0'),
  );
  static const VerificationMeta _coverEmbeddedMeta = const VerificationMeta(
    'coverEmbedded',
  );
  late final GeneratedColumn<bool> coverEmbedded = GeneratedColumn<bool>(
    'cover_embedded',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL DEFAULT 0',
    defaultValue: const CustomExpression('0'),
  );
  static const VerificationMeta _updatedMeta = const VerificationMeta(
    'updated',
  );
  late final GeneratedColumn<DateTime> updated = GeneratedColumn<DateTime>(
    'updated',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    $customConstraints:
        'NOT NULL DEFAULT (strftime(\'%s\', CURRENT_TIMESTAMP))',
    defaultValue: const CustomExpression('strftime(\'%s\', CURRENT_TIMESTAMP)'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    songId,
    albumId,
    localPath,
    downloadStatus,
    downloadProgress,
    coverEmbedded,
    updated,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'downloads';
  @override
  VerificationContext validateIntegrity(
    Insertable<Download> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('song_id')) {
      context.handle(
        _songIdMeta,
        songId.isAcceptableOrUnknown(data['song_id']!, _songIdMeta),
      );
    } else if (isInserting) {
      context.missing(_songIdMeta);
    }
    if (data.containsKey('album_id')) {
      context.handle(
        _albumIdMeta,
        albumId.isAcceptableOrUnknown(data['album_id']!, _albumIdMeta),
      );
    }
    if (data.containsKey('local_path')) {
      context.handle(
        _localPathMeta,
        localPath.isAcceptableOrUnknown(data['local_path']!, _localPathMeta),
      );
    }
    if (data.containsKey('download_progress')) {
      context.handle(
        _downloadProgressMeta,
        downloadProgress.isAcceptableOrUnknown(
          data['download_progress']!,
          _downloadProgressMeta,
        ),
      );
    }
    if (data.containsKey('cover_embedded')) {
      context.handle(
        _coverEmbeddedMeta,
        coverEmbedded.isAcceptableOrUnknown(
          data['cover_embedded']!,
          _coverEmbeddedMeta,
        ),
      );
    }
    if (data.containsKey('updated')) {
      context.handle(
        _updatedMeta,
        updated.isAcceptableOrUnknown(data['updated']!, _updatedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {songId};
  @override
  Download map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Download(
      songId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}song_id'],
      )!,
      albumId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}album_id'],
      ),
      localPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}local_path'],
      ),
      downloadStatus: Downloads.$converterdownloadStatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}download_status'],
        )!,
      ),
      downloadProgress: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}download_progress'],
      )!,
      coverEmbedded: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}cover_embedded'],
      )!,
      updated: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated'],
      )!,
    );
  }

  @override
  Downloads createAlias(String alias) {
    return Downloads(attachedDatabase, alias);
  }

  static TypeConverter<DownloadStatus, String> $converterdownloadStatus =
      const DownloadStatusConverter();
  @override
  bool get dontWriteConstraints => true;
}

class Download extends DataClass implements Insertable<Download> {
  final String songId;
  final String? albumId;
  final String? localPath;
  final DownloadStatus downloadStatus;
  final int downloadProgress;
  final bool coverEmbedded;
  final DateTime updated;
  const Download({
    required this.songId,
    this.albumId,
    this.localPath,
    required this.downloadStatus,
    required this.downloadProgress,
    required this.coverEmbedded,
    required this.updated,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['song_id'] = Variable<String>(songId);
    if (!nullToAbsent || albumId != null) {
      map['album_id'] = Variable<String>(albumId);
    }
    if (!nullToAbsent || localPath != null) {
      map['local_path'] = Variable<String>(localPath);
    }
    {
      map['download_status'] = Variable<String>(
        Downloads.$converterdownloadStatus.toSql(downloadStatus),
      );
    }
    map['download_progress'] = Variable<int>(downloadProgress);
    map['cover_embedded'] = Variable<bool>(coverEmbedded);
    map['updated'] = Variable<DateTime>(updated);
    return map;
  }

  DownloadsCompanion toCompanion(bool nullToAbsent) {
    return DownloadsCompanion(
      songId: Value(songId),
      albumId: albumId == null && nullToAbsent
          ? const Value.absent()
          : Value(albumId),
      localPath: localPath == null && nullToAbsent
          ? const Value.absent()
          : Value(localPath),
      downloadStatus: Value(downloadStatus),
      downloadProgress: Value(downloadProgress),
      coverEmbedded: Value(coverEmbedded),
      updated: Value(updated),
    );
  }

  factory Download.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Download(
      songId: serializer.fromJson<String>(json['song_id']),
      albumId: serializer.fromJson<String?>(json['album_id']),
      localPath: serializer.fromJson<String?>(json['local_path']),
      downloadStatus: serializer.fromJson<DownloadStatus>(
        json['download_status'],
      ),
      downloadProgress: serializer.fromJson<int>(json['download_progress']),
      coverEmbedded: serializer.fromJson<bool>(json['cover_embedded']),
      updated: serializer.fromJson<DateTime>(json['updated']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'song_id': serializer.toJson<String>(songId),
      'album_id': serializer.toJson<String?>(albumId),
      'local_path': serializer.toJson<String?>(localPath),
      'download_status': serializer.toJson<DownloadStatus>(downloadStatus),
      'download_progress': serializer.toJson<int>(downloadProgress),
      'cover_embedded': serializer.toJson<bool>(coverEmbedded),
      'updated': serializer.toJson<DateTime>(updated),
    };
  }

  Download copyWith({
    String? songId,
    Value<String?> albumId = const Value.absent(),
    Value<String?> localPath = const Value.absent(),
    DownloadStatus? downloadStatus,
    int? downloadProgress,
    bool? coverEmbedded,
    DateTime? updated,
  }) => Download(
    songId: songId ?? this.songId,
    albumId: albumId.present ? albumId.value : this.albumId,
    localPath: localPath.present ? localPath.value : this.localPath,
    downloadStatus: downloadStatus ?? this.downloadStatus,
    downloadProgress: downloadProgress ?? this.downloadProgress,
    coverEmbedded: coverEmbedded ?? this.coverEmbedded,
    updated: updated ?? this.updated,
  );
  Download copyWithCompanion(DownloadsCompanion data) {
    return Download(
      songId: data.songId.present ? data.songId.value : this.songId,
      albumId: data.albumId.present ? data.albumId.value : this.albumId,
      localPath: data.localPath.present ? data.localPath.value : this.localPath,
      downloadStatus: data.downloadStatus.present
          ? data.downloadStatus.value
          : this.downloadStatus,
      downloadProgress: data.downloadProgress.present
          ? data.downloadProgress.value
          : this.downloadProgress,
      coverEmbedded: data.coverEmbedded.present
          ? data.coverEmbedded.value
          : this.coverEmbedded,
      updated: data.updated.present ? data.updated.value : this.updated,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Download(')
          ..write('songId: $songId, ')
          ..write('albumId: $albumId, ')
          ..write('localPath: $localPath, ')
          ..write('downloadStatus: $downloadStatus, ')
          ..write('downloadProgress: $downloadProgress, ')
          ..write('coverEmbedded: $coverEmbedded, ')
          ..write('updated: $updated')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    songId,
    albumId,
    localPath,
    downloadStatus,
    downloadProgress,
    coverEmbedded,
    updated,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Download &&
          other.songId == this.songId &&
          other.albumId == this.albumId &&
          other.localPath == this.localPath &&
          other.downloadStatus == this.downloadStatus &&
          other.downloadProgress == this.downloadProgress &&
          other.coverEmbedded == this.coverEmbedded &&
          other.updated == this.updated);
}

class DownloadsCompanion extends UpdateCompanion<Download> {
  final Value<String> songId;
  final Value<String?> albumId;
  final Value<String?> localPath;
  final Value<DownloadStatus> downloadStatus;
  final Value<int> downloadProgress;
  final Value<bool> coverEmbedded;
  final Value<DateTime> updated;
  final Value<int> rowid;
  const DownloadsCompanion({
    this.songId = const Value.absent(),
    this.albumId = const Value.absent(),
    this.localPath = const Value.absent(),
    this.downloadStatus = const Value.absent(),
    this.downloadProgress = const Value.absent(),
    this.coverEmbedded = const Value.absent(),
    this.updated = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DownloadsCompanion.insert({
    required String songId,
    this.albumId = const Value.absent(),
    this.localPath = const Value.absent(),
    this.downloadStatus = const Value.absent(),
    this.downloadProgress = const Value.absent(),
    this.coverEmbedded = const Value.absent(),
    this.updated = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : songId = Value(songId);
  static Insertable<Download> custom({
    Expression<String>? songId,
    Expression<String>? albumId,
    Expression<String>? localPath,
    Expression<String>? downloadStatus,
    Expression<int>? downloadProgress,
    Expression<bool>? coverEmbedded,
    Expression<DateTime>? updated,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (songId != null) 'song_id': songId,
      if (albumId != null) 'album_id': albumId,
      if (localPath != null) 'local_path': localPath,
      if (downloadStatus != null) 'download_status': downloadStatus,
      if (downloadProgress != null) 'download_progress': downloadProgress,
      if (coverEmbedded != null) 'cover_embedded': coverEmbedded,
      if (updated != null) 'updated': updated,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DownloadsCompanion copyWith({
    Value<String>? songId,
    Value<String?>? albumId,
    Value<String?>? localPath,
    Value<DownloadStatus>? downloadStatus,
    Value<int>? downloadProgress,
    Value<bool>? coverEmbedded,
    Value<DateTime>? updated,
    Value<int>? rowid,
  }) {
    return DownloadsCompanion(
      songId: songId ?? this.songId,
      albumId: albumId ?? this.albumId,
      localPath: localPath ?? this.localPath,
      downloadStatus: downloadStatus ?? this.downloadStatus,
      downloadProgress: downloadProgress ?? this.downloadProgress,
      coverEmbedded: coverEmbedded ?? this.coverEmbedded,
      updated: updated ?? this.updated,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (songId.present) {
      map['song_id'] = Variable<String>(songId.value);
    }
    if (albumId.present) {
      map['album_id'] = Variable<String>(albumId.value);
    }
    if (localPath.present) {
      map['local_path'] = Variable<String>(localPath.value);
    }
    if (downloadStatus.present) {
      map['download_status'] = Variable<String>(
        Downloads.$converterdownloadStatus.toSql(downloadStatus.value),
      );
    }
    if (downloadProgress.present) {
      map['download_progress'] = Variable<int>(downloadProgress.value);
    }
    if (coverEmbedded.present) {
      map['cover_embedded'] = Variable<bool>(coverEmbedded.value);
    }
    if (updated.present) {
      map['updated'] = Variable<DateTime>(updated.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DownloadsCompanion(')
          ..write('songId: $songId, ')
          ..write('albumId: $albumId, ')
          ..write('localPath: $localPath, ')
          ..write('downloadStatus: $downloadStatus, ')
          ..write('downloadProgress: $downloadProgress, ')
          ..write('coverEmbedded: $coverEmbedded, ')
          ..write('updated: $updated, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class AlbumCovers extends Table with TableInfo<AlbumCovers, AlbumCover> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  AlbumCovers(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _albumIdMeta = const VerificationMeta(
    'albumId',
  );
  late final GeneratedColumn<String> albumId = GeneratedColumn<String>(
    'album_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL PRIMARY KEY',
  );
  static const VerificationMeta _coverPathMeta = const VerificationMeta(
    'coverPath',
  );
  late final GeneratedColumn<String> coverPath = GeneratedColumn<String>(
    'cover_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _updatedMeta = const VerificationMeta(
    'updated',
  );
  late final GeneratedColumn<DateTime> updated = GeneratedColumn<DateTime>(
    'updated',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    $customConstraints:
        'NOT NULL DEFAULT (strftime(\'%s\', CURRENT_TIMESTAMP))',
    defaultValue: const CustomExpression('strftime(\'%s\', CURRENT_TIMESTAMP)'),
  );
  @override
  List<GeneratedColumn> get $columns => [albumId, coverPath, updated];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'album_covers';
  @override
  VerificationContext validateIntegrity(
    Insertable<AlbumCover> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('album_id')) {
      context.handle(
        _albumIdMeta,
        albumId.isAcceptableOrUnknown(data['album_id']!, _albumIdMeta),
      );
    } else if (isInserting) {
      context.missing(_albumIdMeta);
    }
    if (data.containsKey('cover_path')) {
      context.handle(
        _coverPathMeta,
        coverPath.isAcceptableOrUnknown(data['cover_path']!, _coverPathMeta),
      );
    } else if (isInserting) {
      context.missing(_coverPathMeta);
    }
    if (data.containsKey('updated')) {
      context.handle(
        _updatedMeta,
        updated.isAcceptableOrUnknown(data['updated']!, _updatedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {albumId};
  @override
  AlbumCover map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AlbumCover(
      albumId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}album_id'],
      )!,
      coverPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cover_path'],
      )!,
      updated: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated'],
      )!,
    );
  }

  @override
  AlbumCovers createAlias(String alias) {
    return AlbumCovers(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class AlbumCover extends DataClass implements Insertable<AlbumCover> {
  final String albumId;
  final String coverPath;
  final DateTime updated;
  const AlbumCover({
    required this.albumId,
    required this.coverPath,
    required this.updated,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['album_id'] = Variable<String>(albumId);
    map['cover_path'] = Variable<String>(coverPath);
    map['updated'] = Variable<DateTime>(updated);
    return map;
  }

  AlbumCoversCompanion toCompanion(bool nullToAbsent) {
    return AlbumCoversCompanion(
      albumId: Value(albumId),
      coverPath: Value(coverPath),
      updated: Value(updated),
    );
  }

  factory AlbumCover.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AlbumCover(
      albumId: serializer.fromJson<String>(json['album_id']),
      coverPath: serializer.fromJson<String>(json['cover_path']),
      updated: serializer.fromJson<DateTime>(json['updated']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'album_id': serializer.toJson<String>(albumId),
      'cover_path': serializer.toJson<String>(coverPath),
      'updated': serializer.toJson<DateTime>(updated),
    };
  }

  AlbumCover copyWith({
    String? albumId,
    String? coverPath,
    DateTime? updated,
  }) => AlbumCover(
    albumId: albumId ?? this.albumId,
    coverPath: coverPath ?? this.coverPath,
    updated: updated ?? this.updated,
  );
  AlbumCover copyWithCompanion(AlbumCoversCompanion data) {
    return AlbumCover(
      albumId: data.albumId.present ? data.albumId.value : this.albumId,
      coverPath: data.coverPath.present ? data.coverPath.value : this.coverPath,
      updated: data.updated.present ? data.updated.value : this.updated,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AlbumCover(')
          ..write('albumId: $albumId, ')
          ..write('coverPath: $coverPath, ')
          ..write('updated: $updated')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(albumId, coverPath, updated);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AlbumCover &&
          other.albumId == this.albumId &&
          other.coverPath == this.coverPath &&
          other.updated == this.updated);
}

class AlbumCoversCompanion extends UpdateCompanion<AlbumCover> {
  final Value<String> albumId;
  final Value<String> coverPath;
  final Value<DateTime> updated;
  final Value<int> rowid;
  const AlbumCoversCompanion({
    this.albumId = const Value.absent(),
    this.coverPath = const Value.absent(),
    this.updated = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AlbumCoversCompanion.insert({
    required String albumId,
    required String coverPath,
    this.updated = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : albumId = Value(albumId),
       coverPath = Value(coverPath);
  static Insertable<AlbumCover> custom({
    Expression<String>? albumId,
    Expression<String>? coverPath,
    Expression<DateTime>? updated,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (albumId != null) 'album_id': albumId,
      if (coverPath != null) 'cover_path': coverPath,
      if (updated != null) 'updated': updated,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AlbumCoversCompanion copyWith({
    Value<String>? albumId,
    Value<String>? coverPath,
    Value<DateTime>? updated,
    Value<int>? rowid,
  }) {
    return AlbumCoversCompanion(
      albumId: albumId ?? this.albumId,
      coverPath: coverPath ?? this.coverPath,
      updated: updated ?? this.updated,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (albumId.present) {
      map['album_id'] = Variable<String>(albumId.value);
    }
    if (coverPath.present) {
      map['cover_path'] = Variable<String>(coverPath.value);
    }
    if (updated.present) {
      map['updated'] = Variable<DateTime>(updated.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AlbumCoversCompanion(')
          ..write('albumId: $albumId, ')
          ..write('coverPath: $coverPath, ')
          ..write('updated: $updated, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$SyncDatabase extends GeneratedDatabase {
  _$SyncDatabase(QueryExecutor e) : super(e);
  $SyncDatabaseManager get managers => $SyncDatabaseManager(this);
  late final Server server = Server(this);
  late final AppSettingsTable appSettings = AppSettingsTable(this);
  late final LastLibraryState lastLibraryState = LastLibraryState(this);
  late final Downloads downloads = Downloads(this);
  late final Index downloadsAlbumIdIdx = Index(
    'downloads_album_id_idx',
    'CREATE INDEX downloads_album_id_idx ON downloads (album_id)',
  );
  late final AlbumCovers albumCovers = AlbumCovers(this);
  Selectable<ServerSettings> getServer() {
    return customSelect(
      'SELECT * FROM server WHERE id = 1',
      variables: [],
      readsFrom: {server},
    ).map(
      (QueryRow row) => ServerSettings(
        address: Server.$converteraddress.fromSql(row.read<String>('address')),
        username: row.read<String>('username'),
        password: row.read<String>('password'),
        useTokenAuth: row.read<bool>('use_token_auth'),
      ),
    );
  }

  Selectable<AppSettings> getAppSettings() {
    return customSelect(
      'SELECT * FROM app_settings WHERE id = 1',
      variables: [],
      readsFrom: {appSettings},
    ).asyncMap(appSettings.mapFromRow);
  }

  Selectable<Download> songDownloadById(String songId) {
    return customSelect(
      'SELECT * FROM downloads WHERE song_id = ?1',
      variables: [Variable<String>(songId)],
      readsFrom: {downloads},
    ).asyncMap(downloads.mapFromRow);
  }

  Selectable<Download> songDownloadsByIds(List<String> songIds) {
    var $arrayStartIndex = 1;
    final expandedsongIds = $expandVar($arrayStartIndex, songIds.length);
    $arrayStartIndex += songIds.length;
    return customSelect(
      'SELECT * FROM downloads WHERE song_id IN ($expandedsongIds)',
      variables: [for (var $ in songIds) Variable<String>($)],
      readsFrom: {downloads},
    ).asyncMap(downloads.mapFromRow);
  }

  Selectable<Download> downloadsByAlbum(String? albumId) {
    return customSelect(
      'SELECT * FROM downloads WHERE album_id = ?1',
      variables: [Variable<String>(albumId)],
      readsFrom: {downloads},
    ).asyncMap(downloads.mapFromRow);
  }

  Selectable<Download> allDownloads() {
    return customSelect(
      'SELECT * FROM downloads',
      variables: [],
      readsFrom: {downloads},
    ).asyncMap(downloads.mapFromRow);
  }

  Selectable<int> countDownloads() {
    return customSelect(
      'SELECT COUNT(*) AS n FROM downloads',
      variables: [],
      readsFrom: {downloads},
    ).map((QueryRow row) => row.read<int>('n'));
  }

  Selectable<DownloadCountsByAlbumResult> downloadCountsByAlbum() {
    return customSelect(
      'SELECT album_id, COUNT(CASE WHEN download_status = \'completed\' THEN 1 END) AS downloaded, COUNT(CASE WHEN download_status IN (\'queued\', \'downloading\') THEN 1 END) AS downloading FROM downloads WHERE album_id IS NOT NULL GROUP BY album_id',
      variables: [],
      readsFrom: {downloads},
    ).map(
      (QueryRow row) => DownloadCountsByAlbumResult(
        albumId: row.readNullable<String>('album_id'),
        downloaded: row.read<int>('downloaded'),
        downloading: row.read<int>('downloading'),
      ),
    );
  }

  Selectable<AlbumCover> albumCoverByAlbum(String albumId) {
    return customSelect(
      'SELECT * FROM album_covers WHERE album_id = ?1',
      variables: [Variable<String>(albumId)],
      readsFrom: {albumCovers},
    ).asyncMap(albumCovers.mapFromRow);
  }

  Selectable<AlbumCover> allAlbumCovers() {
    return customSelect(
      'SELECT * FROM album_covers',
      variables: [],
      readsFrom: {albumCovers},
    ).asyncMap(albumCovers.mapFromRow);
  }

  Selectable<int> countAlbumCovers() {
    return customSelect(
      'SELECT COUNT(*) AS n FROM album_covers',
      variables: [],
      readsFrom: {albumCovers},
    ).map((QueryRow row) => row.read<int>('n'));
  }

  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    server,
    appSettings,
    lastLibraryState,
    downloads,
    downloadsAlbumIdIdx,
    albumCovers,
  ];
}

typedef $ServerCreateCompanionBuilder =
    ServerCompanion Function({
      Value<int> id,
      required Uri address,
      required String username,
      required String password,
      Value<bool> useTokenAuth,
    });
typedef $ServerUpdateCompanionBuilder =
    ServerCompanion Function({
      Value<int> id,
      Value<Uri> address,
      Value<String> username,
      Value<String> password,
      Value<bool> useTokenAuth,
    });

class $ServerFilterComposer extends Composer<_$SyncDatabase, Server> {
  $ServerFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<Uri, Uri, String> get address =>
      $composableBuilder(
        column: $table.address,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get password => $composableBuilder(
    column: $table.password,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get useTokenAuth => $composableBuilder(
    column: $table.useTokenAuth,
    builder: (column) => ColumnFilters(column),
  );
}

class $ServerOrderingComposer extends Composer<_$SyncDatabase, Server> {
  $ServerOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get password => $composableBuilder(
    column: $table.password,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get useTokenAuth => $composableBuilder(
    column: $table.useTokenAuth,
    builder: (column) => ColumnOrderings(column),
  );
}

class $ServerAnnotationComposer extends Composer<_$SyncDatabase, Server> {
  $ServerAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Uri, String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get username =>
      $composableBuilder(column: $table.username, builder: (column) => column);

  GeneratedColumn<String> get password =>
      $composableBuilder(column: $table.password, builder: (column) => column);

  GeneratedColumn<bool> get useTokenAuth => $composableBuilder(
    column: $table.useTokenAuth,
    builder: (column) => column,
  );
}

class $ServerTableManager
    extends
        RootTableManager<
          _$SyncDatabase,
          Server,
          ServerData,
          $ServerFilterComposer,
          $ServerOrderingComposer,
          $ServerAnnotationComposer,
          $ServerCreateCompanionBuilder,
          $ServerUpdateCompanionBuilder,
          (ServerData, BaseReferences<_$SyncDatabase, Server, ServerData>),
          ServerData,
          PrefetchHooks Function()
        > {
  $ServerTableManager(_$SyncDatabase db, Server table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $ServerFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $ServerOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $ServerAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<Uri> address = const Value.absent(),
                Value<String> username = const Value.absent(),
                Value<String> password = const Value.absent(),
                Value<bool> useTokenAuth = const Value.absent(),
              }) => ServerCompanion(
                id: id,
                address: address,
                username: username,
                password: password,
                useTokenAuth: useTokenAuth,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required Uri address,
                required String username,
                required String password,
                Value<bool> useTokenAuth = const Value.absent(),
              }) => ServerCompanion.insert(
                id: id,
                address: address,
                username: username,
                password: password,
                useTokenAuth: useTokenAuth,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $ServerProcessedTableManager =
    ProcessedTableManager<
      _$SyncDatabase,
      Server,
      ServerData,
      $ServerFilterComposer,
      $ServerOrderingComposer,
      $ServerAnnotationComposer,
      $ServerCreateCompanionBuilder,
      $ServerUpdateCompanionBuilder,
      (ServerData, BaseReferences<_$SyncDatabase, Server, ServerData>),
      ServerData,
      PrefetchHooks Function()
    >;
typedef $AppSettingsTableCreateCompanionBuilder =
    AppSettingsCompanion Function({
      Value<int> id,
      Value<Uri?> libraryRootUri,
      Value<bool> embedCover,
    });
typedef $AppSettingsTableUpdateCompanionBuilder =
    AppSettingsCompanion Function({
      Value<int> id,
      Value<Uri?> libraryRootUri,
      Value<bool> embedCover,
    });

class $AppSettingsTableFilterComposer
    extends Composer<_$SyncDatabase, AppSettingsTable> {
  $AppSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<Uri?, Uri, String> get libraryRootUri =>
      $composableBuilder(
        column: $table.libraryRootUri,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<bool> get embedCover => $composableBuilder(
    column: $table.embedCover,
    builder: (column) => ColumnFilters(column),
  );
}

class $AppSettingsTableOrderingComposer
    extends Composer<_$SyncDatabase, AppSettingsTable> {
  $AppSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get libraryRootUri => $composableBuilder(
    column: $table.libraryRootUri,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get embedCover => $composableBuilder(
    column: $table.embedCover,
    builder: (column) => ColumnOrderings(column),
  );
}

class $AppSettingsTableAnnotationComposer
    extends Composer<_$SyncDatabase, AppSettingsTable> {
  $AppSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Uri?, String> get libraryRootUri =>
      $composableBuilder(
        column: $table.libraryRootUri,
        builder: (column) => column,
      );

  GeneratedColumn<bool> get embedCover => $composableBuilder(
    column: $table.embedCover,
    builder: (column) => column,
  );
}

class $AppSettingsTableTableManager
    extends
        RootTableManager<
          _$SyncDatabase,
          AppSettingsTable,
          AppSettings,
          $AppSettingsTableFilterComposer,
          $AppSettingsTableOrderingComposer,
          $AppSettingsTableAnnotationComposer,
          $AppSettingsTableCreateCompanionBuilder,
          $AppSettingsTableUpdateCompanionBuilder,
          (
            AppSettings,
            BaseReferences<_$SyncDatabase, AppSettingsTable, AppSettings>,
          ),
          AppSettings,
          PrefetchHooks Function()
        > {
  $AppSettingsTableTableManager(_$SyncDatabase db, AppSettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $AppSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $AppSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $AppSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<Uri?> libraryRootUri = const Value.absent(),
                Value<bool> embedCover = const Value.absent(),
              }) => AppSettingsCompanion(
                id: id,
                libraryRootUri: libraryRootUri,
                embedCover: embedCover,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<Uri?> libraryRootUri = const Value.absent(),
                Value<bool> embedCover = const Value.absent(),
              }) => AppSettingsCompanion.insert(
                id: id,
                libraryRootUri: libraryRootUri,
                embedCover: embedCover,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $AppSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$SyncDatabase,
      AppSettingsTable,
      AppSettings,
      $AppSettingsTableFilterComposer,
      $AppSettingsTableOrderingComposer,
      $AppSettingsTableAnnotationComposer,
      $AppSettingsTableCreateCompanionBuilder,
      $AppSettingsTableUpdateCompanionBuilder,
      (
        AppSettings,
        BaseReferences<_$SyncDatabase, AppSettingsTable, AppSettings>,
      ),
      AppSettings,
      PrefetchHooks Function()
    >;
typedef $LastLibraryStateCreateCompanionBuilder =
    LastLibraryStateCompanion Function({
      Value<int> id,
      required String tab,
      required ListQuery albumsList,
      required ListQuery artistsList,
      required ListQuery playlistsList,
      required ListQuery songsList,
    });
typedef $LastLibraryStateUpdateCompanionBuilder =
    LastLibraryStateCompanion Function({
      Value<int> id,
      Value<String> tab,
      Value<ListQuery> albumsList,
      Value<ListQuery> artistsList,
      Value<ListQuery> playlistsList,
      Value<ListQuery> songsList,
    });

class $LastLibraryStateFilterComposer
    extends Composer<_$SyncDatabase, LastLibraryState> {
  $LastLibraryStateFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tab => $composableBuilder(
    column: $table.tab,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<ListQuery, ListQuery, String> get albumsList =>
      $composableBuilder(
        column: $table.albumsList,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<ListQuery, ListQuery, String>
  get artistsList => $composableBuilder(
    column: $table.artistsList,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<ListQuery, ListQuery, String>
  get playlistsList => $composableBuilder(
    column: $table.playlistsList,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<ListQuery, ListQuery, String> get songsList =>
      $composableBuilder(
        column: $table.songsList,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );
}

class $LastLibraryStateOrderingComposer
    extends Composer<_$SyncDatabase, LastLibraryState> {
  $LastLibraryStateOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tab => $composableBuilder(
    column: $table.tab,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get albumsList => $composableBuilder(
    column: $table.albumsList,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get artistsList => $composableBuilder(
    column: $table.artistsList,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get playlistsList => $composableBuilder(
    column: $table.playlistsList,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get songsList => $composableBuilder(
    column: $table.songsList,
    builder: (column) => ColumnOrderings(column),
  );
}

class $LastLibraryStateAnnotationComposer
    extends Composer<_$SyncDatabase, LastLibraryState> {
  $LastLibraryStateAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get tab =>
      $composableBuilder(column: $table.tab, builder: (column) => column);

  GeneratedColumnWithTypeConverter<ListQuery, String> get albumsList =>
      $composableBuilder(
        column: $table.albumsList,
        builder: (column) => column,
      );

  GeneratedColumnWithTypeConverter<ListQuery, String> get artistsList =>
      $composableBuilder(
        column: $table.artistsList,
        builder: (column) => column,
      );

  GeneratedColumnWithTypeConverter<ListQuery, String> get playlistsList =>
      $composableBuilder(
        column: $table.playlistsList,
        builder: (column) => column,
      );

  GeneratedColumnWithTypeConverter<ListQuery, String> get songsList =>
      $composableBuilder(column: $table.songsList, builder: (column) => column);
}

class $LastLibraryStateTableManager
    extends
        RootTableManager<
          _$SyncDatabase,
          LastLibraryState,
          LastLibraryStateData,
          $LastLibraryStateFilterComposer,
          $LastLibraryStateOrderingComposer,
          $LastLibraryStateAnnotationComposer,
          $LastLibraryStateCreateCompanionBuilder,
          $LastLibraryStateUpdateCompanionBuilder,
          (
            LastLibraryStateData,
            BaseReferences<
              _$SyncDatabase,
              LastLibraryState,
              LastLibraryStateData
            >,
          ),
          LastLibraryStateData,
          PrefetchHooks Function()
        > {
  $LastLibraryStateTableManager(_$SyncDatabase db, LastLibraryState table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $LastLibraryStateFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $LastLibraryStateOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $LastLibraryStateAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> tab = const Value.absent(),
                Value<ListQuery> albumsList = const Value.absent(),
                Value<ListQuery> artistsList = const Value.absent(),
                Value<ListQuery> playlistsList = const Value.absent(),
                Value<ListQuery> songsList = const Value.absent(),
              }) => LastLibraryStateCompanion(
                id: id,
                tab: tab,
                albumsList: albumsList,
                artistsList: artistsList,
                playlistsList: playlistsList,
                songsList: songsList,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String tab,
                required ListQuery albumsList,
                required ListQuery artistsList,
                required ListQuery playlistsList,
                required ListQuery songsList,
              }) => LastLibraryStateCompanion.insert(
                id: id,
                tab: tab,
                albumsList: albumsList,
                artistsList: artistsList,
                playlistsList: playlistsList,
                songsList: songsList,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $LastLibraryStateProcessedTableManager =
    ProcessedTableManager<
      _$SyncDatabase,
      LastLibraryState,
      LastLibraryStateData,
      $LastLibraryStateFilterComposer,
      $LastLibraryStateOrderingComposer,
      $LastLibraryStateAnnotationComposer,
      $LastLibraryStateCreateCompanionBuilder,
      $LastLibraryStateUpdateCompanionBuilder,
      (
        LastLibraryStateData,
        BaseReferences<_$SyncDatabase, LastLibraryState, LastLibraryStateData>,
      ),
      LastLibraryStateData,
      PrefetchHooks Function()
    >;
typedef $DownloadsCreateCompanionBuilder =
    DownloadsCompanion Function({
      required String songId,
      Value<String?> albumId,
      Value<String?> localPath,
      Value<DownloadStatus> downloadStatus,
      Value<int> downloadProgress,
      Value<bool> coverEmbedded,
      Value<DateTime> updated,
      Value<int> rowid,
    });
typedef $DownloadsUpdateCompanionBuilder =
    DownloadsCompanion Function({
      Value<String> songId,
      Value<String?> albumId,
      Value<String?> localPath,
      Value<DownloadStatus> downloadStatus,
      Value<int> downloadProgress,
      Value<bool> coverEmbedded,
      Value<DateTime> updated,
      Value<int> rowid,
    });

class $DownloadsFilterComposer extends Composer<_$SyncDatabase, Downloads> {
  $DownloadsFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get songId => $composableBuilder(
    column: $table.songId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get albumId => $composableBuilder(
    column: $table.albumId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get localPath => $composableBuilder(
    column: $table.localPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<DownloadStatus, DownloadStatus, String>
  get downloadStatus => $composableBuilder(
    column: $table.downloadStatus,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get downloadProgress => $composableBuilder(
    column: $table.downloadProgress,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get coverEmbedded => $composableBuilder(
    column: $table.coverEmbedded,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updated => $composableBuilder(
    column: $table.updated,
    builder: (column) => ColumnFilters(column),
  );
}

class $DownloadsOrderingComposer extends Composer<_$SyncDatabase, Downloads> {
  $DownloadsOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get songId => $composableBuilder(
    column: $table.songId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get albumId => $composableBuilder(
    column: $table.albumId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localPath => $composableBuilder(
    column: $table.localPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get downloadStatus => $composableBuilder(
    column: $table.downloadStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get downloadProgress => $composableBuilder(
    column: $table.downloadProgress,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get coverEmbedded => $composableBuilder(
    column: $table.coverEmbedded,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updated => $composableBuilder(
    column: $table.updated,
    builder: (column) => ColumnOrderings(column),
  );
}

class $DownloadsAnnotationComposer extends Composer<_$SyncDatabase, Downloads> {
  $DownloadsAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get songId =>
      $composableBuilder(column: $table.songId, builder: (column) => column);

  GeneratedColumn<String> get albumId =>
      $composableBuilder(column: $table.albumId, builder: (column) => column);

  GeneratedColumn<String> get localPath =>
      $composableBuilder(column: $table.localPath, builder: (column) => column);

  GeneratedColumnWithTypeConverter<DownloadStatus, String> get downloadStatus =>
      $composableBuilder(
        column: $table.downloadStatus,
        builder: (column) => column,
      );

  GeneratedColumn<int> get downloadProgress => $composableBuilder(
    column: $table.downloadProgress,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get coverEmbedded => $composableBuilder(
    column: $table.coverEmbedded,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updated =>
      $composableBuilder(column: $table.updated, builder: (column) => column);
}

class $DownloadsTableManager
    extends
        RootTableManager<
          _$SyncDatabase,
          Downloads,
          Download,
          $DownloadsFilterComposer,
          $DownloadsOrderingComposer,
          $DownloadsAnnotationComposer,
          $DownloadsCreateCompanionBuilder,
          $DownloadsUpdateCompanionBuilder,
          (Download, BaseReferences<_$SyncDatabase, Downloads, Download>),
          Download,
          PrefetchHooks Function()
        > {
  $DownloadsTableManager(_$SyncDatabase db, Downloads table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $DownloadsFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $DownloadsOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $DownloadsAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> songId = const Value.absent(),
                Value<String?> albumId = const Value.absent(),
                Value<String?> localPath = const Value.absent(),
                Value<DownloadStatus> downloadStatus = const Value.absent(),
                Value<int> downloadProgress = const Value.absent(),
                Value<bool> coverEmbedded = const Value.absent(),
                Value<DateTime> updated = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DownloadsCompanion(
                songId: songId,
                albumId: albumId,
                localPath: localPath,
                downloadStatus: downloadStatus,
                downloadProgress: downloadProgress,
                coverEmbedded: coverEmbedded,
                updated: updated,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String songId,
                Value<String?> albumId = const Value.absent(),
                Value<String?> localPath = const Value.absent(),
                Value<DownloadStatus> downloadStatus = const Value.absent(),
                Value<int> downloadProgress = const Value.absent(),
                Value<bool> coverEmbedded = const Value.absent(),
                Value<DateTime> updated = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DownloadsCompanion.insert(
                songId: songId,
                albumId: albumId,
                localPath: localPath,
                downloadStatus: downloadStatus,
                downloadProgress: downloadProgress,
                coverEmbedded: coverEmbedded,
                updated: updated,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $DownloadsProcessedTableManager =
    ProcessedTableManager<
      _$SyncDatabase,
      Downloads,
      Download,
      $DownloadsFilterComposer,
      $DownloadsOrderingComposer,
      $DownloadsAnnotationComposer,
      $DownloadsCreateCompanionBuilder,
      $DownloadsUpdateCompanionBuilder,
      (Download, BaseReferences<_$SyncDatabase, Downloads, Download>),
      Download,
      PrefetchHooks Function()
    >;
typedef $AlbumCoversCreateCompanionBuilder =
    AlbumCoversCompanion Function({
      required String albumId,
      required String coverPath,
      Value<DateTime> updated,
      Value<int> rowid,
    });
typedef $AlbumCoversUpdateCompanionBuilder =
    AlbumCoversCompanion Function({
      Value<String> albumId,
      Value<String> coverPath,
      Value<DateTime> updated,
      Value<int> rowid,
    });

class $AlbumCoversFilterComposer extends Composer<_$SyncDatabase, AlbumCovers> {
  $AlbumCoversFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get albumId => $composableBuilder(
    column: $table.albumId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get coverPath => $composableBuilder(
    column: $table.coverPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updated => $composableBuilder(
    column: $table.updated,
    builder: (column) => ColumnFilters(column),
  );
}

class $AlbumCoversOrderingComposer
    extends Composer<_$SyncDatabase, AlbumCovers> {
  $AlbumCoversOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get albumId => $composableBuilder(
    column: $table.albumId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get coverPath => $composableBuilder(
    column: $table.coverPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updated => $composableBuilder(
    column: $table.updated,
    builder: (column) => ColumnOrderings(column),
  );
}

class $AlbumCoversAnnotationComposer
    extends Composer<_$SyncDatabase, AlbumCovers> {
  $AlbumCoversAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get albumId =>
      $composableBuilder(column: $table.albumId, builder: (column) => column);

  GeneratedColumn<String> get coverPath =>
      $composableBuilder(column: $table.coverPath, builder: (column) => column);

  GeneratedColumn<DateTime> get updated =>
      $composableBuilder(column: $table.updated, builder: (column) => column);
}

class $AlbumCoversTableManager
    extends
        RootTableManager<
          _$SyncDatabase,
          AlbumCovers,
          AlbumCover,
          $AlbumCoversFilterComposer,
          $AlbumCoversOrderingComposer,
          $AlbumCoversAnnotationComposer,
          $AlbumCoversCreateCompanionBuilder,
          $AlbumCoversUpdateCompanionBuilder,
          (AlbumCover, BaseReferences<_$SyncDatabase, AlbumCovers, AlbumCover>),
          AlbumCover,
          PrefetchHooks Function()
        > {
  $AlbumCoversTableManager(_$SyncDatabase db, AlbumCovers table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $AlbumCoversFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $AlbumCoversOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $AlbumCoversAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> albumId = const Value.absent(),
                Value<String> coverPath = const Value.absent(),
                Value<DateTime> updated = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AlbumCoversCompanion(
                albumId: albumId,
                coverPath: coverPath,
                updated: updated,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String albumId,
                required String coverPath,
                Value<DateTime> updated = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AlbumCoversCompanion.insert(
                albumId: albumId,
                coverPath: coverPath,
                updated: updated,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $AlbumCoversProcessedTableManager =
    ProcessedTableManager<
      _$SyncDatabase,
      AlbumCovers,
      AlbumCover,
      $AlbumCoversFilterComposer,
      $AlbumCoversOrderingComposer,
      $AlbumCoversAnnotationComposer,
      $AlbumCoversCreateCompanionBuilder,
      $AlbumCoversUpdateCompanionBuilder,
      (AlbumCover, BaseReferences<_$SyncDatabase, AlbumCovers, AlbumCover>),
      AlbumCover,
      PrefetchHooks Function()
    >;

class $SyncDatabaseManager {
  final _$SyncDatabase _db;
  $SyncDatabaseManager(this._db);
  $ServerTableManager get server => $ServerTableManager(_db, _db.server);
  $AppSettingsTableTableManager get appSettings =>
      $AppSettingsTableTableManager(_db, _db.appSettings);
  $LastLibraryStateTableManager get lastLibraryState =>
      $LastLibraryStateTableManager(_db, _db.lastLibraryState);
  $DownloadsTableManager get downloads =>
      $DownloadsTableManager(_db, _db.downloads);
  $AlbumCoversTableManager get albumCovers =>
      $AlbumCoversTableManager(_db, _db.albumCovers);
}

class DownloadCountsByAlbumResult {
  final String? albumId;
  final int downloaded;
  final int downloading;
  DownloadCountsByAlbumResult({
    this.albumId,
    required this.downloaded,
    required this.downloading,
  });
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(database)
final databaseProvider = DatabaseProvider._();

final class DatabaseProvider
    extends $FunctionalProvider<SyncDatabase, SyncDatabase, SyncDatabase>
    with $Provider<SyncDatabase> {
  DatabaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'databaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$databaseHash();

  @$internal
  @override
  $ProviderElement<SyncDatabase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SyncDatabase create(Ref ref) {
    return database(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SyncDatabase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SyncDatabase>(value),
    );
  }
}

String _$databaseHash() => r'7c3e9d6467a5d3f53fb2cd76f036ff6b5cf9cd2d';
