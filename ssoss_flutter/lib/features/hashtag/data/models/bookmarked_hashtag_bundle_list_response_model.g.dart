// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookmarked_hashtag_bundle_list_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BookmarkedHashtagBundleModel _$BookmarkedHashtagBundleModelFromJson(
        Map<String, dynamic> json) =>
    _BookmarkedHashtagBundleModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      hashtags: (json['hashtags'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
    );

Map<String, dynamic> _$BookmarkedHashtagBundleModelToJson(
        _BookmarkedHashtagBundleModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'hashtags': instance.hashtags,
    };

_BookmarkedHashtagBundleListResponseModel
    _$BookmarkedHashtagBundleListResponseModelFromJson(
            Map<String, dynamic> json) =>
        _BookmarkedHashtagBundleListResponseModel(
          bundles: (json['bundles'] as List<dynamic>?)
                  ?.map((e) => BookmarkedHashtagBundleModel.fromJson(
                      e as Map<String, dynamic>))
                  .toList() ??
              const <BookmarkedHashtagBundleModel>[],
        );

Map<String, dynamic> _$BookmarkedHashtagBundleListResponseModelToJson(
        _BookmarkedHashtagBundleListResponseModel instance) =>
    <String, dynamic>{
      'bundles': instance.bundles,
    };
