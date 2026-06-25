enum AppFlavor {
  dev,
  staging,
  prod;

  String get name => switch (this) {
        AppFlavor.dev => 'dev',
        AppFlavor.staging => 'staging',
        AppFlavor.prod => 'prod',
      };

  String get displayName => switch (this) {
        AppFlavor.dev => '쏘쓰(dev)',
        AppFlavor.staging => '쏘쓰(staging)',
        AppFlavor.prod => '쏘쓰',
      };

  static AppFlavor fromPackageName(String packageName) {
    if (packageName.endsWith('.dev')) return AppFlavor.dev;
    if (packageName.endsWith('.staging')) return AppFlavor.staging;
    return AppFlavor.prod;
  }
}
