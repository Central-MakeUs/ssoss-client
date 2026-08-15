import 'package:freezed_annotation/freezed_annotation.dart';

part 'error_response.freezed.dart';
part 'error_response.g.dart';

/// 서버 공통 에러 바디.
@freezed
abstract class ErrorResponse with _$ErrorResponse {
  const factory ErrorResponse({
    required String code,
    required String message,
  }) = _ErrorResponse;

  factory ErrorResponse.fromJson(Map<String, dynamic> json) =>
      _$ErrorResponseFromJson(json);
}
