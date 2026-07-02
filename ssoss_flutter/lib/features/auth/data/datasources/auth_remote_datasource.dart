import '../models/auth_response_model.dart';
import '../models/auth_token_model.dart';
import '../models/social_login_request.dart';

/// 백엔드 인증 API 인터페이스.
///
/// 실 Dio 구현(`AuthRemoteDatasourceImpl`)은 Phase 7 에서 작성한다.
/// 데모 단계에서는 [DemoAuthRemoteDatasource] 가 이 계약을 대체한다.
abstract class AuthRemoteDatasource {
  Future<AuthResponseModel> socialLogin(SocialLoginRequest request);

  Future<AuthTokenModel> refresh(String refreshToken);

  Future<void> logout();
}
