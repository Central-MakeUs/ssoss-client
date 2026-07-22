import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'package:ssoss_flutter/core/network/interceptors/auth_interceptor.dart';
import 'package:ssoss_flutter/core/network/session_expired_notifier.dart';
import 'package:ssoss_flutter/core/service/secure_storage_service.dart';
import 'package:ssoss_flutter/core/service/shared_preferences_service.dart';

import '../data/datasources/apple_auth_datasource.dart';
import '../data/datasources/apple_auth_datasource_impl.dart';
import '../data/datasources/apple_email_local_datasource.dart';
import '../data/datasources/auth_local_datasource.dart';
import '../data/datasources/auth_local_datasource_impl.dart';
import '../data/datasources/auth_remote_datasource.dart';
import '../data/datasources/auth_remote_datasource_impl.dart';
import '../data/datasources/naver_auth_datasource.dart';
import '../data/datasources/naver_auth_datasource_impl.dart';
import '../data/repositories/auth_repository_impl.dart';
import '../domain/repositories/auth_repository.dart';

/// auth 피처 전용 provider 묶음.
class AuthProviders {
  AuthProviders._();

  static List<SingleChildWidget> build() => [
        Provider<SessionExpiredNotifier>(
          create: (_) => SessionExpiredNotifier(),
          dispose: (_, notifier) => notifier.dispose(),
        ),
        Provider<SharedPreferencesService>(
          create: (_) => SharedPreferencesService(),
        ),
        Provider<NaverAuthDatasource>(
          create: (_) => const NaverAuthDatasourceImpl(),
        ),
        Provider<AppleAuthDatasource>(
          create: (_) => const AppleAuthDatasourceImpl(),
        ),
        Provider<AppleEmailLocalDatasource>(
          create: (context) => AppleEmailLocalDatasourceImpl(
            context.read<SharedPreferencesService>(),
          ),
        ),
        Provider<AuthLocalDatasource>(
          create: (_) => AuthLocalDatasourceImpl(SecureStorageService()),
        ),
        ProxyProvider<Dio, AuthRemoteDatasource>(
          update: (_, dio, __) => AuthRemoteDatasourceImpl(dio),
        ),
        ProxyProvider5<
            NaverAuthDatasource,
            AppleAuthDatasource,
            AppleEmailLocalDatasource,
            AuthRemoteDatasource,
            AuthLocalDatasource,
            AuthRepository>(
          update: (context, naver, apple, appleEmail, remote, local, previous) {
            _ensureAuthInterceptor(context);
            return AuthRepositoryImpl(
              naverDatasource: naver,
              appleDatasource: apple,
              appleEmailLocalDatasource: appleEmail,
              remoteDatasource: remote,
              localDatasource: local,
            );
          },
        ),
      ];

  static void _ensureAuthInterceptor(BuildContext context) {
    final dio = context.read<Dio>();
    if (dio.interceptors.any((i) => i is AuthInterceptor)) {
      return;
    }
    dio.interceptors.insert(
      0,
      AuthInterceptor(
        dio: dio,
        localDatasource: context.read<AuthLocalDatasource>(),
        remoteDatasource: context.read<AuthRemoteDatasource>(),
        sessionExpiredNotifier: context.read<SessionExpiredNotifier>(),
      ),
    );
  }
}
