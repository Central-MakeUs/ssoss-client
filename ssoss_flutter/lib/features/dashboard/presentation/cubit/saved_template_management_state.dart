import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:ssoss_flutter/features/dashboard/presentation/pages/content_generation_management/content_generation_management_components.dart';
import 'package:ssoss_flutter/features/template/domain/entities/saved_template_sort.dart';

part 'saved_template_management_state.freezed.dart';

@freezed
abstract class SavedTemplateManagementState
    with _$SavedTemplateManagementState {
  const SavedTemplateManagementState._();

  const factory SavedTemplateManagementState({
    @Default(<SavedContentTemplateManagementItem>[])
    List<SavedContentTemplateManagementItem> items,
    @Default(SavedTemplateSort.latest) SavedTemplateSort sort,
    @Default(0) int totalCount,
    @Default(0) int page,
    @Default(false) bool hasNext,
    String? openedMenuItemId,
    @Default(false) bool isLoading,
    @Default(false) bool isLoadingMore,
    @Default(false) bool isRefreshing,
    String? errorMessage,
  }) = _SavedTemplateManagementState;

  String get sortLabel => switch (sort) {
        SavedTemplateSort.latest => '최신순',
        SavedTemplateSort.oldest => '오래된순',
      };
}
