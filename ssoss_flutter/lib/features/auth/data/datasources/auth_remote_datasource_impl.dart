import 'package:dio/dio.dart';

import 'package:ssoss_flutter/core/network/auth_request_extra.dart';
import 'package:ssoss_flutter/core/network/dio_error_mapper.dart';

import '../models/auth_token_model.dart';
import '../models/social_login_request.dart';
import 'auth_remote_datasource.dart';

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  AuthRemoteDatasourceImpl(this._dio);

  final Dio _dio;

  static const _socialLoginPath = '/v1/social-logins';
  static const _tokensPath = '/v1/tokens';
  static const _logoutPath = '/v1/logout';

  @override
  Future<AuthTokenModel> socialLogin({
    required String provider,
    required SocialLoginRequest request,
  }) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        '$_socialLoginPath/${provider.toLowerCase()}',
        data: request.toJson(),
        options: Options(
          extra: const {AuthRequestExtra.skipAuth: true},
        ),
      );
      return AuthTokenModel.fromJson(response.data!);
    } on DioException catch (e) {
      throw mapDioError(e);
    }
  }

  @override
  Future<AuthTokenModel> refresh(String refreshToken) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        _tokensPath,
        data: {'refreshToken': refreshToken},
        options: Options(
          extra: const {AuthRequestExtra.skipAuth: true},
        ),
      );
      return AuthTokenModel.fromJson(response.data!);
    } on DioException catch (e) {
      throw mapDioError(e);
    }
  }

  @override
  Future<void> logout(String refreshToken) async {
    try {
      await _dio.post<void>(
        _logoutPath,
        data: {'refreshToken': refreshToken},
        options: Options(
          extra: const {AuthRequestExtra.skipAuth: true},
          validateStatus: (status) =>
              status != null && status >= 200 && status < 300,
        ),
      );
    } on DioException catch (e) {
      throw mapDioError(e);
    }
  }

  @override
  Future<void> withdraw() async {
    // Phase 8 — 서버 탈퇴 API 연동 후 구현.
    throw UnimplementedError('Withdraw API is Phase 8');
  }
}
