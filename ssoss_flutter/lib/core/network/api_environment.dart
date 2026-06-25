import '../config/app_flavor.dart';
import '../config/env_loader.dart';

/// Flavor별 API 서버 환경 설정
class ApiEnvironment {
  const ApiEnvironment({
    required this.flavor,
    required this.baseUrl,
    this.connectTimeout = const Duration(seconds: 10),
    this.receiveTimeout = const Duration(seconds: 30),
  });

  final AppFlavor flavor;
  final String baseUrl;
  final Duration connectTimeout;
  final Duration receiveTimeout;

  factory ApiEnvironment.fromFlavor(AppFlavor flavor) {
    return ApiEnvironment(
      flavor: flavor,
      baseUrl: EnvLoader.require(EnvLoader.apiBaseUrlKey),
    );
  }
}
