import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ssoss_flutter/core/exception/app_exception.dart';
import 'package:ssoss_flutter/features/dashboard/presentation/cubit/saved_template_management_state.dart';
import 'package:ssoss_flutter/features/dashboard/presentation/pages/content_generation_management/content_generation_management_components.dart';
import 'package:ssoss_flutter/features/template/domain/entities/saved_template_list_item.dart';
import 'package:ssoss_flutter/features/template/domain/entities/saved_template_sort.dart';
import 'package:ssoss_flutter/features/template/domain/usecases/delete_saved_template_usecase.dart';
import 'package:ssoss_flutter/features/template/domain/usecases/list_saved_templates_usecase.dart';
import 'package:ssoss_flutter/features/template/domain/usecases/rename_saved_template_usecase.dart';
import 'package:ssoss_flutter/features/template/presentation/util/template_label_mapper.dart';

class SavedTemplateManagementCubit extends Cubit<SavedTemplateManagementState> {
  SavedTemplateManagementCubit({
    required ListSavedTemplatesUseCase listSavedTemplates,
    required RenameSavedTemplateUseCase renameSavedTemplate,
    required DeleteSavedTemplateUseCase deleteSavedTemplate,
  })  : _listSavedTemplates = listSavedTemplates,
        _renameSavedTemplate = renameSavedTemplate,
        _deleteSavedTemplate = deleteSavedTemplate,
        super(const SavedTemplateManagementState());

  static const int pageSize = 10;
  static const int minTitleLength = 2;
  static const int maxTitleLength = 20;

  final ListSavedTemplatesUseCase _listSavedTemplates;
  final RenameSavedTemplateUseCase _renameSavedTemplate;
  final DeleteSavedTemplateUseCase _deleteSavedTemplate;

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

  Future<void> renameItem(
    SavedContentTemplateManagementItem item,
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
      final detail = await _renameSavedTemplate(
        savedTemplateId: item.savedTemplateId,
        title: trimmed,
      );
      if (isClosed) {
        return;
      }
      emit(
        state.copyWith(
          items: state.items
              .map(
                (current) => current.savedTemplateId == item.savedTemplateId
                    ? current.copyWith(title: detail.title)
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
      const message = '템플릿 이름 수정에 실패했습니다.';
      if (!isClosed) {
        emit(state.copyWith(errorMessage: message));
      }
      throw const ServerException(500, message);
    }
  }

  Future<void> deleteItem(SavedContentTemplateManagementItem item) async {
    emit(state.copyWith(openedMenuItemId: null, errorMessage: null));
    try {
      await _deleteSavedTemplate(item.savedTemplateId);
      if (isClosed) {
        return;
      }
      emit(
        state.copyWith(
          items: state.items
              .where(
                (current) => current.savedTemplateId != item.savedTemplateId,
              )
              .toList(growable: false),
          totalCount: (state.totalCount - 1).clamp(0, state.totalCount),
        ),
      );
    } on AppException catch (error) {
      if (!isClosed) {
        emit(state.copyWith(errorMessage: error.message));
      }
      rethrow;
    } catch (_) {
      const message = '저장한 템플릿 삭제에 실패했습니다.';
      if (!isClosed) {
        emit(state.copyWith(errorMessage: message));
      }
      throw const ServerException(500, message);
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
