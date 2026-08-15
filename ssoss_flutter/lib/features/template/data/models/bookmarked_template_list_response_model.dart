import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:ssoss_flutter/features/template/data/mappers/template_api_mapper.dart';
import 'package:ssoss_flutter/features/template/domain/entities/recommended_template.dart';

part 'bookmarked_template_list_response_model.freezed.dart';
part 'bookmarked_template_list_response_model.g.dart';

@freezed
abstract class BookmarkedTemplateModel with _$BookmarkedTemplateModel {
  const factory BookmarkedTemplateModel({
    required int id,
    required String category,
    required String title,
    required String description,
    @Default(<String>[]) List<String> recommendedChannels,
  }) = _BookmarkedTemplateModel;

  factory BookmarkedTemplateModel.fromJson(Map<String, dynamic> json) =>
      _$BookmarkedTemplateModelFromJson(json);
}

@freezed
abstract class BookmarkedTemplateListResponseModel
    with _$BookmarkedTemplateListResponseModel {
  const factory BookmarkedTemplateListResponseModel({
    @Default(<BookmarkedTemplateModel>[])
    List<BookmarkedTemplateModel> templates,
  }) = _BookmarkedTemplateListResponseModel;

  factory BookmarkedTemplateListResponseModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$BookmarkedTemplateListResponseModelFromJson(json);
}

extension BookmarkedTemplateModelX on BookmarkedTemplateModel {
  RecommendedTemplate toEntity() => RecommendedTemplate(
        id: id,
        category: TemplateApiMapper.categoryFromApi(category),
        title: title,
        description: description,
        recommendedChannels: recommendedChannels,
        bookmarked: true,
      );
}

extension BookmarkedTemplateListResponseModelX
    on BookmarkedTemplateListResponseModel {
  List<RecommendedTemplate> toEntities() =>
      templates.map((e) => e.toEntity()).toList(growable: false);
}
