import 'package:dio/dio.dart';

import 'package:ssoss_flutter/core/network/dio_error_mapper.dart';

import '../models/auth_token_model.dart';
import '../models/signup_request_model.dart';
import '../models/social_login_request.dart';
import '../models/social_login_response_model.dart';
import 'auth_remote_datasource.dart';

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  AuthRemoteDatasourceImpl({
    required Dio dio,
    required Dio unauthenticatedDio,
  })  : _dio = dio,
        _unauthenticatedDio = unauthenticatedDio;

  final Dio _dio;

  /// AuthInterceptor(QueuedInterceptor) 를 타지 않는 Dio.
  /// refresh 가 메인 Dio 에러 큐와 데드락 나지 않도록 분리한다.
  final Dio _unauthenticatedDio;

  static const _socialLoginPath = '/v1/social-logins';
  static const _tokensPath = '/v1/tokens';
  static const _logoutPath = '/v1/logout';
  static const _recoveryPath = '/v1/members/me/recovery';
  static const _membersMePath = '/v1/members/me';
  static const _signupPath = '/v1/signup';

  @override
  Future<SocialLoginResponseModel> socialLogin({
    required String provider,
    required SocialLoginRequest request,
  }) async {
    try {
      final response = await _unauthenticatedDio.post<Map<String, dynamic>>(
        '$_socialLoginPath/${provider.toLowerCase()}',
        data: request.toJson(),
      );
      return SocialLoginResponseModel.fromJson(response.data!);
    } on DioException catch (e) {
      throw mapDioError(e);
    }
  }

  @override
  Future<AuthTokenModel> refresh(String refreshToken) async {
    try {
      final response = await _unauthenticatedDio.post<Map<String, dynamic>>(
        _tokensPath,
        data: {'refreshToken': refreshToken},
      );
      return AuthTokenModel.fromJson(response.data!);
    } on DioException catch (e) {
      throw mapDioError(e);
    }
  }

  @override
  Future<void> logout(String refreshToken) async {
    try {
      await _unauthenticatedDio.post<void>(
        _logoutPath,
        data: {'refreshToken': refreshToken},
        options: Options(
          validateStatus: (status) =>
              status != null && status >= 200 && status < 300,
        ),
      );
    } on DioException catch (e) {
      throw mapDioError(e);
    }
  }

  @override
  Future<SocialLoginResponseModel> recover() async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        _recoveryPath,
      );
      return SocialLoginResponseModel.fromJson(response.data!);
    } on DioException catch (e) {
      throw mapDioError(e);
    }
  }

  @override
  Future<void> withdraw() async {
    try {
      await _dio.delete<void>(
        _membersMePath,
        options: Options(
          validateStatus: (status) =>
              status != null && status >= 200 && status < 300,
        ),
      );
    } on DioException catch (e) {
      throw mapDioError(e);
    }
  }

  @override
  Future<SocialLoginResponseModel> signup(SignupRequestModel request) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        _signupPath,
        data: request.toJson(),
      );
      return SocialLoginResponseModel.fromJson(response.data!);
    } on DioException catch (e) {
      throw mapDioError(e);
    }
  }
}
