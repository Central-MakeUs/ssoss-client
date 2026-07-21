import '../models/apple_account_model.dart';
import '../models/auth_response_model.dart';
import '../models/auth_token_model.dart';
import '../models/naver_account_model.dart';
import '../models/user_model.dart';

/// 백엔드 미연동 상태에서 로그인 흐름을 완성하기 위한 데모 구현.
///
/// Phase 7 이후 DI 에서는 사용하지 않는다. 로컬/테스트용으로 유지한다.
class DemoAuthRemoteDatasource {
  const DemoAuthRemoteDatasource();

  Future<AuthResponseModel> createSession(NaverAccountModel account) async {
    await Future<void>.delayed(const Duration(milliseconds: 300));

    final issuedAt = DateTime.now().millisecondsSinceEpoch;

    return AuthResponseModel(
      user: UserModel(
        id: account.id,
        nickname: account.nickname,
        email: account.email,
        profileImageUrl: account.profileImage,
      ),
      token: AuthTokenModel(
        accessToken: 'demo-access-$issuedAt',
        refreshToken: 'demo-refresh-$issuedAt',
      ),
    );
  }

  Future<AuthResponseModel> createSessionFromApple(
    AppleAccountModel account,
  ) async {
    await Future<void>.delayed(const Duration(milliseconds: 300));

    final issuedAt = DateTime.now().millisecondsSinceEpoch;

    return AuthResponseModel(
      user: UserModel(
        id: account.userIdentifier,
        nickname: account.nickname,
        email: account.email,
      ),
      token: AuthTokenModel(
        accessToken: 'demo-access-$issuedAt',
        refreshToken: 'demo-refresh-$issuedAt',
      ),
    );
  }
}
