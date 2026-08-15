import 'dart:io';

import 'package:package_info_plus/package_info_plus.dart';

/// 현재 기기 OS와 앱 버전 정보를 제공한다.
class AppInfoDatasource {
  const AppInfoDatasource();

  /// API path용 OS 값 (`IOS` / `ANDROID`).
  String get os {
    if (Platform.isIOS) {
      return 'IOS';
    }
    return 'ANDROID';
  }

  /// iOS: CFBundleShortVersionString, Android: versionName.
  Future<String> currentVersion() async {
    final info = await PackageInfo.fromPlatform();
    return info.version;
  }
}
