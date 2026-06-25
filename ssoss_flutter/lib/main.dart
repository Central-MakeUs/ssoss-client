import 'package:flutter/material.dart';

import 'ssoss_app.dart';
import 'core/config/app_config.dart';
import 'core/config/env_loader.dart';
import 'core/config/flavor_reader.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final flavor = await FlavorReader.current();
  await EnvLoader.load(flavor);
  AppConfig.init(flavor);
  runApp(const SsossAppScope());
}
