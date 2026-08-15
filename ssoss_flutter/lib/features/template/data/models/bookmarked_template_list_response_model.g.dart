// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookmarked_template_list_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BookmarkedTemplateModel _$BookmarkedTemplateModelFromJson(
        Map<String, dynamic> json) =>
    _BookmarkedTemplateModel(
      id: (json['id'] as num).toInt(),
      category: json['category'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      recommendedChannels: (json['recommendedChannels'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
    );

Map<String, dynamic> _$BookmarkedTemplateModelToJson(
        _BookmarkedTemplateModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'category': instance.category,
      'title': instance.title,
      'description': instance.description,
      'recommendedChannels': instance.recommendedChannels,
    };

_BookmarkedTemplateListResponseModel
    _$BookmarkedTemplateListResponseModelFromJson(Map<String, dynamic> json) =>
        _BookmarkedTemplateListResponseModel(
          templates: (json['templates'] as List<dynamic>?)
                  ?.map((e) => BookmarkedTemplateModel.fromJson(
                      e as Map<String, dynamic>))
                  .toList() ??
              const <BookmarkedTemplateModel>[],
        );

Map<String, dynamic> _$BookmarkedTemplateListResponseModelToJson(
        _BookmarkedTemplateListResponseModel instance) =>
    <String, dynamic>{
      'templates': instance.templates,
    };
