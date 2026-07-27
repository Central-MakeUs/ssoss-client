import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:ssoss_flutter/features/content/data/mappers/content_create_api_mapper.dart';
import 'package:ssoss_flutter/features/content/domain/entities/saved_content.dart';

part 'content_save_response_model.freezed.dart';
part 'content_save_response_model.g.dart';

@freezed
abstract class ContentSaveChannelModel with _$ContentSaveChannelModel {
  const factory ContentSaveChannelModel({
    required int contentChannelId,
    required String channel,
  }) = _ContentSaveChannelModel;

  factory ContentSaveChannelModel.fromJson(Map<String, dynamic> json) =>
      _$ContentSaveChannelModelFromJson(json);
}

@freezed
abstract class ContentSaveResponseModel with _$ContentSaveResponseModel {
  const factory ContentSaveResponseModel({
    required int contentId,
    required List<ContentSaveChannelModel> contents,
  }) = _ContentSaveResponseModel;

  factory ContentSaveResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ContentSaveResponseModelFromJson(json);
}

extension ContentSaveResponseModelX on ContentSaveResponseModel {
  SavedContent toEntity() => SavedContent(
        contentId: contentId,
        channels: contents
            .map(
              (item) => SavedContentChannel(
                contentChannelId: item.contentChannelId,
                channel: ContentCreateApiMapper.channelFromApi(item.channel),
              ),
            )
            .toList(growable: false),
      );
}
