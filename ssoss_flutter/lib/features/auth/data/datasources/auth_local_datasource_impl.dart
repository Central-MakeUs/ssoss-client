import 'dart:convert';

import 'package:ssoss_flutter/core/service/secure_storage_service.dart';

import '../models/auth_token_model.dart';
import '../models/stored_auth_cache_model.dart';
import 'auth_local_datasource.dart';

class AuthLocalDatasourceImpl implements AuthLocalDatasource {
  const AuthLocalDatasourceImpl(this._storage);

  static const String _sessionKey = 'auth_session';
  static const String _legacyTokenKey = 'auth_tokens';

  final SecureStorageService _storage;

  @override
  Future<void> saveSession(StoredAuthCacheModel cache) async {
    await _storage.write(
      key: _sessionKey,
      value: jsonEncode(cache.toJson()),
    );
  }

  @override
  Future<StoredAuthCacheModel?> readSession() async {
    final raw = await _storage.read(key: _sessionKey);
    if (raw == null || raw.isEmpty) return null;
    try {
      final json = jsonDecode(raw) as Map<String, dynamic>;
      return StoredAuthCacheModel.fromJson(json);
    } catch (_) {
      // 스키마 변경 등으로 파싱 실패 시 세션 폐기
      await clear();
      return null;
    }
  }

  @override
  Future<void> updateTokens(AuthTokenModel token) async {
    final cache = await readSession();
    if (cache == null) return;
    await saveSession(cache.copyWith(token: token));
  }

  @override
  Future<void> clear() async {
    await _storage.delete(key: _sessionKey);
    await _storage.delete(key: _legacyTokenKey);
  }
}
