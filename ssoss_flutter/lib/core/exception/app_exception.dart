/// 앱·피처 공통 예외 계층.
///
/// 프로젝트는 `Either<Failure, T>` 를 사용하지 않고 예외 throw 로 실패를 전달한다.
sealed class AppException implements Exception {
  const AppException(this.message);

  final String message;

  @override
  String toString() => '$runtimeType($message)';
}

/// 네트워크 연결 오류.
class NetworkException extends AppException {
  const NetworkException([super.message = '네트워크 오류가 발생했습니다.']);
}

/// 서버 응답 오류 (4xx/5xx).
class ServerException extends AppException {
  const ServerException(this.statusCode, [super.message = '서버 오류가 발생했습니다.']);

  final int statusCode;
}

/// 인증 관련 오류 유형.
enum AuthErrorType {
  /// 사용자가 인증을 취소함.
  cancelled,

  /// 소셜 인증 실패 (토큰 무효 등).
  socialFailed,

  /// 세션 만료·미인증 상태.
  unauthenticated,
}

/// 인증 예외.
class AuthException extends AppException {
  const AuthException(super.message, this.type);

  final AuthErrorType type;

  factory AuthException.cancelled([String message = '로그인이 취소되었습니다.']) =>
      AuthException(message, AuthErrorType.cancelled);

  factory AuthException.socialFailed([String message = '소셜 로그인에 실패했습니다.']) =>
      AuthException(message, AuthErrorType.socialFailed);

  factory AuthException.unauthenticated([String message = '세션이 만료되었습니다.']) =>
      AuthException(message, AuthErrorType.unauthenticated);
}
