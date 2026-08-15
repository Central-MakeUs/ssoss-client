import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../config/app_config.dart';
import 'api_environment.dart';
import 'dio_factory.dart';
import 'interceptors/network_error_interceptor.dart';
import 'network_error_notifier.dart';
import 'unauthenticated_dio.dart';

class NetworkProviders {
  NetworkProviders._();

  static List<SingleChildWidget> build() {
    final environment =
        ApiEnvironment.fromFlavor(AppConfig.instance.flavor);

    return [
      Provider<ApiEnvironment>.value(value: environment),
      Provider<NetworkErrorNotifier>(
        create: (_) => NetworkErrorNotifier(),
      ),
      Provider<Dio>(
        create: (context) {
          final dio = DioFactory.create(environment);
          dio.interceptors.add(
            NetworkErrorInterceptor(context.read<NetworkErrorNotifier>()),
          );
          return dio;
        },
        dispose: (_, dio) => dio.close(),
      ),
      Provider<UnauthenticatedDio>(
        create: (context) {
          final dio = DioFactory.createUnauthenticated(environment);
          dio.interceptors.add(
            NetworkErrorInterceptor(context.read<NetworkErrorNotifier>()),
          );
          return UnauthenticatedDio(dio);
        },
        dispose: (_, dio) => dio.close(),
      ),
    ];
  }
}
