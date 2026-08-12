import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ssoss_flutter/core/exception/app_exception.dart';
import 'package:ssoss_flutter/features/content/domain/entities/content_list_item.dart';
import 'package:ssoss_flutter/features/content/domain/entities/content_sort.dart';
import 'package:ssoss_flutter/features/content/domain/usecases/delete_content_usecase.dart';
import 'package:ssoss_flutter/features/content/domain/usecases/list_contents_usecase.dart';
import 'package:ssoss_flutter/features/content/domain/usecases/rename_content_usecase.dart';
import 'package:ssoss_flutter/features/content/presentation/models/content_label_mapper.dart';
import 'package:ssoss_flutter/features/dashboard/presentation/cubit/content_generation_management_state.dart';
import 'package:ssoss_flutter/features/dashboard/presentation/pages/content_generation_management/content_generation_management_components.dart';

class ContentGenerationManagementCubit
    extends Cubit<ContentGenerationManagementState> {
  ContentGenerationManagementCubit({
    required ListContentsUseCase listContents,
    required DeleteContentUseCase deleteContent,
    required RenameContentUseCase renameContent,
  })  : _listContents = listContents,
        _deleteContent = deleteContent,
        _renameContent = renameContent,
        super(const ContentGenerationManagementState());

  static const int pageSize = 10;
  static const int minTitleLength = 2;
  static const int maxTitleLength = 20;

  final ListContentsUseCase _listContents;
  final DeleteContentUseCase _deleteContent;
  final RenameContentUseCase _renameContent;

  Future<void> loadInitial() => _load(page: 0, replace: true);

  Future<void> refresh() {
    return _load(page: 0, replace: true, keepRefreshing: true);
  }

  Future<void> loadMore() async {
    if (!state.hasNext || state.isLoadingMore || state.isLoading) {
      return;
    }
    emit(state.copyWith(isLoadingMore: true, errorMessage: null));
    await _load(page: state.page + 1, replace: false);
  }

  Future<void> selectFilter(String filter) async {
    if (filter == state.selectedFilter || state.isLoading) {
      return;
    }
    emit(
      state.copyWith(
        selectedFilter: filter,
        openedMenuItemId: null,
      ),
    );
    await _load(page: 0, replace: true);
  }

  Future<void> toggleSort() async {
    if (state.isLoading) {
      return;
    }
    final nextSort = state.sort == ContentSort.latest
        ? ContentSort.oldest
        : ContentSort.latest;
    emit(
      state.copyWith(
        sort: nextSort,
        openedMenuItemId: null,
      ),
    );
    await _load(page: 0, replace: true);
  }

  void toggleDeleteMenu(String menuId) {
    emit(
      state.copyWith(
        openedMenuItemId: state.openedMenuItemId == menuId ? null : menuId,
      ),
    );
  }

  void closeDeleteMenu() {
    emit(state.copyWith(openedMenuItemId: null));
  }

  Future<void> renameItem(
    ContentManagementItem item,
    String title,
  ) async {
    emit(state.copyWith(openedMenuItemId: null, errorMessage: null));
    final trimmed = title.trim();
    if (trimmed.length < minTitleLength || trimmed.length > maxTitleLength) {
      const message = '제목은 2자 이상 20자 이내로 입력해 주세요';
      emit(state.copyWith(errorMessage: message));
      throw const ServerException(400, message);
    }

    try {
      final detail = await _renameContent(
        contentId: item.contentId,
        name: trimmed,
      );
      if (isClosed) {
        return;
      }
      emit(
        state.copyWith(
          items: state.items
              .map(
                (current) => current.contentId == item.contentId
                    ? current.copyWith(name: detail.name)
                    : current,
              )
              .toList(growable: false),
        ),
      );
    } on AppException catch (error) {
      if (!isClosed) {
        emit(state.copyWith(errorMessage: error.message));
      }
      rethrow;
    } catch (_) {
      const message = '콘텐츠 이름 수정에 실패했습니다.';
      if (!isClosed) {
        emit(state.copyWith(errorMessage: message));
      }
      throw const ServerException(500, message);
    }
  }

  Future<void> deleteItem(ContentManagementItem item) async {
    emit(state.copyWith(openedMenuItemId: null));
    try {
      await _deleteContent(item.contentId);
      if (isClosed) {
        return;
      }
      final nextItems = state.items
          .where((content) => content.contentId != item.contentId)
          .toList(growable: false);
      emit(
        state.copyWith(
          items: nextItems,
          totalCount: (state.totalCount - 1).clamp(0, state.totalCount),
        ),
      );
    } catch (_) {
      if (isClosed) {
        return;
      }
      emit(
        state.copyWith(
          errorMessage: '콘텐츠 삭제에 실패했습니다.',
        ),
      );
    }
  }

  Future<void> _load({
    required int page,
    required bool replace,
    bool keepRefreshing = false,
  }) async {
    if (replace && !keepRefreshing) {
      emit(
        state.copyWith(
          isLoading: true,
          errorMessage: null,
          openedMenuItemId: null,
        ),
      );
    }
    try {
      final result = await _listContents(
        channel: state.filterChannel,
        sort: state.sort,
        page: page,
        size: pageSize,
      );
      if (isClosed) {
        return;
      }

      final mapped =
          result.contents.map(_toManagementItem).toList(growable: false);

      emit(
        state.copyWith(
          items: replace ? mapped : [...state.items, ...mapped],
          totalCount: result.totalCount,
          page: result.page,
          hasNext: result.hasNext,
          isLoading: false,
          isLoadingMore: false,
          isRefreshing: false,
          errorMessage: null,
        ),
      );
    } catch (_) {
      if (isClosed) {
        return;
      }
      emit(
        state.copyWith(
          isLoading: false,
          isLoadingMore: false,
          isRefreshing: false,
          errorMessage: '콘텐츠 목록을 불러오지 못했습니다.',
        ),
      );
    }
  }

  static ContentManagementItem _toManagementItem(ContentListItem listItem) {
    final ordered = ContentLabelMapper.orderedChannels(listItem.channels);
    return ContentManagementItem(
      contentId: listItem.contentId,
      date: _formatDate(listItem.savedAt),
      channel: ContentLabelMapper.channelsJoined(ordered),
      initialChannel: ordered.isEmpty ? null : ordered.first,
      category: ContentLabelMapper.purpose(listItem.purpose),
      tone: ContentLabelMapper.tone(listItem.tone),
      name: listItem.name,
      tags: listItem.hashtags,
    );
  }

  static String _formatDate(DateTime date) {
    final year = (date.year % 100).toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '$year.$month.$day.';
  }
}
