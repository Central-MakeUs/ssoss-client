import 'package:freezed_annotation/freezed_annotation.dart';

part 'generation_start_response.freezed.dart';
part 'generation_start_response.g.dart';

@freezed
abstract class GenerationStartResponse with _$GenerationStartResponse {
  const factory GenerationStartResponse({
    required int generationId,
  }) = _GenerationStartResponse;

  factory GenerationStartResponse.fromJson(Map<String, dynamic> json) =>
      _$GenerationStartResponseFromJson(json);
}
