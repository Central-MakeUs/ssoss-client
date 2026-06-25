import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'app_flavor.dart';

class EnvLoader {
  EnvLoader._();

  static const apiBaseUrlKey = 'API_BASE_URL';

  /// Flavor에 맞는 env 파일을 로드합니다.
  static Future<void> load(AppFlavor flavor) async {
    await dotenv.load(fileName: 'env/.env.${flavor.name}');
  }

  static String require(String key) {
    final value = dotenv.env[key];
    if (value == null || value.isEmpty) {
      throw StateError('$key is not set in env file');
    }
    return value;
  }
}
