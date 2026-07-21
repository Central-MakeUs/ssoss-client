import 'dart:convert';
import 'dart:developer' as developer;

import 'package:dio/dio.dart';

/// API Request / Response / Error 를 콘솔에 출력하는 Dio 인터셉터.
///
/// Authorization·토큰 필드는 마스킹한다.
class ApiLoggingInterceptor extends Interceptor {
  const ApiLoggingInterceptor({this.enabled = true});

  final bool enabled;

  static const _tag = 'API';

  static const _sensitiveHeaderKeys = {
    'authorization',
    'cookie',
    'set-cookie',
  };

  static const _sensitiveBodyKeys = {
    'accessToken',
    'refreshToken',
    'authorization',
    'password',
    'identityToken',
  };

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    if (enabled) {
      final lines = <String>[
        '┌── API Request ─────────────────────────────',
        '│ ${options.method} ${options.uri}',
        '│ Headers: ${_compact(_sanitizeHeaders(options.headers))}',
      ];
      if (options.queryParameters.isNotEmpty) {
        lines.add(
          '│ Query: ${_compact(options.queryParameters)}',
        );
      }
      if (options.data != null) {
        lines.add('│ Body: ${_compact(_sanitizeData(options.data))}');
      }
      lines.add('└────────────────────────────────────────────');
      _log(lines);
    }
    handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    if (enabled) {
      _log([
        '┌── API Response ────────────────────────────',
        '│ ${response.statusCode} ${response.requestOptions.method} '
            '${response.requestOptions.uri}',
        '│ Body: ${_compact(_sanitizeData(response.data))}',
        '└────────────────────────────────────────────',
      ]);
    }
    handler.next(response);
  }

  @override
  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) {
    if (enabled) {
      final response = err.response;
      final lines = <String>[
        '┌── API Error ───────────────────────────────',
        '│ ${err.requestOptions.method} ${err.requestOptions.uri}',
        '│ Type: ${err.type}',
        '│ Message: ${err.message}',
      ];
      if (response != null) {
        lines
          ..add('│ Status: ${response.statusCode}')
          ..add('│ Body: ${_compact(_sanitizeData(response.data))}');
      }
      lines.add('└────────────────────────────────────────────');
      _log(lines);
    }
    handler.next(err);
  }

  Map<String, dynamic> _sanitizeHeaders(Map<String, dynamic> headers) {
    return {
      for (final entry in headers.entries)
        entry.key: _sensitiveHeaderKeys.contains(entry.key.toLowerCase())
            ? _mask(_headerValue(entry.value))
            : _headerValue(entry.value),
    };
  }

  String _headerValue(dynamic value) {
    if (value is List) {
      return value.map((e) => e.toString()).join(', ');
    }
    return value?.toString() ?? '';
  }

  dynamic _sanitizeData(dynamic data) {
    if (data == null) return null;
    if (data is FormData) {
      return {
        'fields': {
          for (final field in data.fields)
            field.key: _sensitiveBodyKeys.contains(field.key)
                ? _mask(field.value)
                : field.value,
        },
        'files': [for (final file in data.files) file.key],
      };
    }
    if (data is Map) {
      return {
        for (final entry in data.entries)
          entry.key.toString():
              _sensitiveBodyKeys.contains(entry.key.toString())
                  ? _mask(entry.value?.toString())
                  : _sanitizeData(entry.value),
      };
    }
    if (data is List) {
      return [for (final item in data) _sanitizeData(item)];
    }
    if (data is String) {
      try {
        return _sanitizeData(jsonDecode(data));
      } catch (_) {
        return data;
      }
    }
    return data;
  }

  String _mask(String? value) {
    if (value == null || value.isEmpty) return '***';
    if (value.length <= 8) return '***';
    return '${value.substring(0, 4)}…***';
  }

  /// 한 줄로 직렬화해 CLI/IDE 로그가 잘리지 않게 한다.
  String _compact(dynamic value) {
    try {
      if (value is Map || value is List) {
        return jsonEncode(value);
      }
      return value.toString();
    } catch (_) {
      return value.toString();
    }
  }

  void _log(List<String> lines) {
    for (final line in lines) {
      // ignore: avoid_print
      print('[$_tag] $line');
      developer.log(line, name: _tag);
    }
  }
}
