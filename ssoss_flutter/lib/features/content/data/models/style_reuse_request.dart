import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:ssoss_flutter/features/content/domain/entities/style_reuse_input.dart';

part 'style_reuse_request.freezed.dart';
part 'style_reuse_request.g.dart';

@freezed
abstract class StyleReuseRequest with _$StyleReuseRequest {
  const factory StyleReuseRequest({
    required String emphasis,
    required List<String> keywords,
    required bool photoGuideChecked,
    String? forbidden,
  }) = _StyleReuseRequest;

  factory StyleReuseRequest.fromEntity(StyleReuseInput input) {
    return StyleReuseRequest(
      emphasis: input.highlight,
      forbidden: input.forbidden,
      keywords: input.keywords,
      photoGuideChecked: input.photoGuideEnabled,
    );
  }

  factory StyleReuseRequest.fromJson(Map<String, dynamic> json) =>
      _$StyleReuseRequestFromJson(json);
}
