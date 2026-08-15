// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'style_reuse_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StyleReuseRequest _$StyleReuseRequestFromJson(Map<String, dynamic> json) =>
    _StyleReuseRequest(
      emphasis: json['emphasis'] as String,
      keywords:
          (json['keywords'] as List<dynamic>).map((e) => e as String).toList(),
      photoGuideChecked: json['photoGuideChecked'] as bool,
      forbidden: json['forbidden'] as String?,
    );

Map<String, dynamic> _$StyleReuseRequestToJson(_StyleReuseRequest instance) =>
    <String, dynamic>{
      'emphasis': instance.emphasis,
      'keywords': instance.keywords,
      'photoGuideChecked': instance.photoGuideChecked,
      'forbidden': instance.forbidden,
    };
