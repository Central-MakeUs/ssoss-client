import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:ssoss_flutter/features/dashboard/presentation/pages/content_generation_management/content_generation_management_components.dart';

part 'content_generation_management_state.freezed.dart';

@freezed
abstract class ContentGenerationManagementState
    with _$ContentGenerationManagementState {
  const ContentGenerationManagementState._();

  const factory ContentGenerationManagementState({
    @Default(<ContentManagementItem>[]) List<ContentManagementItem> items,
    @Default('전체') String selectedFilter,
    @Default(true) bool isLatestFirst,
    String? openedMenuItemId,
    @Default(false) bool isLoading,
    String? errorMessage,
  }) = _ContentGenerationManagementState;

  List<ContentManagementItem> get visibleItems {
    final filteredItems = selectedFilter == '전체'
        ? items
        : items.where((item) => item.channel == selectedFilter).toList();
    return isLatestFirst ? filteredItems : filteredItems.reversed.toList();
  }
}
