import 'package:ssoss_flutter/features/app_version/data/datasources/app_info_datasource.dart';
import 'package:ssoss_flutter/features/app_version/data/datasources/app_version_remote_datasource.dart';
import 'package:ssoss_flutter/features/app_version/data/models/app_version_response_model.dart';
import 'package:ssoss_flutter/features/app_version/domain/entities/app_version_check.dart';
import 'package:ssoss_flutter/features/app_version/domain/repositories/app_version_repository.dart';

class AppVersionRepositoryImpl implements AppVersionRepository {
  AppVersionRepositoryImpl({
    required AppInfoDatasource appInfoDatasource,
    required AppVersionRemoteDatasource remoteDatasource,
  })  : _appInfo = appInfoDatasource,
        _remote = remoteDatasource;

  final AppInfoDatasource _appInfo;
  final AppVersionRemoteDatasource _remote;

  @override
  Future<AppVersionCheck> checkCurrentVersion() async {
    final version = await _appInfo.currentVersion();
    final model = await _remote.checkVersion(
      os: _appInfo.os,
      version: version,
    );
    return model.toEntity();
  }
}
