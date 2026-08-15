import '../models/naver_account_model.dart';

/// 네이버 SDK 래퍼. 네이버 로그인/로그아웃을 담당한다.
abstract class NaverAuthDatasource {
  /// 네이버 로그인 수행. 성공 시 [NaverAccountModel] 반환.
  ///
  /// 사용자가 취소하면 `AuthException.cancelled`,
  /// 인증 실패 시 `AuthException.socialFailed` 를 throw 한다.
  Future<NaverAccountModel> login();

  /// 네이버 로그아웃
  Future<void> logout();
}
