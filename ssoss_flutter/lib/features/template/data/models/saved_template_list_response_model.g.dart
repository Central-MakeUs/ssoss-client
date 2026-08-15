// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_template_list_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SavedTemplateListItemModel _$SavedTemplateListItemModelFromJson(
        Map<String, dynamic> json) =>
    _SavedTemplateListItemModel(
      savedTemplateId: (json['savedTemplateId'] as num).toInt(),
      category: json['category'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      savedAt: json['savedAt'] as String,
    );

Map<String, dynamic> _$SavedTemplateListItemModelToJson(
        _SavedTemplateListItemModel instance) =>
    <String, dynamic>{
      'savedTemplateId': instance.savedTemplateId,
      'category': instance.category,
      'title': instance.title,
      'description': instance.description,
      'savedAt': instance.savedAt,
    };

_SavedTemplateListResponseModel _$SavedTemplateListResponseModelFromJson(
        Map<String, dynamic> json) =>
    _SavedTemplateListResponseModel(
      totalCount: (json['totalCount'] as num).toInt(),
      page: (json['page'] as num).toInt(),
      size: (json['size'] as num).toInt(),
      hasNext: json['hasNext'] as bool,
      savedTemplates: (json['savedTemplates'] as List<dynamic>?)
              ?.map((e) => SavedTemplateListItemModel.fromJson(
                  e as Map<String, dynamic>))
              .toList() ??
          const <SavedTemplateListItemModel>[],
    );

Map<String, dynamic> _$SavedTemplateListResponseModelToJson(
        _SavedTemplateListResponseModel instance) =>
    <String, dynamic>{
      'totalCount': instance.totalCount,
      'page': instance.page,
      'size': instance.size,
      'hasNext': instance.hasNext,
      'savedTemplates': instance.savedTemplates,
    };
