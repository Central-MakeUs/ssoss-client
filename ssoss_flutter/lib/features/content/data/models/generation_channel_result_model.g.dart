// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generation_channel_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GenerationChannelResultModel _$GenerationChannelResultModelFromJson(
        Map<String, dynamic> json) =>
    _GenerationChannelResultModel(
      channel: json['channel'] as String,
      body: json['body'] as String,
      title: json['title'] as String?,
      hashtags: (json['hashtags'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
    );

Map<String, dynamic> _$GenerationChannelResultModelToJson(
        _GenerationChannelResultModel instance) =>
    <String, dynamic>{
      'channel': instance.channel,
      'body': instance.body,
      'title': instance.title,
      'hashtags': instance.hashtags,
    };
