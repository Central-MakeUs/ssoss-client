import 'package:dio/dio.dart';

import 'package:ssoss_flutter/core/exception/api_error_code.dart';
import 'package:ssoss_flutter/core/exception/app_exception.dart';
import 'package:ssoss_flutter/core/network/error_response.dart';

/// [DioException] 을 앱 공통 [AppException] 으로 변환한다.
AppException mapDioError(DioException exception) {
  if (exception.type == DioExceptionType.cancel ||
      CancelToken.isCancel(exception)) {
    return const CancelledException();
  }

  if (exception.type == DioExceptionType.connectionTimeout ||
      exception.type == DioExceptionType.receiveTimeout ||
      exception.type == DioExceptionType.sendTimeout ||
      exception.type == DioExceptionType.connectionError) {
    return const NetworkException();
  }

  final statusCode = exception.response?.statusCode ?? 0;
  final error = _parseErrorResponse(exception.response?.data);
  final code = ApiErrorCode.parse(error?.code);
  final message = (error?.message.isNotEmpty ?? false)
      ? error!.message
      : (exception.message ?? '서버 오류가 발생했습니다.');

  return switch (code.value) {
    'C0001' => ValidationException(message),
    'A0001' => AuthException.socialFailed(message),
    'A0004' || 'A0005' => AuthException.unauthenticated(message),
    _ => ServerException(
          statusCode,
          message,
          code.value.isEmpty ? null : code.value,
        ),
  };
}

ErrorResponse? _parseErrorResponse(dynamic data) {
  if (data is! Map) return null;
  final map = Map<String, dynamic>.from(data);
  if (!map.containsKey('code') && !map.containsKey('message')) {
    return null;
  }
  return ErrorResponse.fromJson(map);
}
