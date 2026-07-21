import 'package:ssoss_flutter/core/exception/app_exception.dart';

import '../../domain/entities/auth_session.dart';
import '../../domain/entities/auth_tokens.dart';
import '../../domain/entities/social_provider.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/apple_auth_datasource.dart';
import '../datasources/auth_local_datasource.dart';
import '../datasources/auth_remote_datasource.dart';
import '../datasources/naver_auth_datasource.dart';
import '../models/auth_token_model.dart';
import '../models/social_login_request.dart';
import '../models/stored_auth_cache_model.dart';

/// [AuthRepository] 실서버 연동 구현체.
class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl({
    required NaverAuthDatasource naverDatasource,
    required AppleAuthDatasource appleDatasource,
    required AuthRemoteDatasource remoteDatasource,
    required AuthLocalDatasource localDatasource,
  })  : _naverDatasource = naverDatasource,
        _appleDatasource = appleDatasource,
        _remoteDatasource = remoteDatasource,
        _localDatasource = localDatasource;

  final NaverAuthDatasource _naverDatasource;
  final AppleAuthDatasource _appleDatasource;
  final AuthRemoteDatasource _remoteDatasource;
  final AuthLocalDatasource _localDatasource;

  @override
  Future<AuthSession> loginWithNaver() async {
    final account = await _naverDatasource.login();
    final token = await _remoteDatasource.socialLogin(
      provider: 'naver',
      request: SocialLoginRequest(accessToken: account.accessToken),
    );
    final session = AuthSession(
      user: User(
        id: account.id,
        nickname: account.nickname,
        email: account.email,
        provider: SocialProvider.naver,
      ),
      tokens: token.toEntity(),
    );
    await _saveSession(
      token: token,
      provider: 'naver',
      session: session,
    );
    return session;
  }

  @override
  Future<AuthSession> loginWithApple() async {
    final account = await _appleDatasource.login();
    if (account.userIdentifier.isEmpty) {
      throw AuthException.socialFailed('Apple 계정 정보를 가져오지 못했습니다.');
    }
    final identityToken = account.identityToken;
    if (identityToken == null || identityToken.isEmpty) {
      throw AuthException.socialFailed('Apple identity token 을 가져오지 못했습니다.');
    }

    final token = await _remoteDatasource.socialLogin(
      provider: 'apple',
      request: SocialLoginRequest(accessToken: identityToken),
    );
    final session = AuthSession(
      user: User(
        id: account.userIdentifier,
        nickname: account.nickname,
        email: account.email,
        provider: SocialProvider.apple,
      ),
      tokens: token.toEntity(),
    );
    await _saveSession(
      token: token,
      provider: 'apple',
      session: session,
    );
    return session;
  }

  @override
  Future<AuthSession?> restoreSession() async {
    final cache = await _localDatasource.readSession();
    if (cache == null) return null;
    return cache.toEntity();
  }

  @override
  Future<void> logout() async {
    final cache = await _localDatasource.readSession();
    final refreshToken = cache?.token.refreshToken;
    if (refreshToken != null && refreshToken.isNotEmpty) {
      try {
        await _remoteDatasource.logout(refreshToken);
      } catch (_) {
        // 멱등·네트워크 실패여도 로컬은 정리한다.
      }
    }
    await _localDatasource.clear();
    if (cache?.provider == 'naver') {
      await _naverDatasource.logout();
    }
  }

  @override
  Future<void> withdraw() async {
    // Phase 8: remote withdraw → local clear
    await _localDatasource.clear();
  }

  @override
  Future<AuthTokens> refreshTokens() async {
    final cache = await _localDatasource.readSession();
    final refreshToken = cache?.token.refreshToken;
    if (refreshToken == null || refreshToken.isEmpty) {
      throw AuthException.unauthenticated();
    }

    final token = await _remoteDatasource.refresh(refreshToken);
    await _localDatasource.updateTokens(token);
    return token.toEntity();
  }

  Future<void> _saveSession({
    required AuthTokenModel token,
    required String provider,
    required AuthSession session,
  }) async {
    await _localDatasource.saveSession(
      StoredAuthCacheModel(
        token: token,
        provider: provider,
        userId: session.user.id,
        nickname: session.user.nickname,
        email: session.user.email,
      ),
    );
  }
}
