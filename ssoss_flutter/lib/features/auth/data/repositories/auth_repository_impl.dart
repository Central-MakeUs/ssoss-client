import 'package:ssoss_flutter/core/exception/app_exception.dart';

import '../../domain/entities/auth_session.dart';
import '../../domain/entities/auth_tokens.dart';
import '../../domain/entities/social_provider.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/apple_auth_datasource.dart';
import '../datasources/auth_local_datasource.dart';
import '../datasources/demo_auth_remote_datasource.dart';
import '../datasources/naver_auth_datasource.dart';
import '../models/auth_response_model.dart';
import '../models/stored_auth_cache_model.dart';

/// [AuthRepository] 데모 구현체.
///
/// 백엔드 미연동 상태이므로 [DemoAuthRemoteDatasource] 로 세션을 생성한다.
/// 백엔드 연동(Phase 7) 시 데모 경로를 실제 remote datasource 호출로 전환한다.
class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl({
    required NaverAuthDatasource naverDatasource,
    required AppleAuthDatasource appleDatasource,
    required DemoAuthRemoteDatasource demoRemoteDatasource,
    required AuthLocalDatasource localDatasource,
  })  : _naverDatasource = naverDatasource,
        _appleDatasource = appleDatasource,
        _demoRemoteDatasource = demoRemoteDatasource,
        _localDatasource = localDatasource;

  final NaverAuthDatasource _naverDatasource;
  final AppleAuthDatasource _appleDatasource;
  final DemoAuthRemoteDatasource _demoRemoteDatasource;
  final AuthLocalDatasource _localDatasource;

  @override
  Future<AuthSession> loginWithNaver() async {
    final account = await _naverDatasource.login();
    final response = await _demoRemoteDatasource.createSession(account);
    final session = response.toEntity(SocialProvider.naver);
    await _saveSession(
      response: response,
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
    final response =
        await _demoRemoteDatasource.createSessionFromApple(account);
    final session = response.toEntity(SocialProvider.apple);
    await _saveSession(
      response: response,
      provider: 'apple',
      session: session,
    );
    return session;
  }

  @override
  Future<AuthSession?> restoreSession() async {
    final cache = await _localDatasource.readSession();
    if (cache == null) return null;

    final session = cache.toEntity();
    if (session.tokens.isExpired) {
      await _localDatasource.clear();
      return null;
    }
    return session;
  }

  @override
  Future<void> logout() async {
    final cache = await _localDatasource.readSession();
    await _localDatasource.clear();
    if (cache?.provider == 'naver') {
      await _naverDatasource.logout();
    }
  }

  @override
  Future<void> withdraw() async {
    // TODO: 서버 withdraw API 호출
    await _localDatasource.clear();
  }

  @override
  Future<AuthTokens> refreshTokens() async {
    // Phase 7 백엔드 연동 시 실제 토큰 갱신을 구현한다.
    throw AuthException.unauthenticated('토큰 갱신은 아직 지원되지 않습니다.');
  }

  Future<void> _saveSession({
    required AuthResponseModel response,
    required String provider,
    required AuthSession session,
  }) async {
    await _localDatasource.saveSession(
      StoredAuthCacheModel(
        token: response.token,
        provider: provider,
        userId: session.user.id,
        nickname: session.user.nickname,
        email: session.user.email,
      ),
    );
  }
}
