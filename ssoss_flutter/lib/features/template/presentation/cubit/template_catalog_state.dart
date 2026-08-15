import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:ssoss_flutter/features/template/domain/entities/recommended_template.dart';
import 'package:ssoss_flutter/features/template/domain/entities/recommended_template_category.dart';

part 'template_catalog_state.freezed.dart';

@freezed
abstract class TemplateCatalogState with _$TemplateCatalogState {
  const factory TemplateCatalogState({
    @Default(<RecommendedTemplate>[]) List<RecommendedTemplate> items,
    RecommendedTemplateCategory? category,
    @Default('') String keyword,
    @Default(0) int page,
    @Default(false) bool hasNext,
    @Default(false) bool hasLoaded,
    @Default(false) bool isLoading,
    @Default(false) bool isLoadingMore,
    @Default(<int>{}) Set<int> pendingBookmarkIds,
    String? errorMessage,
  }) = _TemplateCatalogState;
}
