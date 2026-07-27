import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:ssoss_flutter/features/content/data/mappers/content_create_api_mapper.dart';
import 'package:ssoss_flutter/features/content/domain/entities/generation_channel_result.dart';
import 'package:ssoss_flutter/features/content/domain/entities/upload_channel.dart';

part 'generation_channel_result_model.freezed.dart';
part 'generation_channel_result_model.g.dart';

@freezed
abstract class GenerationChannelResultModel with _$GenerationChannelResultModel {
  const factory GenerationChannelResultModel({
    required String channel,
    required String body,
    String? title,
    @Default(<String>[]) List<String> hashtags,
  }) = _GenerationChannelResultModel;

  factory GenerationChannelResultModel.fromJson(Map<String, dynamic> json) =>
      _$GenerationChannelResultModelFromJson(json);
}

extension GenerationChannelResultModelX on GenerationChannelResultModel {
  GenerationChannelResult toEntity() => GenerationChannelResult(
        channel: ContentCreateApiMapper.channelFromApi(channel),
        title: title,
        body: body,
        hashtags: hashtags,
      );

  /// POST 저장용 JSON. null title 키는 제외한다.
  Map<String, dynamic> toSaveJson() => {
        'channel': channel,
        'body': body,
        'hashtags': hashtags,
        if (title != null) 'title': title,
      };
}

extension GenerationChannelResultEntityX on GenerationChannelResult {
  /// POST `/v1/contents` 용. 채널 단위 완전체 + title omit 규칙 적용.
  GenerationChannelResultModel toSaveModel() {
    final trimmed = title?.trim();
    final saveTitle = channel == UploadChannel.blog
        ? (trimmed == null || trimmed.isEmpty ? null : trimmed)
        : null;
    return GenerationChannelResultModel(
      channel: ContentCreateApiMapper.channel(channel),
      title: saveTitle,
      body: body,
      hashtags: hashtags,
    );
  }
}
