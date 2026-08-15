import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:ssoss_flutter/features/content/data/mappers/content_create_api_mapper.dart';
import 'package:ssoss_flutter/features/content/domain/entities/content_list_item.dart';
import 'package:ssoss_flutter/features/content/domain/entities/content_list_page.dart';

part 'content_list_response_model.freezed.dart';
part 'content_list_response_model.g.dart';

@freezed
abstract class ContentListItemModel with _$ContentListItemModel {
  const factory ContentListItemModel({
    required int contentId,
    required String name,
    required String savedAt,
    required List<String> channels,
    required String purpose,
    required String tone,
    required String title,
    @Default(<String>[]) List<String> hashtags,
  }) = _ContentListItemModel;

  factory ContentListItemModel.fromJson(Map<String, dynamic> json) =>
      _$ContentListItemModelFromJson(json);
}

@freezed
abstract class ContentListResponseModel with _$ContentListResponseModel {
  const factory ContentListResponseModel({
    required int totalCount,
    required int page,
    required int size,
    required bool hasNext,
    @Default(<ContentListItemModel>[]) List<ContentListItemModel> contents,
  }) = _ContentListResponseModel;

  factory ContentListResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ContentListResponseModelFromJson(json);
}

extension ContentListItemModelX on ContentListItemModel {
  ContentListItem toEntity() => ContentListItem(
        contentId: contentId,
        name: name,
        savedAt: DateTime.parse(savedAt).toLocal(),
        channels: channels
            .map(ContentCreateApiMapper.channelFromApi)
            .toList(growable: false),
        purpose: ContentCreateApiMapper.purposeFromApi(purpose),
        tone: ContentCreateApiMapper.toneFromApi(tone),
        title: title,
        hashtags: hashtags,
      );
}

extension ContentListResponseModelX on ContentListResponseModel {
  ContentListPage toEntity() => ContentListPage(
        totalCount: totalCount,
        page: page,
        size: size,
        hasNext: hasNext,
        contents: contents.map((e) => e.toEntity()).toList(growable: false),
      );
}
