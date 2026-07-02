import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'package:ssoss_flutter/core/service/secure_storage_service.dart';

import '../data/datasources/auth_local_datasource.dart';
import '../data/datasources/auth_local_datasource_impl.dart';
import '../data/datasources/demo_auth_remote_datasource.dart';
import '../data/datasources/naver_auth_datasource.dart';
import '../data/datasources/naver_auth_datasource_impl.dart';
import '../data/repositories/auth_repository_impl.dart';
import '../domain/repositories/auth_repository.dart';

/// auth 피처 전용 provider 묶음.
///
/// `SsossAppScope` 의 `MultiProvider` 에 추가한다.
/// 데모 단계이므로 [DemoAuthRemoteDatasource] 로 세션을 생성한다(백엔드 연동은 Phase 7).
class AuthProviders {
  AuthProviders._();

  static List<SingleChildWidget> build() => [
        Provider<NaverAuthDatasource>(
          create: (_) => const NaverAuthDatasourceImpl(),
        ),
        Provider<DemoAuthRemoteDatasource>(
          create: (_) => const DemoAuthRemoteDatasource(),
        ),
        Provider<AuthLocalDatasource>(
          create: (_) => AuthLocalDatasourceImpl(SecureStorageService()),
        ),
        ProxyProvider3<NaverAuthDatasource, DemoAuthRemoteDatasource,
            AuthLocalDatasource, AuthRepository>(
          update: (_, naver, demoRemote, local, __) => AuthRepositoryImpl(
            naverDatasource: naver,
            demoRemoteDatasource: demoRemote,
            localDatasource: local,
          ),
        ),
      ];
}
