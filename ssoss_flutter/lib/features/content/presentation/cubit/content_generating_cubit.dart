import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ssoss_flutter/core/exception/app_exception.dart';
import 'package:ssoss_flutter/features/content/domain/entities/content_create_input.dart';
import 'package:ssoss_flutter/features/content/domain/entities/generation_status.dart';
import 'package:ssoss_flutter/features/content/domain/repositories/content_repository.dart';
import 'package:ssoss_flutter/features/content/domain/usecases/run_generation_usecase.dart';
import 'package:ssoss_flutter/features/content/presentation/cubit/content_generating_state.dart';

class ContentGeneratingCubit extends Cubit<ContentGeneratingState> {
  ContentGeneratingCubit({
    required RunGenerationUseCase runGeneration,
    required ContentRepository contentRepository,
  })  : _runGeneration = runGeneration,
        _repository = contentRepository,
        super(const ContentGeneratingState.loading());

  final RunGenerationUseCase _runGeneration;
  final ContentRepository _repository;

  Future<void> start(ContentCreateInput input) async {
    emit(const ContentGeneratingState.loading());
    try {
      final detail = await _runGeneration(input);
      if (isClosed) {
        return;
      }
      if (detail.status == GenerationStatus.failed) {
        emit(const ContentGeneratingState.failure());
        return;
      }
      emit(ContentGeneratingState.success(detail));
    } on CancelledException {
      // 나가기로 취소
    } on AppException catch (e) {
      if (isClosed) {
        return;
      }
      emit(ContentGeneratingState.failure(message: e.message));
    } catch (_) {
      if (isClosed) {
        return;
      }
      emit(
        const ContentGeneratingState.failure(
          message: '콘텐츠 생성에 실패했습니다.',
        ),
      );
    }
  }

  void cancel() {
    _repository.cancelGeneration();
  }
}
