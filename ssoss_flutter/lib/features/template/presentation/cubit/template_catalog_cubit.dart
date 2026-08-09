import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ssoss_flutter/features/template/domain/entities/recommended_template_category.dart';
import 'package:ssoss_flutter/features/template/domain/usecases/list_templates_usecase.dart';
import 'package:ssoss_flutter/features/template/presentation/cubit/template_catalog_state.dart';

class TemplateCatalogCubit extends Cubit<TemplateCatalogState> {
  TemplateCatalogCubit({
    required ListTemplatesUseCase listTemplates,
    RecommendedTemplateCategory? initialCategory,
  })  : _listTemplates = listTemplates,
        super(TemplateCatalogState(category: initialCategory));

  static const int pageSize = 20;

  final ListTemplatesUseCase _listTemplates;

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

  Future<void> loadMore() async {
    if (!state.hasNext || state.isLoadingMore || state.isLoading) {
      return;
    }
    emit(state.copyWith(isLoadingMore: true, errorMessage: null));
    await _load(page: state.page + 1, replace: false);
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
      final result = await _listTemplates(
        category: state.category,
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
