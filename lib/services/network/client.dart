import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../log.dart';

part 'client.g.dart';

const Map<String, String> kSubsynicHeaders = {
  'user-agent': 'subsynic/android',
};

@Riverpod(keepAlive: true)
Dio dio(Ref ref) {
  final dio = Dio(
    BaseOptions(
      headers: {...kSubsynicHeaders},
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(minutes: 10),
    ),
  );

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {
        log.info('${options.method} ${options.uri}');
        handler.next(options);
      },
      onError: (e, handler) {
        log.severe(
          'Dio error: ${e.requestOptions.method} ${e.requestOptions.uri}',
          e,
          e.stackTrace,
        );
        handler.next(e);
      },
    ),
  );

  return dio;
}
