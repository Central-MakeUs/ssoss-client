import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:ssoss_flutter/features/template/domain/entities/saved_template.dart';

part 'saved_template_save_response_model.freezed.dart';
part 'saved_template_save_response_model.g.dart';

@freezed
abstract class SavedTemplateSaveResponseModel
    with _$SavedTemplateSaveResponseModel {
  const factory SavedTemplateSaveResponseModel({
    required int savedTemplateId,
  }) = _SavedTemplateSaveResponseModel;

  factory SavedTemplateSaveResponseModel.fromJson(Map<String, dynamic> json) =>
      _$SavedTemplateSaveResponseModelFromJson(json);
}

extension SavedTemplateSaveResponseModelX on SavedTemplateSaveResponseModel {
  SavedTemplate toEntity() => SavedTemplate(savedTemplateId: savedTemplateId);
}
