import 'dart:convert';

import 'package:ssoss_flutter/core/service/secure_storage_service.dart';

import '../models/auth_token_model.dart';
import 'auth_local_datasource.dart';

class AuthLocalDatasourceImpl implements AuthLocalDatasource {
  const AuthLocalDatasourceImpl(this._storage);

  static const String _tokenKey = 'auth_tokens';

  final SecureStorageService _storage;

  @override
  Future<void> saveTokens(AuthTokenModel token) async {
    await _storage.write(
      key: _tokenKey,
      value: jsonEncode(token.toJson()),
    );
  }

  @override
  Future<AuthTokenModel?> readTokens() async {
    final raw = await _storage.read(key: _tokenKey);
    if (raw == null || raw.isEmpty) return null;
    final json = jsonDecode(raw) as Map<String, dynamic>;
    return AuthTokenModel.fromJson(json);
  }

  @override
  Future<void> clear() async {
    await _storage.delete(key: _tokenKey);
  }
}
