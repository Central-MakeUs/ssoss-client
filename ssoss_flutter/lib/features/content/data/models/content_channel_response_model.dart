import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:ssoss_flutter/features/content/data/mappers/content_create_api_mapper.dart';
import 'package:ssoss_flutter/features/content/domain/entities/content_channel_content.dart';
import 'package:ssoss_flutter/features/content/domain/entities/generation_channel_result.dart';

part 'content_channel_response_model.freezed.dart';
part 'content_channel_response_model.g.dart';

@freezed
abstract class ContentChannelResponseModel with _$ContentChannelResponseModel {
  const factory ContentChannelResponseModel({
    required int contentChannelId,
    required String channel,
    required String body,
    String? title,
    @Default(<String>[]) List<String> hashtags,
  }) = _ContentChannelResponseModel;

  factory ContentChannelResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ContentChannelResponseModelFromJson(json);
}

extension ContentChannelResponseModelX on ContentChannelResponseModel {
  ContentChannelContent toEntity() => ContentChannelContent(
        contentChannelId: contentChannelId,
        channelResult: GenerationChannelResult(
          channel: ContentCreateApiMapper.channelFromApi(channel),
          title: title,
          body: body,
          hashtags: hashtags,
        ),
      );
}
