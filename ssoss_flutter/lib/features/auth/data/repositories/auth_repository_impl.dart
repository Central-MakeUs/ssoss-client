import 'package:ssoss_flutter/core/exception/app_exception.dart';

import '../../domain/entities/auth_session.dart';
import '../../domain/entities/auth_tokens.dart';
import '../../domain/entities/member_status.dart';
import '../../domain/entities/signup_agreement.dart';
import '../../domain/entities/social_provider.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/apple_auth_datasource.dart';
import '../datasources/apple_email_local_datasource.dart';
import '../datasources/auth_local_datasource.dart';
import '../datasources/auth_remote_datasource.dart';
import '../datasources/naver_auth_datasource.dart';
import '../models/auth_token_model.dart';
import '../models/signup_request_model.dart';
import '../models/social_login_request.dart';
import '../models/social_login_response_model.dart';
import '../models/stored_auth_cache_model.dart';

/// [AuthRepository] 실서버 연동 구현체.
class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl({
    required NaverAuthDatasource naverDatasource,
    required AppleAuthDatasource appleDatasource,
    required AppleEmailLocalDatasource appleEmailLocalDatasource,
    required AuthRemoteDatasource remoteDatasource,
    required AuthLocalDatasource localDatasource,
  })  : _naverDatasource = naverDatasource,
        _appleDatasource = appleDatasource,
        _appleEmailLocalDatasource = appleEmailLocalDatasource,
        _remoteDatasource = remoteDatasource,
        _localDatasource = localDatasource;

  final NaverAuthDatasource _naverDatasource;
  final AppleAuthDatasource _appleDatasource;
  final AppleEmailLocalDatasource _appleEmailLocalDatasource;
  final AuthRemoteDatasource _remoteDatasource;
  final AuthLocalDatasource _localDatasource;

  @override
  Future<AuthSession> loginWithNaver() async {
    final account = await _naverDatasource.login();
    final loginResponse = await _remoteDatasource.socialLogin(
      provider: 'naver',
      request: SocialLoginRequest(accessToken: account.accessToken),
    );
    final resolved = await _resolveLoginResponse(loginResponse);
    final session = AuthSession(
      user: User(
        id: account.id,
        nickname: account.nickname,
        email: account.email,
        provider: SocialProvider.naver,
      ),
      tokens: resolved.token.toEntity(),
      memberStatus: resolved.memberStatus,
    );
    await _saveSession(
      token: resolved.token,
      provider: 'naver',
      session: session,
      memberStatus: resolved.memberStatus,
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

    final email = await _resolveAppleEmail(
      userIdentifier: account.userIdentifier,
      email: account.email,
    );

    final loginResponse = await _remoteDatasource.socialLogin(
      provider: 'apple',
      request: SocialLoginRequest(accessToken: identityToken),
    );
    final resolved = await _resolveLoginResponse(loginResponse);
    final session = AuthSession(
      user: User(
        id: account.userIdentifier,
        nickname: account.nickname,
        email: email,
        provider: SocialProvider.apple,
      ),
      tokens: resolved.token.toEntity(),
      memberStatus: resolved.memberStatus,
    );
    await _saveSession(
      token: resolved.token,
      provider: 'apple',
      session: session,
      memberStatus: resolved.memberStatus,
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
    await _remoteDatasource.withdraw();
    final cache = await _localDatasource.readSession();
    await _localDatasource.clear();
    if (cache?.provider == 'naver') {
      await _naverDatasource.logout();
    }
  }

  @override
  Future<AuthSession> signup(SignupAgreement agreement) async {
    final response = await _remoteDatasource.signup(
      SignupRequestModel(
        serviceTermsAgreed: agreement.serviceTermsAgreed,
        privacyPolicyAgreed: agreement.privacyPolicyAgreed,
        marketingAgreed: agreement.marketingAgreed,
      ),
    );
    final token = response.toTokenModel();
    final cache = await _localDatasource.readSession();
    if (cache == null) {
      throw AuthException.unauthenticated();
    }

    final session = AuthSession(
      user: User(
        id: cache.userId,
        nickname: cache.nickname,
        email: cache.email,
        provider: cache.provider == 'apple'
            ? SocialProvider.apple
            : SocialProvider.naver,
      ),
      tokens: token.toEntity(),
      memberStatus: MemberStatus.active,
    );

    await _saveSession(
      token: token,
      provider: cache.provider,
      session: session,
      memberStatus: MemberStatus.active,
    );
    return session;
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

  Future<String?> _resolveAppleEmail({
    required String userIdentifier,
    required String? email,
  }) async {
    if (email != null && email.isNotEmpty) {
      await _appleEmailLocalDatasource.saveEmail(
        userIdentifier: userIdentifier,
        email: email,
      );
      return email;
    }
    return _appleEmailLocalDatasource.readEmail(userIdentifier);
  }

  Future<({AuthTokenModel token, MemberStatus memberStatus})>
      _resolveLoginResponse(
    SocialLoginResponseModel loginResponse,
  ) async {
    if (loginResponse.status == MemberStatus.withdrawn) {
      final token = await _recoverWithdrawnToken(loginResponse);
      return (token: token, memberStatus: MemberStatus.active);
    }

    return (
      token: loginResponse.toTokenModel(),
      memberStatus: loginResponse.status,
    );
  }

  /// WITHDRAWN 이면 복구 API로 ACTIVE 토큰을 발급받는다.
  Future<AuthTokenModel> _recoverWithdrawnToken(
    SocialLoginResponseModel loginResponse,
  ) async {
    await _localDatasource.saveSession(
      StoredAuthCacheModel(
        token: loginResponse.toTokenModel(),
        provider: 'pending_recovery',
        userId: '',
        nickname: '',
        memberStatus: MemberStatus.withdrawn,
      ),
    );

    try {
      final recovered = await _remoteDatasource.recover();
      return recovered.toTokenModel();
    } catch (_) {
      await _localDatasource.clear();
      rethrow;
    }
  }

  Future<void> _saveSession({
    required AuthTokenModel token,
    required String provider,
    required AuthSession session,
    required MemberStatus memberStatus,
  }) async {
    await _localDatasource.saveSession(
      StoredAuthCacheModel(
        token: token,
        provider: provider,
        userId: session.user.id,
        nickname: session.user.nickname,
        email: session.user.email,
        memberStatus: memberStatus,
      ),
    );
  }
}
