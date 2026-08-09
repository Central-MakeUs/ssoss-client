import 'package:dio/dio.dart';

import 'package:ssoss_flutter/core/exception/app_exception.dart';
import 'package:ssoss_flutter/core/network/auth_request_extra.dart';
import 'package:ssoss_flutter/core/network/dio_error_mapper.dart';
import 'package:ssoss_flutter/core/network/network_error_notifier.dart';

/// 연결 실패·타임아웃 시 전역 네트워크 토스트를 띄운다.
class NetworkErrorInterceptor extends Interceptor {
  NetworkErrorInterceptor(this._notifier);

  final NetworkErrorNotifier _notifier;

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    try {
      final skip =
          err.requestOptions.extra[AuthRequestExtra.skipNetworkToast] == true;
      if (!skip && mapDioError(err) is NetworkException) {
        _notifier.notify();
      }
    } catch (_) {
      // 토스트 실패가 원본 API 에러 전달을 막지 않게 한다.
    }
    handler.next(err);
  }
}
