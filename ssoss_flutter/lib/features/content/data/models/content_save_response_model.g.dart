// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_save_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ContentSaveChannelModel _$ContentSaveChannelModelFromJson(
        Map<String, dynamic> json) =>
    _ContentSaveChannelModel(
      contentChannelId: (json['contentChannelId'] as num).toInt(),
      channel: json['channel'] as String,
    );

Map<String, dynamic> _$ContentSaveChannelModelToJson(
        _ContentSaveChannelModel instance) =>
    <String, dynamic>{
      'contentChannelId': instance.contentChannelId,
      'channel': instance.channel,
    };

_ContentSaveResponseModel _$ContentSaveResponseModelFromJson(
        Map<String, dynamic> json) =>
    _ContentSaveResponseModel(
      contentId: (json['contentId'] as num).toInt(),
      contents: (json['contents'] as List<dynamic>)
          .map((e) =>
              ContentSaveChannelModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ContentSaveResponseModelToJson(
        _ContentSaveResponseModel instance) =>
    <String, dynamic>{
      'contentId': instance.contentId,
      'contents': instance.contents,
    };
