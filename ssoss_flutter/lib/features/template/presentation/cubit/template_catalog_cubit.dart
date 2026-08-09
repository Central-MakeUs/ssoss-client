import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ssoss_flutter/features/template/domain/entities/recommended_template.dart';
import 'package:ssoss_flutter/features/template/domain/entities/recommended_template_category.dart';
import 'package:ssoss_flutter/features/template/domain/usecases/bookmark_template_usecase.dart';
import 'package:ssoss_flutter/features/template/domain/usecases/list_templates_usecase.dart';
import 'package:ssoss_flutter/features/template/domain/usecases/unbookmark_template_usecase.dart';
import 'package:ssoss_flutter/features/template/presentation/cubit/template_catalog_state.dart';

class TemplateCatalogCubit extends Cubit<TemplateCatalogState> {
  TemplateCatalogCubit({
    required ListTemplatesUseCase listTemplates,
    required BookmarkTemplateUseCase bookmarkTemplate,
    required UnbookmarkTemplateUseCase unbookmarkTemplate,
    RecommendedTemplateCategory? initialCategory,
  })  : _listTemplates = listTemplates,
        _bookmarkTemplate = bookmarkTemplate,
        _unbookmarkTemplate = unbookmarkTemplate,
        super(TemplateCatalogState(category: initialCategory));

  static const int pageSize = 20;

  final ListTemplatesUseCase _listTemplates;
  final BookmarkTemplateUseCase _bookmarkTemplate;
  final UnbookmarkTemplateUseCase _unbookmarkTemplate;

  Future<void> loadInitial() async {
    if (state.isLoading) {
      return;
    }
    await _load(page: 0, replace: true);
  }

  Future<void> refresh() {
    if (state.isLoading) {
      return Future.value();
    }
    return _load(page: 0, replace: true, keepRefreshing: true);
  }

  Future<void> selectCategory(RecommendedTemplateCategory? category) async {
    if (state.category == category && state.hasLoaded) {
      return;
    }
    emit(state.copyWith(category: category));
    await _load(page: 0, replace: true);
  }

  Future<void> search(String keyword) async {
    final trimmed = keyword.trim();
    if (trimmed == state.keyword && state.hasLoaded) {
      return;
    }
    emit(state.copyWith(keyword: trimmed));
    await _load(page: 0, replace: true);
  }

  Future<void> loadMore() async {
    if (!state.hasNext || state.isLoadingMore || state.isLoading) {
      return;
    }
    emit(state.copyWith(isLoadingMore: true, errorMessage: null));
    await _load(page: state.page + 1, replace: false);
  }

  Future<bool> toggleBookmark(int templateId) async {
    if (state.pendingBookmarkIds.contains(templateId)) {
      return false;
    }

    final index = state.items.indexWhere((item) => item.id == templateId);
    if (index < 0) {
      return false;
    }

    final current = state.items[index];
    final nextBookmarked = !current.bookmarked;
    final previousItems = state.items;

    emit(
      state.copyWith(
        items: _replaceItem(
          previousItems,
          current.copyWith(bookmarked: nextBookmarked),
        ),
        pendingBookmarkIds: {...state.pendingBookmarkIds, templateId},
        errorMessage: null,
      ),
    );

    try {
      if (nextBookmarked) {
        await _bookmarkTemplate(templateId);
      } else {
        await _unbookmarkTemplate(templateId);
      }
      if (isClosed) {
        return true;
      }
      emit(
        state.copyWith(
          pendingBookmarkIds: _withoutPending(templateId),
        ),
      );
      return true;
    } catch (_) {
      if (isClosed) {
        return false;
      }
      emit(
        state.copyWith(
          items: previousItems,
          pendingBookmarkIds: _withoutPending(templateId),
        ),
      );
      return false;
    }
  }

  Set<int> _withoutPending(int templateId) {
    return {...state.pendingBookmarkIds}..remove(templateId);
  }

  List<RecommendedTemplate> _replaceItem(
    List<RecommendedTemplate> items,
    RecommendedTemplate updated,
  ) {
    return [
      for (final item in items)
        if (item.id == updated.id) updated else item,
    ];
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
        ),
      );
    }

    try {
      final keyword = state.keyword.isEmpty ? null : state.keyword;
      final result = await _listTemplates(
        category: state.category,
        keyword: keyword,
        page: page,
        size: pageSize,
      );
      if (isClosed) {
        return;
      }
      emit(
        state.copyWith(
          items: replace
              ? result.templates
              : [...state.items, ...result.templates],
          page: result.page,
          hasNext: result.hasNext,
          hasLoaded: true,
          isLoading: false,
          isLoadingMore: false,
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
          errorMessage: '템플릿을 불러오지 못했습니다.',
        ),
      );
    }
  }
}
