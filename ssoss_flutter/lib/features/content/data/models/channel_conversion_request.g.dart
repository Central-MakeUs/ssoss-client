// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel_conversion_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChannelConversionRequest _$ChannelConversionRequestFromJson(
        Map<String, dynamic> json) =>
    _ChannelConversionRequest(
      channels:
          (json['channels'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ChannelConversionRequestToJson(
        _ChannelConversionRequest instance) =>
    <String, dynamic>{
      'channels': instance.channels,
    };
