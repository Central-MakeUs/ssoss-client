import '../models/auth_token_model.dart';
import '../models/stored_auth_cache_model.dart';

/// 토큰·프로필 로컬 저장소. secure storage 를 통해 세션을 저장·조회·삭제한다.
abstract class AuthLocalDatasource {
  Future<void> saveSession(StoredAuthCacheModel cache);

  Future<StoredAuthCacheModel?> readSession();

  /// RTR 후 access/refresh 만 교체 저장.
  Future<void> updateTokens(AuthTokenModel token);

  Future<void> clear();
}
