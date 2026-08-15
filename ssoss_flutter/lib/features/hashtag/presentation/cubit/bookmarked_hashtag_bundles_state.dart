import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:ssoss_flutter/features/hashtag/domain/entities/hashtag_bundle.dart';

part 'bookmarked_hashtag_bundles_state.freezed.dart';

@freezed
abstract class BookmarkedHashtagBundlesState
    with _$BookmarkedHashtagBundlesState {
  const factory BookmarkedHashtagBundlesState({
    @Default(<HashtagBundle>[]) List<HashtagBundle> items,
    @Default(false) bool hasLoaded,
    @Default(false) bool isLoading,
    @Default(<int>{}) Set<int> pendingUnbookmarkIds,
    String? errorMessage,
  }) = _BookmarkedHashtagBundlesState;
}
