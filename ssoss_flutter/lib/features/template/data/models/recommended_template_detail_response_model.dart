import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:ssoss_flutter/features/template/data/mappers/template_api_mapper.dart';
import 'package:ssoss_flutter/features/template/domain/entities/recommended_template_detail.dart';

part 'recommended_template_detail_response_model.freezed.dart';
part 'recommended_template_detail_response_model.g.dart';

@freezed
abstract class RecommendedTemplateDetailResponseModel
    with _$RecommendedTemplateDetailResponseModel {
  const factory RecommendedTemplateDetailResponseModel({
    required int id,
    required String category,
    required String title,
    required String description,
    required String body,
    required String exampleBody,
    @Default(<String>[]) List<String> recommendedChannels,
    @Default(false) bool bookmarked,
  }) = _RecommendedTemplateDetailResponseModel;

  factory RecommendedTemplateDetailResponseModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$RecommendedTemplateDetailResponseModelFromJson(json);
}

extension RecommendedTemplateDetailResponseModelX
    on RecommendedTemplateDetailResponseModel {
  RecommendedTemplateDetail toEntity() => RecommendedTemplateDetail(
        id: id,
        category: TemplateApiMapper.categoryFromApi(category),
        title: title,
        description: description,
        body: body,
        exampleBody: exampleBody,
        recommendedChannels: recommendedChannels,
        bookmarked: bookmarked,
      );
}
