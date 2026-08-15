// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_template_detail_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SavedTemplateDetailResponseModel _$SavedTemplateDetailResponseModelFromJson(
        Map<String, dynamic> json) =>
    _SavedTemplateDetailResponseModel(
      savedTemplateId: (json['savedTemplateId'] as num).toInt(),
      category: json['category'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      body: json['body'] as String,
      savedAt: json['savedAt'] as String,
      recommendedChannels: (json['recommendedChannels'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
    );

Map<String, dynamic> _$SavedTemplateDetailResponseModelToJson(
        _SavedTemplateDetailResponseModel instance) =>
    <String, dynamic>{
      'savedTemplateId': instance.savedTemplateId,
      'category': instance.category,
      'title': instance.title,
      'description': instance.description,
      'body': instance.body,
      'savedAt': instance.savedAt,
      'recommendedChannels': instance.recommendedChannels,
    };
