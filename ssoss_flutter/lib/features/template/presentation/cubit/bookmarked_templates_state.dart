import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:ssoss_flutter/features/template/domain/entities/recommended_template.dart';

part 'bookmarked_templates_state.freezed.dart';

@freezed
abstract class BookmarkedTemplatesState with _$BookmarkedTemplatesState {
  const factory BookmarkedTemplatesState({
    @Default(<RecommendedTemplate>[]) List<RecommendedTemplate> items,
    @Default(false) bool hasLoaded,
    @Default(false) bool isLoading,
    @Default(<int>{}) Set<int> pendingUnbookmarkIds,
    String? errorMessage,
  }) = _BookmarkedTemplatesState;
}
