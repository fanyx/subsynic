import 'package:drift/drift.dart' show Value;
import 'package:freezed_annotation/freezed_annotation.dart';

import '../database/database.dart';

part 'settings.freezed.dart';

@freezed
abstract class AppSettings with _$AppSettings {
  const AppSettings._();

  const factory AppSettings({
    Uri? libraryRootUri,
    @Default(false) bool embedCover,
  }) = _AppSettings;

  AppSettingsCompanion toCompanion() {
    return AppSettingsCompanion.insert(
      id: const Value(1),
      libraryRootUri: Value(libraryRootUri),
      embedCover: Value(embedCover),
    );
  }
}

@freezed
abstract class SettingsState with _$SettingsState {
  const factory SettingsState({
    ServerSettings? server,
    @Default(AppSettings()) AppSettings app,
  }) = _SettingsState;
}

@freezed
abstract class ServerSettings with _$ServerSettings {
  const ServerSettings._();

  const factory ServerSettings({
    required Uri address,
    required String username,
    required String password,
    @Default(true) bool useTokenAuth,
  }) = _ServerSettings;
}
