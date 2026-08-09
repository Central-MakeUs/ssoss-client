import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ssoss_flutter/core/exception/app_exception.dart';
import 'package:ssoss_flutter/features/template/domain/entities/applied_template.dart';
import 'package:ssoss_flutter/features/template/domain/usecases/get_applied_template_usecase.dart';
import 'package:ssoss_flutter/features/template/domain/usecases/get_template_usecase.dart';
import 'package:ssoss_flutter/features/template/presentation/cubit/template_detail_state.dart';

class TemplateDetailCubit extends Cubit<TemplateDetailState> {
  TemplateDetailCubit({
    required GetTemplateUseCase getTemplate,
    required GetAppliedTemplateUseCase getAppliedTemplate,
    required this.templateId,
  })  : _getTemplate = getTemplate,
        _getAppliedTemplate = getAppliedTemplate,
        super(const TemplateDetailState());

  final GetTemplateUseCase _getTemplate;
  final GetAppliedTemplateUseCase _getAppliedTemplate;
  final int templateId;

  Future<void> load() async {
    emit(
      state.copyWith(
        isLoading: true,
        errorMessage: null,
      ),
    );
    try {
      final detail = await _getTemplate(templateId);
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
          errorMessage: '템플릿을 불러오지 못했습니다.',
        ),
      );
    }
  }

  Future<AppliedTemplate?> apply() async {
    if (state.detail == null || state.isApplying) {
      return null;
    }

    emit(state.copyWith(isApplying: true));
    try {
      final applied = await _getAppliedTemplate(templateId);
      if (isClosed) {
        return null;
      }
      emit(state.copyWith(isApplying: false));
      return applied;
    } on AppException {
      if (isClosed) {
        return null;
      }
      emit(state.copyWith(isApplying: false));
      rethrow;
    } catch (_) {
      if (isClosed) {
        return null;
      }
      emit(state.copyWith(isApplying: false));
      throw const ServerException(500, '템플릿을 적용하지 못했습니다.');
    }
  }
}
