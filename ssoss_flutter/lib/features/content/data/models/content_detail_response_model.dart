import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:ssoss_flutter/features/content/data/mappers/content_create_api_mapper.dart';
import 'package:ssoss_flutter/features/content/data/models/content_channel_response_model.dart';
import 'package:ssoss_flutter/features/content/domain/entities/content_detail.dart';

part 'content_detail_response_model.freezed.dart';
part 'content_detail_response_model.g.dart';

@freezed
abstract class ContentDetailResponseModel with _$ContentDetailResponseModel {
  const factory ContentDetailResponseModel({
    required int contentId,
    required String purpose,
    required String tone,
    @Default(<String>[]) List<String> keywords,
    @Default(<ContentChannelResponseModel>[])
    List<ContentChannelResponseModel> contents,
  }) = _ContentDetailResponseModel;

  factory ContentDetailResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ContentDetailResponseModelFromJson(json);
}

extension ContentDetailResponseModelX on ContentDetailResponseModel {
  ContentDetail toEntity() => ContentDetail(
        contentId: contentId,
        purpose: ContentCreateApiMapper.purposeFromApi(purpose),
        tone: ContentCreateApiMapper.toneFromApi(tone),
        keywords: keywords,
        contents: contents.map((e) => e.toEntity()).toList(growable: false),
      );
}
