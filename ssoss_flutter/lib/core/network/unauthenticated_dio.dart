import 'package:dio/dio.dart';

/// [AuthInterceptor] 가 등록되지 않는 Dio 래퍼.
///
/// Provider 에서 메인 [Dio] 와 구분하기 위해 사용한다.
class UnauthenticatedDio {
  UnauthenticatedDio(this.client);

  final Dio client;

  void close({bool force = false}) => client.close(force: force);
}
