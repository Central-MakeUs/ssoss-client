import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:ssoss_flutter/features/content/domain/entities/create_content_result.dart';

part 'create_content_result_model.freezed.dart';
part 'create_content_result_model.g.dart';

@freezed
abstract class CreateContentResultModel with _$CreateContentResultModel {
  const factory CreateContentResultModel({
    required String contentId,
  }) = _CreateContentResultModel;

  factory CreateContentResultModel.fromJson(Map<String, dynamic> json) =>
      _$CreateContentResultModelFromJson(json);
}

extension CreateContentResultModelX on CreateContentResultModel {
  CreateContentResult toEntity() => CreateContentResult(contentId: contentId);
}
