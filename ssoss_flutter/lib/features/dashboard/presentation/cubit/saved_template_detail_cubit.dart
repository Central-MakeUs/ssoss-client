import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ssoss_flutter/features/dashboard/presentation/cubit/saved_template_detail_state.dart';
import 'package:ssoss_flutter/features/template/domain/entities/saved_template_detail.dart';
import 'package:ssoss_flutter/features/template/domain/usecases/get_saved_template_usecase.dart';

class SavedTemplateDetailCubit extends Cubit<SavedTemplateDetailState> {
  SavedTemplateDetailCubit({
    required GetSavedTemplateUseCase getSavedTemplate,
    required this.savedTemplateId,
  })  : _getSavedTemplate = getSavedTemplate,
        super(const SavedTemplateDetailState());

  final GetSavedTemplateUseCase _getSavedTemplate;
  final int savedTemplateId;

  Future<void> load() async {
    emit(
      state.copyWith(
        isLoading: true,
        errorMessage: null,
      ),
    );
    try {
      final detail = await _getSavedTemplate(savedTemplateId);
      if (isClosed) {
        return;
      }
      emit(
        state.copyWith(
          detail: detail,
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
          errorMessage: '저장한 템플릿을 불러오지 못했습니다.',
        ),
      );
    }
  }

  void applyDetail(SavedTemplateDetail detail) {
    emit(
      state.copyWith(
        detail: detail,
        isLoading: false,
        errorMessage: null,
      ),
    );
  }
}
