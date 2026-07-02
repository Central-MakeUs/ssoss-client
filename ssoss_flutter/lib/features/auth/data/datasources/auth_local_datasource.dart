import '../models/auth_token_model.dart';

/// 토큰 로컬 저장소. secure storage 를 통해 토큰을 저장·조회·삭제한다.
abstract class AuthLocalDatasource {
  Future<void> saveTokens(AuthTokenModel token);

  Future<AuthTokenModel?> readTokens();

  Future<void> clear();
}
