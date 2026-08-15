import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'api_environment.dart';
import 'interceptors/api_logging_interceptor.dart';

class DioFactory {
  DioFactory._();

  /// 앱 API용 Dio. [AuthInterceptor] 는 auth provider 에서 별도 등록한다.
  static Dio create(ApiEnvironment environment) =>
      _create(environment);

  /// AuthInterceptor 를 절대 붙이지 않는 Dio.
  ///
  /// `QueuedInterceptor` 의 onError 안에서 같은 Dio 로 refresh 하면
  /// 에러 큐 데드락이 나므로, refresh·social login·logout 은 이 인스턴스를 쓴다.
  static Dio createUnauthenticated(ApiEnvironment environment) =>
      _create(environment);

  static Dio _create(ApiEnvironment environment) {
    final dio = Dio(
      BaseOptions(
        baseUrl: environment.baseUrl,
        connectTimeout: environment.connectTimeout,
        receiveTimeout: environment.receiveTimeout,
        headers: const {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // flavor 와 무관하게 debug/profile 에서 로깅.
    if (!kReleaseMode) {
      dio.interceptors.add(const ApiLoggingInterceptor());
    }

    return dio;
  }
}
