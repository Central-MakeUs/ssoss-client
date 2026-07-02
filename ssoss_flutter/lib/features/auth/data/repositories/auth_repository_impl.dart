import 'package:ssoss_flutter/core/exception/app_exception.dart';

import '../../domain/entities/auth_session.dart';
import '../../domain/entities/auth_tokens.dart';
import '../../domain/entities/social_provider.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_datasource.dart';
import '../datasources/demo_auth_remote_datasource.dart';
import '../datasources/naver_auth_datasource.dart';
import '../models/auth_response_model.dart';
import '../models/auth_token_model.dart';

/// [AuthRepository] 데모 구현체.
///
/// 백엔드 미연동 상태이므로 [DemoAuthRemoteDatasource] 로 세션을 생성한다.
/// 백엔드 연동(Phase 7) 시 데모 경로를 실제 remote datasource 호출로 전환한다.
class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl({
    required NaverAuthDatasource naverDatasource,
    required DemoAuthRemoteDatasource demoRemoteDatasource,
    required AuthLocalDatasource localDatasource,
  })  : _naverDatasource = naverDatasource,
        _demoRemoteDatasource = demoRemoteDatasource,
        _localDatasource = localDatasource;

  final NaverAuthDatasource _naverDatasource;
  final DemoAuthRemoteDatasource _demoRemoteDatasource;
  final AuthLocalDatasource _localDatasource;

  @override
  Future<AuthSession> loginWithNaver() async {
    final account = await _naverDatasource.login();
    final response = await _demoRemoteDatasource.createSession(account);
    await _localDatasource.saveTokens(response.token);
    return response.toEntity();
  }

  @override
  Future<AuthSession?> restoreSession() async {
    final token = await _localDatasource.readTokens();
    if (token == null) return null;

    final tokens = token.toEntity();
    if (tokens.isExpired) {
      await _localDatasource.clear();
      return null;
    }

    // 데모 단계에서는 프로필을 영속화하지 않으므로 저장된 토큰만으로 세션을 복원한다.
    // 백엔드 연동 시 저장 토큰으로 사용자 정보를 조회하도록 전환한다.
    return AuthSession(user: _restoredDemoUser, tokens: tokens);
  }

  @override
  Future<void> logout() async {
    await _localDatasource.clear();
  }

  @override
  Future<void> withdraw() async {
    await _localDatasource.clear();
    await _naverDatasource.logoutAndDeleteToken();
  }

  @override
  Future<AuthTokens> refreshTokens() async {
    // Phase 7 백엔드 연동 시 실제 토큰 갱신을 구현한다.
    throw AuthException.unauthenticated('토큰 갱신은 아직 지원되지 않습니다.');
  }

  static const User _restoredDemoUser = User(
    id: 'demo-user',
    nickname: '네이버 사용자',
    provider: SocialProvider.naver,
  );
}
