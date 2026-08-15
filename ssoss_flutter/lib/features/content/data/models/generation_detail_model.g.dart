// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generation_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GenerationDetailModel _$GenerationDetailModelFromJson(
        Map<String, dynamic> json) =>
    _GenerationDetailModel(
      generationId: (json['generationId'] as num).toInt(),
      status: json['status'] as String,
      purpose: json['purpose'] as String,
      tone: json['tone'] as String,
      keywords:
          (json['keywords'] as List<dynamic>).map((e) => e as String).toList(),
      results: (json['results'] as List<dynamic>)
          .map((e) =>
              GenerationChannelResultModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GenerationDetailModelToJson(
        _GenerationDetailModel instance) =>
    <String, dynamic>{
      'generationId': instance.generationId,
      'status': instance.status,
      'purpose': instance.purpose,
      'tone': instance.tone,
      'keywords': instance.keywords,
      'results': instance.results,
    };
