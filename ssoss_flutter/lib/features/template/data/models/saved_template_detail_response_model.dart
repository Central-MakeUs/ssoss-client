import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:ssoss_flutter/features/template/data/mappers/template_api_mapper.dart';
import 'package:ssoss_flutter/features/template/domain/entities/saved_template_detail.dart';

part 'saved_template_detail_response_model.freezed.dart';
part 'saved_template_detail_response_model.g.dart';

@freezed
abstract class SavedTemplateDetailResponseModel
    with _$SavedTemplateDetailResponseModel {
  const factory SavedTemplateDetailResponseModel({
    required int savedTemplateId,
    required String category,
    required String title,
    required String description,
    required String body,
    required String savedAt,
    @Default(<String>[]) List<String> recommendedChannels,
  }) = _SavedTemplateDetailResponseModel;

  factory SavedTemplateDetailResponseModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$SavedTemplateDetailResponseModelFromJson(json);
}

extension SavedTemplateDetailResponseModelX
    on SavedTemplateDetailResponseModel {
  SavedTemplateDetail toEntity() => SavedTemplateDetail(
        savedTemplateId: savedTemplateId,
        category: TemplateApiMapper.categoryFromApi(category),
        title: title,
        description: description,
        body: body,
        recommendedChannels: recommendedChannels,
        savedAt: DateTime.parse(savedAt).toLocal(),
      );
}
