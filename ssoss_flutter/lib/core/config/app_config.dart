import 'app_flavor.dart';

class AppConfig {
  AppConfig._({required this.flavor});

  static late final AppConfig instance;

  final AppFlavor flavor;

  static void init(AppFlavor flavor) {
    instance = AppConfig._(flavor: flavor);
  }
}
