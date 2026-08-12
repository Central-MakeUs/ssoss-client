// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_list_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ContentListItemModel _$ContentListItemModelFromJson(
        Map<String, dynamic> json) =>
    _ContentListItemModel(
      contentId: (json['contentId'] as num).toInt(),
      name: json['name'] as String,
      savedAt: json['savedAt'] as String,
      channels:
          (json['channels'] as List<dynamic>).map((e) => e as String).toList(),
      purpose: json['purpose'] as String,
      tone: json['tone'] as String,
      title: json['title'] as String,
      hashtags: (json['hashtags'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
    );

Map<String, dynamic> _$ContentListItemModelToJson(
        _ContentListItemModel instance) =>
    <String, dynamic>{
      'contentId': instance.contentId,
      'name': instance.name,
      'savedAt': instance.savedAt,
      'channels': instance.channels,
      'purpose': instance.purpose,
      'tone': instance.tone,
      'title': instance.title,
      'hashtags': instance.hashtags,
    };

_ContentListResponseModel _$ContentListResponseModelFromJson(
        Map<String, dynamic> json) =>
    _ContentListResponseModel(
      totalCount: (json['totalCount'] as num).toInt(),
      page: (json['page'] as num).toInt(),
      size: (json['size'] as num).toInt(),
      hasNext: json['hasNext'] as bool,
      contents: (json['contents'] as List<dynamic>?)
              ?.map((e) =>
                  ContentListItemModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <ContentListItemModel>[],
    );

Map<String, dynamic> _$ContentListResponseModelToJson(
        _ContentListResponseModel instance) =>
    <String, dynamic>{
      'totalCount': instance.totalCount,
      'page': instance.page,
      'size': instance.size,
      'hasNext': instance.hasNext,
      'contents': instance.contents,
    };
