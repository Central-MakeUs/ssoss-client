import 'package:package_info_plus/package_info_plus.dart';

import 'app_flavor.dart';

class FlavorReader {
  FlavorReader._();

  /// 현재 실행된 앱의 Flavor 정보 반환
  static Future<AppFlavor> current() async {
    final info = await PackageInfo.fromPlatform();
    return AppFlavor.fromPackageName(info.packageName);
  }
}
