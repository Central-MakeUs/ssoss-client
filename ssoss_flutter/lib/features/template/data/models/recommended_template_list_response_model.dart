import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:ssoss_flutter/features/template/data/mappers/template_api_mapper.dart';
import 'package:ssoss_flutter/features/template/domain/entities/recommended_template.dart';
import 'package:ssoss_flutter/features/template/domain/entities/recommended_template_list_page.dart';

part 'recommended_template_list_response_model.freezed.dart';
part 'recommended_template_list_response_model.g.dart';

@freezed
abstract class RecommendedTemplateModel with _$RecommendedTemplateModel {
  const factory RecommendedTemplateModel({
    required int id,
    required String category,
    required String title,
    required String description,
    @Default(<String>[]) List<String> recommendedChannels,
    @Default(false) bool bookmarked,
  }) = _RecommendedTemplateModel;

  factory RecommendedTemplateModel.fromJson(Map<String, dynamic> json) =>
      _$RecommendedTemplateModelFromJson(json);
}

@freezed
abstract class RecommendedTemplateListResponseModel
    with _$RecommendedTemplateListResponseModel {
  const factory RecommendedTemplateListResponseModel({
    required int totalCount,
    required int page,
    required int size,
    required bool hasNext,
    @Default(<RecommendedTemplateModel>[])
    List<RecommendedTemplateModel> templates,
  }) = _RecommendedTemplateListResponseModel;

  factory RecommendedTemplateListResponseModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$RecommendedTemplateListResponseModelFromJson(json);
}

extension RecommendedTemplateModelX on RecommendedTemplateModel {
  RecommendedTemplate toEntity() => RecommendedTemplate(
        id: id,
        category: TemplateApiMapper.categoryFromApi(category),
        title: title,
        description: description,
        recommendedChannels: recommendedChannels,
        bookmarked: bookmarked,
      );
}

extension RecommendedTemplateListResponseModelX
    on RecommendedTemplateListResponseModel {
  RecommendedTemplateListPage toEntity() => RecommendedTemplateListPage(
        totalCount: totalCount,
        page: page,
        size: size,
        hasNext: hasNext,
        templates: templates.map((e) => e.toEntity()).toList(growable: false),
      );
}
