import 'package:dio/dio.dart';

import 'package:ssoss_flutter/core/exception/app_exception.dart';
import 'package:ssoss_flutter/core/network/auth_request_extra.dart';
import 'package:ssoss_flutter/core/network/session_expired_notifier.dart';
import 'package:ssoss_flutter/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:ssoss_flutter/features/auth/data/datasources/auth_remote_datasource.dart';

/// Bearer 주입 + 401 시 refresh 단일 flight 후 원요청 재시도.
class AuthInterceptor extends QueuedInterceptor {
  AuthInterceptor({
    required Dio dio,
    required AuthLocalDatasource localDatasource,
    required AuthRemoteDatasource remoteDatasource,
    required SessionExpiredNotifier sessionExpiredNotifier,
  })  : _dio = dio,
        _local = localDatasource,
        _remote = remoteDatasource,
        _sessionExpiredNotifier = sessionExpiredNotifier;

  final Dio _dio;
  final AuthLocalDatasource _local;
  final AuthRemoteDatasource _remote;
  final SessionExpiredNotifier _sessionExpiredNotifier;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (options.extra[AuthRequestExtra.skipAuth] == true) {
      handler.next(options);
      return;
    }

    final cache = await _local.readSession();
    final accessToken = cache?.token.accessToken;
    if (accessToken != null && accessToken.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final status = err.response?.statusCode;
    final alreadyRetried =
        err.requestOptions.extra[AuthRequestExtra.authRetried] == true;
    final skipAuth =
        err.requestOptions.extra[AuthRequestExtra.skipAuth] == true;

    if (status != 401 || alreadyRetried || skipAuth) {
      handler.next(err);
      return;
    }

    try {
      final cache = await _local.readSession();
      final refreshToken = cache?.token.refreshToken;
      if (refreshToken == null || refreshToken.isEmpty) {
        await _expireSession();
        handler.next(err);
        return;
      }

      final newTokens = await _remote.refresh(refreshToken);
      await _local.updateTokens(newTokens);

      final request = err.requestOptions;
      request.headers['Authorization'] = 'Bearer ${newTokens.accessToken}';
      request.extra[AuthRequestExtra.authRetried] = true;

      final response = await _dio.fetch<dynamic>(request);
      handler.resolve(response);
    } on AuthException catch (_) {
      await _expireSession();
      handler.next(err);
    } catch (_) {
      await _expireSession();
      handler.next(err);
    }
  }

  Future<void> _expireSession() async {
    await _local.clear();
    _sessionExpiredNotifier.notify();
  }
}
