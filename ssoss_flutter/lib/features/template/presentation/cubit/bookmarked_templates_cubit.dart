import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ssoss_flutter/features/template/domain/usecases/list_bookmarked_templates_usecase.dart';
import 'package:ssoss_flutter/features/template/domain/usecases/unbookmark_template_usecase.dart';
import 'package:ssoss_flutter/features/template/presentation/cubit/bookmarked_templates_state.dart';

class BookmarkedTemplatesCubit extends Cubit<BookmarkedTemplatesState> {
  BookmarkedTemplatesCubit({
    required ListBookmarkedTemplatesUseCase listBookmarkedTemplates,
    required UnbookmarkTemplateUseCase unbookmarkTemplate,
  })  : _listBookmarkedTemplates = listBookmarkedTemplates,
        _unbookmarkTemplate = unbookmarkTemplate,
        super(const BookmarkedTemplatesState());

  final ListBookmarkedTemplatesUseCase _listBookmarkedTemplates;
  final UnbookmarkTemplateUseCase _unbookmarkTemplate;

  Future<void> load() async {
    if (state.isLoading) {
      return;
    }
    emit(
      state.copyWith(
        isLoading: true,
        errorMessage: null,
      ),
    );

    try {
      final items = await _listBookmarkedTemplates();
      if (isClosed) {
        return;
      }
      emit(
        state.copyWith(
          items: items,
          hasLoaded: true,
          isLoading: false,
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
          errorMessage: '북마크한 템플릿을 불러오지 못했습니다.',
        ),
      );
    }
  }

  Future<void> ensureLoaded() async {
    if (state.hasLoaded || state.isLoading) {
      return;
    }
    await load();
  }

  /// 낙관적으로 목록에서 제거한 뒤 DELETE 호출.
  /// 성공 시 `true`, 실패 시 복원하고 `false`.
  Future<bool> unbookmark(int templateId) async {
    if (state.pendingUnbookmarkIds.contains(templateId)) {
      return false;
    }

    final index = state.items.indexWhere((item) => item.id == templateId);
    if (index < 0) {
      return false;
    }

    final previousItems = state.items;

    emit(
      state.copyWith(
        items: [
          for (final item in previousItems)
            if (item.id != templateId) item,
        ],
        pendingUnbookmarkIds: {...state.pendingUnbookmarkIds, templateId},
        errorMessage: null,
      ),
    );

    try {
      await _unbookmarkTemplate(templateId);
      if (isClosed) {
        return true;
      }
      emit(
        state.copyWith(
          pendingUnbookmarkIds: _withoutPending(templateId),
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
          pendingUnbookmarkIds: _withoutPending(templateId),
        ),
      );
      return false;
    }
  }

  Set<int> _withoutPending(int templateId) {
    return {...state.pendingUnbookmarkIds}..remove(templateId);
  }
}
