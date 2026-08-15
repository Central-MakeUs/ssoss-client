import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:ssoss_flutter/features/content/data/models/generation_channel_result_model.dart';

part 'content_save_request.freezed.dart';
part 'content_save_request.g.dart';

@freezed
abstract class ContentSaveRequest with _$ContentSaveRequest {
  const ContentSaveRequest._();

  @JsonSerializable(explicitToJson: true)
  const factory ContentSaveRequest({
    required int generationId,
    required List<GenerationChannelResultModel> contents,
  }) = _ContentSaveRequest;

  factory ContentSaveRequest.fromJson(Map<String, dynamic> json) =>
      _$ContentSaveRequestFromJson(json);

  /// POST `/v1/contents` 본문. 채널별 title omit 규칙을 반영한다.
  Map<String, dynamic> toApiJson() => {
        'generationId': generationId,
        'contents': [
          for (final item in contents) item.toSaveJson(),
        ],
      };
}
