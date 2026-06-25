import 'package:dio/dio.dart';

import 'api_environment.dart';

class DioFactory {
  DioFactory._();

  static Dio create(ApiEnvironment environment) {
    return Dio(
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
  }
}
