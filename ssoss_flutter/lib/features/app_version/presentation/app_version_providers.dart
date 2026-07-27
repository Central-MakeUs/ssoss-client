import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'package:ssoss_flutter/features/app_version/data/datasources/app_info_datasource.dart';
import 'package:ssoss_flutter/features/app_version/data/datasources/app_version_remote_datasource.dart';
import 'package:ssoss_flutter/features/app_version/data/repositories/app_version_repository_impl.dart';
import 'package:ssoss_flutter/features/app_version/domain/repositories/app_version_repository.dart';
import 'package:ssoss_flutter/features/app_version/domain/usecases/check_app_version_usecase.dart';

/// app_version 피처 전용 provider 묶음.
///
/// `SsossAppScope` 의 `MultiProvider` 에 추가한다.
class AppVersionProviders {
  AppVersionProviders._();

  static List<SingleChildWidget> build() => [
        Provider<AppInfoDatasource>(
          create: (_) => const AppInfoDatasource(),
        ),
        ProxyProvider<Dio, AppVersionRemoteDatasource>(
          update: (_, dio, __) => AppVersionRemoteDatasourceImpl(dio),
        ),
        ProxyProvider2<AppInfoDatasource, AppVersionRemoteDatasource,
            AppVersionRepository>(
          update: (_, appInfo, remote, __) => AppVersionRepositoryImpl(
            appInfoDatasource: appInfo,
            remoteDatasource: remote,
          ),
        ),
        ProxyProvider<AppVersionRepository, CheckAppVersionUseCase>(
          update: (_, repository, __) => CheckAppVersionUseCase(repository),
        ),
      ];
}
