import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:xml/xml.dart';

import '../../log.dart';
import '../../models/settings.dart';
import 'xml.dart';

class SubsonicException implements Exception {
  final XmlElement xml;

  late int code;
  late String message;

  SubsonicException(this.xml) {
    try {
      final error = xml.getElement('error')!;
      code = int.parse(error.getAttribute('code')!);
      message = error.getAttribute('message')!;
    } catch (err) {
      code = -1;
      message = 'Unknown error.';
    }
  }

  @override
  String toString() => 'SubsonicException [$code]: $message';
}

class SubsonicClient {
  final ServerSettings opt;
  final Dio _dio;

  SubsonicClient(this.opt, this._dio);

  String _salt() {
    final r = Random();
    return String.fromCharCodes(
      List.generate(4, (index) => r.nextInt(92) + 33),
    );
  }

  Map<String, String> _params() {
    final Map<String, String> p = {};
    p['v'] = '1.13.0';
    p['c'] = 'subsynic';
    p['u'] = opt.username;

    if (opt.useTokenAuth) {
      p['s'] = _salt();
      p['t'] = md5.convert(utf8.encode(opt.password + p['s']!)).toString();
    } else {
      p['p'] = opt.password;
    }

    return p;
  }

  Uri uri(
    String method, [
    Map<String, String?>? extraParams,
  ]) {
    final pathSegments = [...opt.address.pathSegments, 'rest', '$method.view'];

    extraParams?.removeWhere((key, value) => value == null);
    final queryParameters = {
      ..._params(),
      ...(extraParams ?? {}),
    };

    return Uri(
      scheme: opt.address.scheme,
      host: opt.address.host,
      port: opt.address.hasPort ? opt.address.port : null,
      pathSegments: pathSegments,
      queryParameters: queryParameters,
    );
  }

  Future<SubsonicResponse> get(
    String method, [
    Map<String, String?>? extraParams,
  ]) async {
    final res = await _dio.get<Uint8List>(
      uri(method, extraParams).toString(),
      options: Options(responseType: ResponseType.bytes),
    );
    final subsonicResponse =
        SubsonicResponse(XmlDocument.parse(utf8.decode(res.data!)));
    if (subsonicResponse.status == Status.failed) {
      final error = SubsonicException(subsonicResponse.xml);
      log.severe('Subsonic error', error);
      throw error;
    }

    return subsonicResponse;
  }

  Future<void> test() => get('ping');
}
