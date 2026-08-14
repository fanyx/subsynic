import 'dart:convert';

import 'package:drift/drift.dart';

import '../models/download.dart';
import '../models/query.dart';

class UriConverter extends TypeConverter<Uri, String> {
  const UriConverter();

  @override
  Uri fromSql(String fromDb) => Uri.parse(fromDb);

  @override
  String toSql(Uri value) => value.toString();
}

class ListQueryConverter extends TypeConverter<ListQuery, String> {
  const ListQueryConverter();

  @override
  ListQuery fromSql(String fromDb) => ListQuery.fromJson(jsonDecode(fromDb));

  @override
  String toSql(ListQuery value) => jsonEncode(value.toJson());
}

class DownloadStatusConverter extends TypeConverter<DownloadStatus, String> {
  const DownloadStatusConverter();

  @override
  DownloadStatus fromSql(String fromDb) => DownloadStatus.values.byName(fromDb);

  @override
  String toSql(DownloadStatus value) => value.name;
}
