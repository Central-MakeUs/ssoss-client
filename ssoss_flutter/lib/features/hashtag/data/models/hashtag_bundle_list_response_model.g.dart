// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hashtag_bundle_list_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HashtagBundleModel _$HashtagBundleModelFromJson(Map<String, dynamic> json) =>
    _HashtagBundleModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      hashtags: (json['hashtags'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      bookmarked: json['bookmarked'] as bool? ?? false,
    );

Map<String, dynamic> _$HashtagBundleModelToJson(_HashtagBundleModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'hashtags': instance.hashtags,
      'bookmarked': instance.bookmarked,
    };

_HashtagBundleListResponseModel _$HashtagBundleListResponseModelFromJson(
        Map<String, dynamic> json) =>
    _HashtagBundleListResponseModel(
      totalCount: (json['totalCount'] as num).toInt(),
      page: (json['page'] as num).toInt(),
      size: (json['size'] as num).toInt(),
      hasNext: json['hasNext'] as bool,
      bundles: (json['bundles'] as List<dynamic>?)
              ?.map(
                  (e) => HashtagBundleModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <HashtagBundleModel>[],
    );

Map<String, dynamic> _$HashtagBundleListResponseModelToJson(
        _HashtagBundleListResponseModel instance) =>
    <String, dynamic>{
      'totalCount': instance.totalCount,
      'page': instance.page,
      'size': instance.size,
      'hasNext': instance.hasNext,
      'bundles': instance.bundles,
    };
