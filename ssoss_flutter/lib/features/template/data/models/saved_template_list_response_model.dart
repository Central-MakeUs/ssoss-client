import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:ssoss_flutter/features/template/data/mappers/template_api_mapper.dart';
import 'package:ssoss_flutter/features/template/domain/entities/saved_template_list_item.dart';
import 'package:ssoss_flutter/features/template/domain/entities/saved_template_list_page.dart';

part 'saved_template_list_response_model.freezed.dart';
part 'saved_template_list_response_model.g.dart';

@freezed
abstract class SavedTemplateListItemModel with _$SavedTemplateListItemModel {
  const factory SavedTemplateListItemModel({
    required int savedTemplateId,
    required String category,
    required String title,
    required String description,
    required String savedAt,
  }) = _SavedTemplateListItemModel;

  factory SavedTemplateListItemModel.fromJson(Map<String, dynamic> json) =>
      _$SavedTemplateListItemModelFromJson(json);
}

@freezed
abstract class SavedTemplateListResponseModel
    with _$SavedTemplateListResponseModel {
  const factory SavedTemplateListResponseModel({
    required int totalCount,
    required int page,
    required int size,
    required bool hasNext,
    @Default(<SavedTemplateListItemModel>[])
    List<SavedTemplateListItemModel> savedTemplates,
  }) = _SavedTemplateListResponseModel;

  factory SavedTemplateListResponseModel.fromJson(Map<String, dynamic> json) =>
      _$SavedTemplateListResponseModelFromJson(json);
}

extension SavedTemplateListItemModelX on SavedTemplateListItemModel {
  SavedTemplateListItem toEntity() => SavedTemplateListItem(
        savedTemplateId: savedTemplateId,
        category: TemplateApiMapper.categoryFromApi(category),
        title: title,
        description: description,
        savedAt: DateTime.parse(savedAt).toLocal(),
      );
}

extension SavedTemplateListResponseModelX on SavedTemplateListResponseModel {
  SavedTemplateListPage toEntity() => SavedTemplateListPage(
        totalCount: totalCount,
        page: page,
        size: size,
        hasNext: hasNext,
        savedTemplates:
            savedTemplates.map((e) => e.toEntity()).toList(growable: false),
      );
}
