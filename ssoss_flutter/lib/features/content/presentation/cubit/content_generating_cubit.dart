import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ssoss_flutter/core/exception/app_exception.dart';
import 'package:ssoss_flutter/features/content/domain/entities/channel_conversion_input.dart';
import 'package:ssoss_flutter/features/content/domain/entities/generation_status.dart';
import 'package:ssoss_flutter/features/content/domain/entities/style_reuse_input.dart';
import 'package:ssoss_flutter/features/content/domain/repositories/content_repository.dart';
import 'package:ssoss_flutter/features/content/domain/usecases/run_channel_conversion_generation_usecase.dart';
import 'package:ssoss_flutter/features/content/domain/usecases/run_generation_usecase.dart';
import 'package:ssoss_flutter/features/content/domain/usecases/run_style_reuse_generation_usecase.dart';
import 'package:ssoss_flutter/features/content/presentation/cubit/content_generating_state.dart';
import 'package:ssoss_flutter/features/content/presentation/models/content_create_flow.dart';
import 'package:ssoss_flutter/features/content/presentation/models/content_generation_args.dart';

class ContentGeneratingCubit extends Cubit<ContentGeneratingState> {
  ContentGeneratingCubit({
    required RunGenerationUseCase runGeneration,
    required RunStyleReuseGenerationUseCase runStyleReuseGeneration,
    required RunChannelConversionGenerationUseCase runChannelConversion,
    required ContentRepository contentRepository,
  })  : _runGeneration = runGeneration,
        _runStyleReuseGeneration = runStyleReuseGeneration,
        _runChannelConversion = runChannelConversion,
        _repository = contentRepository,
        super(const ContentGeneratingState.loading());

  final RunGenerationUseCase _runGeneration;
  final RunStyleReuseGenerationUseCase _runStyleReuseGeneration;
  final RunChannelConversionGenerationUseCase _runChannelConversion;
  final ContentRepository _repository;

  Future<void> start(ContentGenerationArgs args) async {
    emit(const ContentGeneratingState.loading());
    try {
      final detail = switch (args.flow) {
        ContentCreateFlow.styleReuse =>
          await _runStyleReuseGeneration(_styleReuseInputFrom(args)),
        ContentCreateFlow.otherChannel =>
          await _runChannelConversion(_channelConversionInputFrom(args)),
        ContentCreateFlow.initial => await _runGeneration(args.input),
      };
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

  StyleReuseInput _styleReuseInputFrom(ContentGenerationArgs args) {
    final channelId = args.styleReuseContentChannelId;
    final contentId = int.tryParse(args.input.sourceContentId ?? '');
    if (channelId == null || contentId == null) {
      throw const ValidationException('스타일 재사용 정보가 올바르지 않습니다.');
    }
    return StyleReuseInput(
      contentId: contentId,
      contentChannelId: channelId,
      highlight: args.input.highlight,
      forbidden: args.input.forbidden,
      keywords: args.input.keywords,
      photoGuideEnabled: args.input.photoGuideEnabled,
    );
  }

  ChannelConversionInput _channelConversionInputFrom(
    ContentGenerationArgs args,
  ) {
    final channelId = args.conversionContentChannelId;
    final contentId = int.tryParse(args.input.sourceContentId ?? '');
    if (channelId == null || contentId == null) {
      throw const ValidationException('다른 채널용 생성 정보가 올바르지 않습니다.');
    }
    return ChannelConversionInput(
      contentId: contentId,
      contentChannelId: channelId,
      channels: args.input.channels,
    );
  }

  void cancel() {
    _repository.cancelGeneration();
  }
}
