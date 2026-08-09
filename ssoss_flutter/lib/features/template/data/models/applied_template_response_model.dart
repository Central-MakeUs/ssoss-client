import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:ssoss_flutter/features/template/domain/entities/applied_template.dart';

part 'applied_template_response_model.freezed.dart';
part 'applied_template_response_model.g.dart';

@freezed
abstract class AppliedTemplateResponseModel
    with _$AppliedTemplateResponseModel {
  const factory AppliedTemplateResponseModel({
    required int id,
    required String body,
  }) = _AppliedTemplateResponseModel;

  factory AppliedTemplateResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AppliedTemplateResponseModelFromJson(json);
}

extension AppliedTemplateResponseModelX on AppliedTemplateResponseModel {
  AppliedTemplate toEntity() => AppliedTemplate(
        id: id,
        body: body,
      );
}
