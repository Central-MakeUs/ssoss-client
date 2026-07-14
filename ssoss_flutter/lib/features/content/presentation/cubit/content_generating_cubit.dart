import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ssoss_flutter/core/exception/app_exception.dart';
import 'package:ssoss_flutter/features/content/domain/entities/content_create_input.dart';
import 'package:ssoss_flutter/features/content/domain/repositories/content_repository.dart';
import 'package:ssoss_flutter/features/content/domain/usecases/create_content_usecase.dart';
import 'package:ssoss_flutter/features/content/presentation/cubit/content_generating_state.dart';

class ContentGeneratingCubit extends Cubit<ContentGeneratingState> {
  ContentGeneratingCubit({
    required CreateContentUseCase createContentUseCase,
    required ContentRepository contentRepository,
  })  : _createContent = createContentUseCase,
        _repository = contentRepository,
        super(const ContentGeneratingState.loading());

  final CreateContentUseCase _createContent;
  final ContentRepository _repository;

  Future<void> start(ContentCreateInput input) async {
    emit(const ContentGeneratingState.loading());
    try {
      final result = await _createContent(input);
      if (isClosed) {
        return;
      }
      emit(ContentGeneratingState.success(result.contentId));
    } on CancelledException {
      // 나가기로 취소
    } on AppException catch (e) {
      if (isClosed) {
        return;
      }
      emit(ContentGeneratingState.failure(e.message));
    } catch (_) {
      if (isClosed) {
        return;
      }
      emit(
        const ContentGeneratingState.failure('콘텐츠 생성에 실패했습니다.'),
      );
    }
  }

  void cancel() {
    _repository.cancelCreate();
  }
}
