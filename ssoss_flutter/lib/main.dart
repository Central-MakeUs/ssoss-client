import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'ssoss_app.dart';
import 'core/config/app_config.dart';
import 'core/config/env_loader.dart';
import 'core/config/flavor_reader.dart';
import 'core/service/secure_storage_service.dart';
import 'core/service/shared_preferences_service.dart';

const _isFirstAppLaunchKey = 'is_first_app_launch';

/// iOS는 앱 삭제 후에도 Keychain(secure storage)이 남을 수 있다.
/// SharedPreferences flag가 없거나 false면 재설치로 보고 secure storage를 비운다.
Future<void> _prepareSecureStorageForLaunch() async {
  final preferences = SharedPreferencesService();
  final hasLaunched = await preferences.readBool(_isFirstAppLaunchKey);
  if (!hasLaunched) {
    await SecureStorageService().deleteAll();
  }
  await preferences.writeBool(_isFirstAppLaunchKey, true);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await _prepareSecureStorageForLaunch();
  final flavor = await FlavorReader.current();
  await EnvLoader.load(flavor);
  AppConfig.init(flavor);
  runApp(const SsossAppScope());
}
