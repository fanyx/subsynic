import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:subsynic/models/settings.dart';
import 'package:subsynic/sources/subsonic/client.dart';
import 'package:subsynic/sources/subsonic/source.dart';

ServerSettings _settings({bool tokenAuth = true}) => ServerSettings(
      address: Uri.parse('https://server.example/sub'),
      username: 'alice',
      password: 'secret',
      useTokenAuth: tokenAuth,
    );

void main() {
  group('SubsonicClient.uri', () {
    test('builds rest endpoint preserving server base path', () {
      final client = SubsonicClient(_settings(), Dio());
      final uri = client.uri('ping');

      expect(uri.scheme, 'https');
      expect(uri.host, 'server.example');
      expect(uri.path, '/sub/rest/ping.view');
      expect(uri.queryParameters['v'], '1.13.0');
      expect(uri.queryParameters['c'], 'subsynic');
      expect(uri.queryParameters['u'], 'alice');
    });

    test('uses md5 token auth when enabled', () {
      final client = SubsonicClient(_settings(), Dio());
      final uri = client.uri('ping');

      final salt = uri.queryParameters['s']!;
      final expected = md5.convert(utf8.encode('secret$salt')).toString();
      expect(uri.queryParameters['t'], expected);
      expect(uri.queryParameters.containsKey('p'), isFalse);
    });

    test('falls back to plaintext password auth when disabled', () {
      final client =
          SubsonicClient(_settings(tokenAuth: false), Dio());
      final uri = client.uri('ping');

      expect(uri.queryParameters['p'], 'secret');
      expect(uri.queryParameters.containsKey('t'), isFalse);
      expect(uri.queryParameters.containsKey('s'), isFalse);
    });

    test('includes extra params and drops null values', () {
      final client = SubsonicClient(_settings(), Dio());
      final uri = client.uri('getAlbum', {
        'id': 'album-1',
        'nullable': null,
      });

      expect(uri.queryParameters['id'], 'album-1');
      expect(uri.queryParameters.containsKey('nullable'), isFalse);
    });
  });

  group('SubsonicSource URIs', () {
    test('streamUri requests server-transcoded opus 128k', () {
      final source = SubsonicSource(opt: _settings(), dio: Dio());
      final uri = source.streamUri('song-1');

      expect(uri.path, '/sub/rest/stream.view');
      expect(uri.queryParameters['id'], 'song-1');
      expect(uri.queryParameters['format'], 'opus');
      expect(uri.queryParameters['maxBitRate'], '128');
    });

    test('coverArtUri always requests 600x600', () {
      final source = SubsonicSource(opt: _settings(), dio: Dio());
      final uri = source.coverArtUri('cover-1');

      expect(uri.path, '/sub/rest/getCoverArt.view');
      expect(uri.queryParameters['id'], 'cover-1');
      expect(uri.queryParameters['size'], '600');
    });
  });
}
