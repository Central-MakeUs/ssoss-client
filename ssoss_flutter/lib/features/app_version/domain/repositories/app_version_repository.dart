import 'package:ssoss_flutter/features/app_version/domain/entities/app_version_check.dart';

/// 앱 버전 조회 repository 계약.
abstract class AppVersionRepository {
  /// 현재 설치된 OS·버전으로 최소 지원 여부를 조회한다.
  Future<AppVersionCheck> checkCurrentVersion();
}
