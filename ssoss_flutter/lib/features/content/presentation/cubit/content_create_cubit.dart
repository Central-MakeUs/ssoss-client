import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ssoss_flutter/common/widgets/input/ssoss_hashtag_input.dart';
import 'package:ssoss_flutter/core/constants/writing_tone.dart';
import 'package:ssoss_flutter/features/content/domain/entities/content_create_input.dart';
import 'package:ssoss_flutter/features/content/domain/entities/content_create_prefill.dart';
import 'package:ssoss_flutter/features/content/domain/entities/upload_channel.dart';
import 'package:ssoss_flutter/features/content/domain/entities/upload_purpose.dart';
import 'package:ssoss_flutter/features/content/presentation/cubit/content_create_state.dart';

class ContentCreateCubit extends Cubit<ContentCreateState> {
  ContentCreateCubit({
    UploadChannel? initialChannel,
    ContentCreateInput? restoredInput,
    ContentCreatePrefill? prefill,
  }) : super(
          _initialState(
            initialChannel: initialChannel,
            restoredInput: restoredInput,
            prefill: prefill,
          ),
        );

  static ContentCreateState _initialState({
    UploadChannel? initialChannel,
    ContentCreateInput? restoredInput,
    ContentCreatePrefill? prefill,
  }) {
    if (restoredInput != null) {
      return ContentCreateState(
        step: ContentCreateStep.detail,
        channels: List<UploadChannel>.of(restoredInput.channels),
        purpose: restoredInput.purpose,
        tone: restoredInput.tone,
        highlight: restoredInput.highlight,
        forbidden: restoredInput.forbidden ?? '',
        keywords: List<String>.of(restoredInput.keywords),
        photoGuideEnabled: restoredInput.photoGuideEnabled,
      );
    }
    return ContentCreateState(
      channels: initialChannel != null
          ? <UploadChannel>[initialChannel]
          : const <UploadChannel>[],
      tone: prefill?.tone,
      forbidden: prefill?.forbidden ?? '',
      keywords: List<String>.of(prefill?.keywords ?? const <String>[]),
      // 채널 바로가기 진입 시 콘텐츠 설정(2단계)부터 시작
      step: initialChannel != null
          ? ContentCreateStep.content
          : ContentCreateStep.channel,
    );
  }

  void toggleChannel(UploadChannel channel) {
    final current = List<UploadChannel>.of(state.channels);
    if (current.contains(channel)) {
      current.remove(channel);
    } else {
      current.add(channel);
    }
    emit(state.copyWith(channels: current, errorMessage: null));
  }

  void selectPurpose(UploadPurpose purpose) {
    emit(state.copyWith(purpose: purpose, errorMessage: null));
  }

  void selectTone(WritingTone tone) {
    emit(state.copyWith(tone: tone, errorMessage: null));
  }

  void setHighlight(String value) {
    emit(state.copyWith(highlight: value, errorMessage: null));
  }

  void setForbidden(String value) {
    emit(state.copyWith(forbidden: value));
  }

  static const int maxKeywords = SsossHashtagLimits.maxCount;
  static const int maxKeywordLength = SsossHashtagLimits.maxLength;

  void addKeyword(String raw) {
    final text = SsossHashtagNormalizer.normalize(raw);
    if (text == null) {
      return;
    }
    if (state.keywords.contains(text)) {
      return;
    }
    if (state.keywords.length >= maxKeywords) {
      return;
    }
    emit(state.copyWith(keywords: [...state.keywords, text]));
  }

  void removeKeyword(String keyword) {
    emit(
      state.copyWith(
        keywords: state.keywords.where((k) => k != keyword).toList(),
      ),
    );
  }

  void togglePhotoGuide() {
    emit(state.copyWith(photoGuideEnabled: !state.photoGuideEnabled));
  }

  void goNext() {
    switch (state.step) {
      case ContentCreateStep.channel:
        if (!state.canGoNextFromChannel) {
          return;
        }
        emit(state.copyWith(step: ContentCreateStep.content));
      case ContentCreateStep.content:
        if (!state.canGoNextFromContent) {
          return;
        }
        emit(state.copyWith(step: ContentCreateStep.detail));
      case ContentCreateStep.detail:
        return;
    }
  }

  /// Returns `true` when the page should pop (already on first step).
  bool goBack() {
    switch (state.step) {
      case ContentCreateStep.channel:
        return true;
      case ContentCreateStep.content:
        emit(state.copyWith(step: ContentCreateStep.channel));
        return false;
      case ContentCreateStep.detail:
        emit(state.copyWith(step: ContentCreateStep.content));
        return false;
    }
  }

  /// 생성 화면으로 넘길 입력을 만든다. 유효하지 않으면 `null`.
  ContentCreateInput? buildCreateInput() {
    final current = state;
    if (!current.canSubmit ||
        current.channels.isEmpty ||
        current.purpose == null ||
        current.tone == null) {
      return null;
    }
    return ContentCreateInput(
      channels: List<UploadChannel>.unmodifiable(current.channels),
      purpose: current.purpose!,
      tone: current.tone!,
      highlight: current.highlight,
      forbidden: current.forbidden,
      keywords: current.keywords,
      photoGuideEnabled: current.photoGuideEnabled,
    );
  }
}
