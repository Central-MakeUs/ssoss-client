import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:ssoss_flutter/features/hashtag/domain/entities/hashtag_bundle.dart';
import 'package:ssoss_flutter/features/hashtag/domain/entities/hashtag_bundle_list_page.dart';

part 'hashtag_bundle_list_response_model.freezed.dart';
part 'hashtag_bundle_list_response_model.g.dart';

@freezed
abstract class HashtagBundleModel with _$HashtagBundleModel {
  const factory HashtagBundleModel({
    required int id,
    required String name,
    @Default(<String>[]) List<String> hashtags,
    @Default(false) bool bookmarked,
  }) = _HashtagBundleModel;

  factory HashtagBundleModel.fromJson(Map<String, dynamic> json) =>
      _$HashtagBundleModelFromJson(json);
}

@freezed
abstract class HashtagBundleListResponseModel
    with _$HashtagBundleListResponseModel {
  const factory HashtagBundleListResponseModel({
    required int totalCount,
    required int page,
    required int size,
    required bool hasNext,
    @Default(<HashtagBundleModel>[]) List<HashtagBundleModel> bundles,
  }) = _HashtagBundleListResponseModel;

  factory HashtagBundleListResponseModel.fromJson(Map<String, dynamic> json) =>
      _$HashtagBundleListResponseModelFromJson(json);
}

extension HashtagBundleModelX on HashtagBundleModel {
  HashtagBundle toEntity() => HashtagBundle(
        id: id,
        name: name,
        hashtags: hashtags,
        bookmarked: bookmarked,
      );
}

extension HashtagBundleListResponseModelX on HashtagBundleListResponseModel {
  HashtagBundleListPage toEntity() => HashtagBundleListPage(
        totalCount: totalCount,
        page: page,
        size: size,
        hasNext: hasNext,
        bundles: bundles.map((e) => e.toEntity()).toList(growable: false),
      );
}
