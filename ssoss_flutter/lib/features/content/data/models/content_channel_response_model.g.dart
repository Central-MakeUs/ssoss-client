// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_channel_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ContentChannelResponseModel _$ContentChannelResponseModelFromJson(
        Map<String, dynamic> json) =>
    _ContentChannelResponseModel(
      contentChannelId: (json['contentChannelId'] as num).toInt(),
      channel: json['channel'] as String,
      body: json['body'] as String,
      title: json['title'] as String?,
      hashtags: (json['hashtags'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
    );

Map<String, dynamic> _$ContentChannelResponseModelToJson(
        _ContentChannelResponseModel instance) =>
    <String, dynamic>{
      'contentChannelId': instance.contentChannelId,
      'channel': instance.channel,
      'body': instance.body,
      'title': instance.title,
      'hashtags': instance.hashtags,
    };
