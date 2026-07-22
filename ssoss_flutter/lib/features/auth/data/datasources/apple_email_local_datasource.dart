import 'package:ssoss_flutter/core/service/shared_preferences_service.dart';

/// Apple 로그인 시 최초에만 제공되는 이메일을 로컬에 보관한다.
abstract class AppleEmailLocalDatasource {
  Future<void> saveEmail({
    required String userIdentifier,
    required String email,
  });

  Future<String?> readEmail(String userIdentifier);
}

class AppleEmailLocalDatasourceImpl implements AppleEmailLocalDatasource {
  const AppleEmailLocalDatasourceImpl(this._preferences);

  final SharedPreferencesService _preferences;

  static String _key(String userIdentifier) => 'apple_email_$userIdentifier';

  @override
  Future<void> saveEmail({
    required String userIdentifier,
    required String email,
  }) {
    return _preferences.writeString(_key(userIdentifier), email);
  }

  @override
  Future<String?> readEmail(String userIdentifier) {
    return _preferences.readString(_key(userIdentifier));
  }
}
