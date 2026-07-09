import '../models/stored_auth_cache_model.dart';

/// 토큰·프로필 로컬 저장소. secure storage 를 통해 세션을 저장·조회·삭제한다.
abstract class AuthLocalDatasource {
  Future<void> saveSession(StoredAuthCacheModel cache);

  Future<StoredAuthCacheModel?> readSession();

  Future<void> clear();
}
