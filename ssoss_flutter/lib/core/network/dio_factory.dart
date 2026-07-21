import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'api_environment.dart';
import 'interceptors/api_logging_interceptor.dart';

class DioFactory {
  DioFactory._();

  static Dio create(ApiEnvironment environment) {
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
