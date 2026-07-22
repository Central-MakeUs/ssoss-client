import '../models/auth_token_model.dart';
import '../models/signup_request_model.dart';
import '../models/social_login_request.dart';
import '../models/social_login_response_model.dart';

/// 백엔드 인증 API 인터페이스.
abstract class AuthRemoteDatasource {
  /// `POST /v1/social-logins/{provider}`
  Future<SocialLoginResponseModel> socialLogin({
    required String provider,
    required SocialLoginRequest request,
  });

  /// `POST /v1/tokens` (RTR)
  Future<AuthTokenModel> refresh(String refreshToken);

  /// `POST /v1/logout` (멱등 204)
  Future<void> logout(String refreshToken);

  /// `POST /v1/members/me/recovery` — WITHDRAWN 전용.
  Future<SocialLoginResponseModel> recover();

  /// `DELETE /v1/members/me` — ACTIVE 전용.
  Future<void> withdraw();

  /// `POST /v1/signup` — PENDING 전용.
  Future<SocialLoginResponseModel> signup(SignupRequestModel request);
}
