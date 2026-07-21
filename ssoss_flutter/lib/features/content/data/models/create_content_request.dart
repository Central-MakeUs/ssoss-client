import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:ssoss_flutter/features/content/data/mappers/content_create_api_mapper.dart';
import 'package:ssoss_flutter/features/content/domain/entities/content_create_input.dart';

part 'create_content_request.freezed.dart';
part 'create_content_request.g.dart';

@freezed
abstract class CreateContentRequest with _$CreateContentRequest {
  const factory CreateContentRequest({
    required List<String> channels,
    required String purpose,
    required String tone,
    required String highlight,
    required List<String> keywords,
    required bool photoGuideEnabled,
    String? forbidden,
  }) = _CreateContentRequest;

  factory CreateContentRequest.fromEntity(ContentCreateInput input) =>
      CreateContentRequest(
        channels: ContentCreateApiMapper.channels(input.channels),
        purpose: ContentCreateApiMapper.purpose(input.purpose),
        tone: ContentCreateApiMapper.tone(input.tone),
        highlight: input.highlight,
        forbidden: input.forbidden,
        keywords: input.keywords,
        photoGuideEnabled: input.photoGuideEnabled,
      );

  factory CreateContentRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateContentRequestFromJson(json);
}
