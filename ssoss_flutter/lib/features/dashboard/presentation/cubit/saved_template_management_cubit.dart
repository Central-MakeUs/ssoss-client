import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ssoss_flutter/features/dashboard/presentation/cubit/saved_template_management_state.dart';
import 'package:ssoss_flutter/features/dashboard/presentation/pages/content_generation_management/content_generation_management_components.dart';
import 'package:ssoss_flutter/features/template/domain/entities/saved_template_list_item.dart';
import 'package:ssoss_flutter/features/template/domain/entities/saved_template_sort.dart';
import 'package:ssoss_flutter/features/template/domain/usecases/list_saved_templates_usecase.dart';
import 'package:ssoss_flutter/features/template/presentation/util/template_label_mapper.dart';

class SavedTemplateManagementCubit extends Cubit<SavedTemplateManagementState> {
  SavedTemplateManagementCubit({
    required ListSavedTemplatesUseCase listSavedTemplates,
  })  : _listSavedTemplates = listSavedTemplates,
        super(const SavedTemplateManagementState());

  static const int pageSize = 10;

  final ListSavedTemplatesUseCase _listSavedTemplates;

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

  Future<void> toggleSort() async {
    if (state.isLoading) {
      return;
    }
    final nextSort = state.sort == SavedTemplateSort.latest
        ? SavedTemplateSort.oldest
        : SavedTemplateSort.latest;
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
      final result = await _listSavedTemplates(
        sort: state.sort,
        page: page,
        size: pageSize,
      );
      if (isClosed) {
        return;
      }

      final mapped =
          result.savedTemplates.map(_toManagementItem).toList(growable: false);

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
          errorMessage: '저장한 템플릿 목록을 불러오지 못했습니다.',
        ),
      );
    }
  }

  static SavedContentTemplateManagementItem _toManagementItem(
    SavedTemplateListItem listItem,
  ) {
    return SavedContentTemplateManagementItem(
      savedTemplateId: listItem.savedTemplateId,
      category: TemplateLabelMapper.category(listItem.category),
      title: listItem.title,
      description: listItem.description,
      date: _formatDate(listItem.savedAt),
    );
  }

  static String _formatDate(DateTime date) {
    final year = (date.year % 100).toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '$year.$month.$day.';
  }
}
