import '../entities/auth_session.dart';
import '../entities/auth_tokens.dart';

abstract class AuthRepository {
  /// 네이버 인증 → (백엔드) JWT 발급 → 토큰 저장 후 세션 반환.
  Future<AuthSession> loginWithNaver();

  /// Apple 인증 → (데모) 로컬 JWT / (Phase 7) 백엔드 JWT 발급 → 토큰 저장 후 세션 반환.
  Future<AuthSession> loginWithApple();

  /// 저장 토큰 삭제 및 네이버 세션 해제.
  Future<void> logout();

  /// 회원 탈퇴 처리 후 로컬 인증 상태를 정리한다.
  ///
  /// 현재(데모 단계)는 로컬 토큰 삭제만 수행한다.
  /// 소셜 연동 revoke는 서버 withdraw API에서 처리한다.
  Future<void> withdraw();

  /// 저장된 토큰으로 세션 복원. 유효 세션이 없으면 null.
  Future<AuthSession?> restoreSession();

  /// refresh 토큰으로 access/refresh 재발급 (백엔드 연동 시 사용).
  Future<AuthTokens> refreshTokens();
}
