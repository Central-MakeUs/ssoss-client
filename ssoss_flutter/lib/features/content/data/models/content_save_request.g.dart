// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_save_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ContentSaveRequest _$ContentSaveRequestFromJson(Map<String, dynamic> json) =>
    _ContentSaveRequest(
      generationId: (json['generationId'] as num).toInt(),
      contents: (json['contents'] as List<dynamic>)
          .map((e) =>
              GenerationChannelResultModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ContentSaveRequestToJson(_ContentSaveRequest instance) =>
    <String, dynamic>{
      'generationId': instance.generationId,
      'contents': instance.contents.map((e) => e.toJson()).toList(),
    };
