import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../config/app_config.dart';
import 'api_environment.dart';
import 'dio_factory.dart';

class NetworkProviders {
  NetworkProviders._();

  static List<SingleChildWidget> build() {
    final environment =
        ApiEnvironment.fromFlavor(AppConfig.instance.flavor);

    return [
      Provider<ApiEnvironment>.value(value: environment),
      Provider<Dio>(
        create: (_) => DioFactory.create(environment),
        dispose: (_, dio) => dio.close(),
      ),
    ];
  }
}
