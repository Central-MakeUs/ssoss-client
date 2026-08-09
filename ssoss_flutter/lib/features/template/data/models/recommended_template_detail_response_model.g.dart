// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommended_template_detail_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RecommendedTemplateDetailResponseModel
    _$RecommendedTemplateDetailResponseModelFromJson(
            Map<String, dynamic> json) =>
        _RecommendedTemplateDetailResponseModel(
          id: (json['id'] as num).toInt(),
          category: json['category'] as String,
          title: json['title'] as String,
          description: json['description'] as String,
          body: json['body'] as String,
          exampleBody: json['exampleBody'] as String,
          recommendedChannels: (json['recommendedChannels'] as List<dynamic>?)
                  ?.map((e) => e as String)
                  .toList() ??
              const <String>[],
          bookmarked: json['bookmarked'] as bool? ?? false,
        );

Map<String, dynamic> _$RecommendedTemplateDetailResponseModelToJson(
        _RecommendedTemplateDetailResponseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'category': instance.category,
      'title': instance.title,
      'description': instance.description,
      'body': instance.body,
      'exampleBody': instance.exampleBody,
      'recommendedChannels': instance.recommendedChannels,
      'bookmarked': instance.bookmarked,
    };
