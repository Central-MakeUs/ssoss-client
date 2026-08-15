import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:ssoss_flutter/features/hashtag/domain/entities/hashtag_bundle.dart';

part 'hashtag_catalog_state.freezed.dart';

@freezed
abstract class HashtagCatalogState with _$HashtagCatalogState {
  const factory HashtagCatalogState({
    @Default(<HashtagBundle>[]) List<HashtagBundle> items,
    @Default('') String keyword,
    @Default(0) int page,
    @Default(false) bool hasNext,
    @Default(false) bool hasLoaded,
    @Default(false) bool isLoading,
    @Default(false) bool isLoadingMore,
    @Default(<int>{}) Set<int> pendingBookmarkIds,
    String? errorMessage,
  }) = _HashtagCatalogState;
}
