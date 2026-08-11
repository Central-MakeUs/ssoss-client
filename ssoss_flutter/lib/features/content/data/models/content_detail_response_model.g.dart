// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_detail_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ContentDetailResponseModel _$ContentDetailResponseModelFromJson(
        Map<String, dynamic> json) =>
    _ContentDetailResponseModel(
      contentId: (json['contentId'] as num).toInt(),
      purpose: json['purpose'] as String,
      tone: json['tone'] as String,
      name: json['name'] as String? ?? '',
      keywords: (json['keywords'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      contents: (json['contents'] as List<dynamic>?)
              ?.map((e) => ContentChannelResponseModel.fromJson(
                  e as Map<String, dynamic>))
              .toList() ??
          const <ContentChannelResponseModel>[],
    );

Map<String, dynamic> _$ContentDetailResponseModelToJson(
        _ContentDetailResponseModel instance) =>
    <String, dynamic>{
      'contentId': instance.contentId,
      'purpose': instance.purpose,
      'tone': instance.tone,
      'name': instance.name,
      'keywords': instance.keywords,
      'contents': instance.contents,
    };
