// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_content_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CreateContentRequest _$CreateContentRequestFromJson(
        Map<String, dynamic> json) =>
    _CreateContentRequest(
      channels:
          (json['channels'] as List<dynamic>).map((e) => e as String).toList(),
      purpose: json['purpose'] as String,
      tone: json['tone'] as String,
      highlight: json['highlight'] as String,
      keywords:
          (json['keywords'] as List<dynamic>).map((e) => e as String).toList(),
      photoGuideEnabled: json['photoGuideEnabled'] as bool,
      forbidden: json['forbidden'] as String?,
    );

Map<String, dynamic> _$CreateContentRequestToJson(
        _CreateContentRequest instance) =>
    <String, dynamic>{
      'channels': instance.channels,
      'purpose': instance.purpose,
      'tone': instance.tone,
      'highlight': instance.highlight,
      'keywords': instance.keywords,
      'photoGuideEnabled': instance.photoGuideEnabled,
      'forbidden': instance.forbidden,
    };
