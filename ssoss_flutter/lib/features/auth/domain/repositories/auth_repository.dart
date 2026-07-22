import '../entities/auth_session.dart';
import '../entities/auth_tokens.dart';
import '../entities/signup_agreement.dart';

abstract class AuthRepository {
  /// 네이버 인증 → (백엔드) JWT 발급 → 토큰 저장 후 세션 반환.
  Future<AuthSession> loginWithNaver();

  /// Apple 인증 → (데모) 로컬 JWT / (Phase 7) 백엔드 JWT 발급 → 토큰 저장 후 세션 반환.
  Future<AuthSession> loginWithApple();

  /// 저장 토큰 삭제 및 네이버 세션 해제.
  Future<void> logout();

  /// 회원 탈퇴: `DELETE /v1/members/me` 후 로컬 세션 정리.
  ///
  /// 소셜 연동 revoke는 서버에서 처리한다.
  Future<void> withdraw();

  /// 가입 대기(PENDING) 회원의 약관 동의 후 회원가입.
  Future<AuthSession> signup(SignupAgreement agreement);

  /// 저장된 토큰으로 세션 복원. 유효 세션이 없으면 null.
  Future<AuthSession?> restoreSession();

  /// refresh 토큰으로 access/refresh 재발급 (백엔드 연동 시 사용).
  Future<AuthTokens> refreshTokens();
}
