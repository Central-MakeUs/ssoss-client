import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:ssoss_flutter/features/content/data/mappers/content_create_api_mapper.dart';
import 'package:ssoss_flutter/features/content/domain/entities/content_create_input.dart';

part 'generation_start_request.freezed.dart';
part 'generation_start_request.g.dart';

@freezed
abstract class GenerationStartRequest with _$GenerationStartRequest {
  const factory GenerationStartRequest({
    required List<String> channels,
    required String purpose,
    required String tone,
    required String emphasis,
    required List<String> keywords,
    required bool photoGuideChecked,
    String? forbidden,
    int? sourceContentId,
  }) = _GenerationStartRequest;

  factory GenerationStartRequest.fromEntity(ContentCreateInput input) {
    final sourceId = input.sourceContentId;
    return GenerationStartRequest(
      channels: ContentCreateApiMapper.channels(input.channels),
      purpose: ContentCreateApiMapper.purpose(input.purpose),
      tone: ContentCreateApiMapper.tone(input.tone),
      emphasis: input.highlight,
      forbidden: input.forbidden,
      keywords: input.keywords,
      photoGuideChecked: input.photoGuideEnabled,
      sourceContentId: sourceId == null ? null : int.tryParse(sourceId),
    );
  }

  factory GenerationStartRequest.fromJson(Map<String, dynamic> json) =>
      _$GenerationStartRequestFromJson(json);
}
