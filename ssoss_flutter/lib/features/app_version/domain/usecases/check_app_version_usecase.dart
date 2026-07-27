import 'package:ssoss_flutter/features/app_version/domain/entities/app_version_check.dart';
import 'package:ssoss_flutter/features/app_version/domain/repositories/app_version_repository.dart';

class CheckAppVersionUseCase {
  CheckAppVersionUseCase(this._repository);

  final AppVersionRepository _repository;

  Future<AppVersionCheck> call() => _repository.checkCurrentVersion();
}
