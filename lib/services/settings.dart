import 'package:drift/drift.dart' show Value;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../database/database.dart';
import '../models/settings.dart';
import '../sources/subsonic/client.dart';
import 'network/client.dart';

part 'settings.g.dart';

@Riverpod(keepAlive: true)
class SettingsService extends _$SettingsService {
  SyncDatabase get _db => ref.read(databaseProvider);

  @override
  SettingsState build() {
    return const SettingsState();
  }

  Future<void> init() async {
    final server = await _db.getServer().getSingleOrNull();
    final settings = await _db.getAppSettings().getSingleOrNull();

    state = SettingsState(
      server: server,
      app: settings ?? const AppSettings(),
    );
  }

  /// Validates the server (ping) and persists it.
  Future<void> saveServer(ServerSettings server) async {
    final client = SubsonicClient(server, ref.read(dioProvider));

    await client.test();

    await _db.saveServer(
      ServerCompanion.insert(
        id: const Value(1),
        address: server.address,
        username: server.username,
        password: server.password,
        useTokenAuth: Value(server.useTokenAuth),
      ),
    );
    await init();
  }

  Future<void> setLibraryRoot(Uri? uri) async {
    await _db.updateSettings(
      state.app.copyWith(libraryRootUri: uri).toCompanion(),
    );
    await init();
  }

  Future<void> setEmbedCover(bool value) async {
    await _db.updateSettings(
      state.app.copyWith(embedCover: value).toCompanion(),
    );
    await init();
  }
}
