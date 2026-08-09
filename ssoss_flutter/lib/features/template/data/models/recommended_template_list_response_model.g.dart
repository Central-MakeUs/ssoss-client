// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommended_template_list_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RecommendedTemplateModel _$RecommendedTemplateModelFromJson(
        Map<String, dynamic> json) =>
    _RecommendedTemplateModel(
      id: (json['id'] as num).toInt(),
      category: json['category'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      recommendedChannels: (json['recommendedChannels'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      bookmarked: json['bookmarked'] as bool? ?? false,
    );

Map<String, dynamic> _$RecommendedTemplateModelToJson(
        _RecommendedTemplateModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'category': instance.category,
      'title': instance.title,
      'description': instance.description,
      'recommendedChannels': instance.recommendedChannels,
      'bookmarked': instance.bookmarked,
    };

_RecommendedTemplateListResponseModel
    _$RecommendedTemplateListResponseModelFromJson(Map<String, dynamic> json) =>
        _RecommendedTemplateListResponseModel(
          totalCount: (json['totalCount'] as num).toInt(),
          page: (json['page'] as num).toInt(),
          size: (json['size'] as num).toInt(),
          hasNext: json['hasNext'] as bool,
          templates: (json['templates'] as List<dynamic>?)
                  ?.map((e) => RecommendedTemplateModel.fromJson(
                      e as Map<String, dynamic>))
                  .toList() ??
              const <RecommendedTemplateModel>[],
        );

Map<String, dynamic> _$RecommendedTemplateListResponseModelToJson(
        _RecommendedTemplateListResponseModel instance) =>
    <String, dynamic>{
      'totalCount': instance.totalCount,
      'page': instance.page,
      'size': instance.size,
      'hasNext': instance.hasNext,
      'templates': instance.templates,
    };
