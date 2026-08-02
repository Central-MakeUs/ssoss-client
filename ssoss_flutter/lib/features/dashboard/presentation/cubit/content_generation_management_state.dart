import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:ssoss_flutter/features/content/domain/entities/content_sort.dart';
import 'package:ssoss_flutter/features/content/domain/entities/upload_channel.dart';
import 'package:ssoss_flutter/features/dashboard/presentation/pages/content_generation_management/content_generation_management_components.dart';

part 'content_generation_management_state.freezed.dart';

@freezed
abstract class ContentGenerationManagementState
    with _$ContentGenerationManagementState {
  const ContentGenerationManagementState._();

  const factory ContentGenerationManagementState({
    @Default(<ContentManagementItem>[]) List<ContentManagementItem> items,
    @Default('전체') String selectedFilter,
    @Default(ContentSort.latest) ContentSort sort,
    @Default(0) int totalCount,
    @Default(0) int page,
    @Default(false) bool hasNext,
    String? openedMenuItemId,
    @Default(false) bool isLoading,
    @Default(false) bool isLoadingMore,
    @Default(false) bool isRefreshing,
    String? errorMessage,
  }) = _ContentGenerationManagementState;

  UploadChannel? get filterChannel => switch (selectedFilter) {
        '블로그' => UploadChannel.blog,
        '인스타그램' => UploadChannel.instagram,
        '당근' => UploadChannel.carrot,
        '스레드' => UploadChannel.thread,
        _ => null,
      };

  String get sortLabel => switch (sort) {
        ContentSort.latest => '최신순',
        ContentSort.oldest => '오래된순',
      };
}
