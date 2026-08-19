import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:ssoss_flutter/features/content/data/mappers/content_create_api_mapper.dart';
import 'package:ssoss_flutter/features/content/domain/entities/channel_conversion_input.dart';

part 'channel_conversion_request.freezed.dart';
part 'channel_conversion_request.g.dart';

@freezed
abstract class ChannelConversionRequest with _$ChannelConversionRequest {
  const factory ChannelConversionRequest({
    required List<String> channels,
  }) = _ChannelConversionRequest;

  factory ChannelConversionRequest.fromEntity(ChannelConversionInput input) {
    return ChannelConversionRequest(
      channels: ContentCreateApiMapper.channels(input.channels),
    );
  }

  factory ChannelConversionRequest.fromJson(Map<String, dynamic> json) =>
      _$ChannelConversionRequestFromJson(json);
}
