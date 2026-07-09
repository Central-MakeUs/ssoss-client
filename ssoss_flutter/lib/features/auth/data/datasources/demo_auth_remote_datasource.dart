import '../models/apple_account_model.dart';
import '../models/auth_response_model.dart';
import '../models/auth_token_model.dart';
import '../models/naver_account_model.dart';
import '../models/user_model.dart';

/// 백엔드 미연동 상태에서 로그인 흐름을 완성하기 위한 데모 구현.
///
/// 네이버 프로필로 로컬에서 더미 JWT/만료시간을 가진 [AuthResponseModel] 을 생성한다.
/// 백엔드 연동(Phase 7) 시 실제 `AuthRemoteDatasourceImpl` 로 대체한다.
class DemoAuthRemoteDatasource {
  const DemoAuthRemoteDatasource();

  /// 네이버 계정 정보로 데모 세션을 생성한다.
  Future<AuthResponseModel> createSession(NaverAccountModel account) async {
    // 실제 네트워크 지연을 흉내내어 로딩 UI 를 확인할 수 있게 한다.
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
        expiresIn: const Duration(hours: 1).inSeconds,
      ),
    );
  }

  /// Apple 계정 정보로 데모 세션을 생성한다.
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
        expiresIn: const Duration(hours: 1).inSeconds,
      ),
    );
  }
}
