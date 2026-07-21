import '../models/auth_token_model.dart';
import '../models/social_login_request.dart';

/// 백엔드 인증 API 인터페이스.
abstract class AuthRemoteDatasource {
  /// `POST /v1/social-logins/{provider}`
  Future<AuthTokenModel> socialLogin({
    required String provider,
    required SocialLoginRequest request,
  });

  /// `POST /v1/tokens` (RTR)
  Future<AuthTokenModel> refresh(String refreshToken);

  /// `POST /v1/logout` (멱등 204)
  Future<void> logout(String refreshToken);

  /// 회원 탈퇴 — Phase 8 에서 구현.
  Future<void> withdraw();
}
