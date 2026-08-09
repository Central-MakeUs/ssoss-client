/// 세션 만료 직후 원요청 실패 토스트를 잠시 막는다.
abstract final class ErrorUiSuppressor {
  static bool suppressToasts = false;
}
