import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/config/app_config.dart';
import 'core/network/api_environment.dart';
import 'core/network/network_providers.dart';

class SsossApp extends StatelessWidget {
  const SsossApp({super.key});

  @override
  Widget build(BuildContext context) {
    final config = AppConfig.instance;
    final apiEnvironment = context.watch<ApiEnvironment>();

    return MaterialApp(
      title: config.flavor.displayName,
      home: Scaffold(
        body: Center(
          child: Text(
            '${config.flavor.displayName} (${config.flavor.name})\n'
            '${apiEnvironment.baseUrl}',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class SsossAppScope extends StatelessWidget {
  const SsossAppScope({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: NetworkProviders.build(),
      child: const SsossApp(),
    );
  }
}
