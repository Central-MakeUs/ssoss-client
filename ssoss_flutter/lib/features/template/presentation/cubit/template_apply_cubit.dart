import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ssoss_flutter/core/exception/app_exception.dart';
import 'package:ssoss_flutter/features/template/domain/usecases/save_template_usecase.dart';
import 'package:ssoss_flutter/features/template/presentation/cubit/template_apply_state.dart';

class TemplateApplyCubit extends Cubit<TemplateApplyState> {
  TemplateApplyCubit({
    required SaveTemplateUseCase saveTemplate,
  })  : _saveTemplate = saveTemplate,
        super(const TemplateApplyState());

  static const int maxBodyLength = 2000;

  final SaveTemplateUseCase _saveTemplate;

  Future<bool> save({
    required int templateId,
    required String body,
  }) async {
    if (state.isSaving) {
      return false;
    }

    if (body.trim().isEmpty) {
      emit(state.copyWith(errorMessage: '본문을 입력해 주세요'));
      return false;
    }
    if (body.length > maxBodyLength) {
      emit(
        state.copyWith(errorMessage: '본문은 2000자 이내로 입력해 주세요'),
      );
      return false;
    }

    emit(state.copyWith(isSaving: true, errorMessage: null));
    try {
      await _saveTemplate(templateId: templateId, body: body);
      if (isClosed) {
        return false;
      }
      emit(state.copyWith(isSaving: false));
      return true;
    } on AppException catch (error) {
      if (isClosed) {
        return false;
      }
      emit(
        state.copyWith(
          isSaving: false,
          errorMessage: error.message,
        ),
      );
      return false;
    } catch (_) {
      if (isClosed) {
        return false;
      }
      emit(
        state.copyWith(
          isSaving: false,
          errorMessage: '템플릿을 저장하지 못했습니다.',
        ),
      );
      return false;
    }
  }

  void clearError() {
    if (state.errorMessage == null) {
      return;
    }
    emit(state.copyWith(errorMessage: null));
  }
}
