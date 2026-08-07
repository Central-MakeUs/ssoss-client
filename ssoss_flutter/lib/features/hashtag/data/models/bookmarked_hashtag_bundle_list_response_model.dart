import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:ssoss_flutter/features/hashtag/domain/entities/hashtag_bundle.dart';

part 'bookmarked_hashtag_bundle_list_response_model.freezed.dart';
part 'bookmarked_hashtag_bundle_list_response_model.g.dart';

@freezed
abstract class BookmarkedHashtagBundleModel
    with _$BookmarkedHashtagBundleModel {
  const factory BookmarkedHashtagBundleModel({
    required int id,
    required String name,
    @Default(<String>[]) List<String> hashtags,
  }) = _BookmarkedHashtagBundleModel;

  factory BookmarkedHashtagBundleModel.fromJson(Map<String, dynamic> json) =>
      _$BookmarkedHashtagBundleModelFromJson(json);
}

@freezed
abstract class BookmarkedHashtagBundleListResponseModel
    with _$BookmarkedHashtagBundleListResponseModel {
  const factory BookmarkedHashtagBundleListResponseModel({
    @Default(<BookmarkedHashtagBundleModel>[])
    List<BookmarkedHashtagBundleModel> bundles,
  }) = _BookmarkedHashtagBundleListResponseModel;

  factory BookmarkedHashtagBundleListResponseModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$BookmarkedHashtagBundleListResponseModelFromJson(json);
}

extension BookmarkedHashtagBundleModelX on BookmarkedHashtagBundleModel {
  HashtagBundle toEntity() => HashtagBundle(
        id: id,
        name: name,
        hashtags: hashtags,
        bookmarked: true,
      );
}

extension BookmarkedHashtagBundleListResponseModelX
    on BookmarkedHashtagBundleListResponseModel {
  List<HashtagBundle> toEntities() =>
      bundles.map((e) => e.toEntity()).toList(growable: false);
}
