// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generation_start_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GenerationStartRequest _$GenerationStartRequestFromJson(
        Map<String, dynamic> json) =>
    _GenerationStartRequest(
      channels:
          (json['channels'] as List<dynamic>).map((e) => e as String).toList(),
      purpose: json['purpose'] as String,
      tone: json['tone'] as String,
      emphasis: json['emphasis'] as String,
      keywords:
          (json['keywords'] as List<dynamic>).map((e) => e as String).toList(),
      photoGuideChecked: json['photoGuideChecked'] as bool,
      forbidden: json['forbidden'] as String?,
    );

Map<String, dynamic> _$GenerationStartRequestToJson(
        _GenerationStartRequest instance) =>
    <String, dynamic>{
      'channels': instance.channels,
      'purpose': instance.purpose,
      'tone': instance.tone,
      'emphasis': instance.emphasis,
      'keywords': instance.keywords,
      'photoGuideChecked': instance.photoGuideChecked,
      'forbidden': instance.forbidden,
    };
