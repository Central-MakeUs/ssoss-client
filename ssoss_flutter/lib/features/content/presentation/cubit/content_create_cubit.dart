import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ssoss_flutter/features/content/domain/entities/content_create_input.dart';
import 'package:ssoss_flutter/features/content/domain/entities/content_tone.dart';
import 'package:ssoss_flutter/features/content/domain/entities/upload_channel.dart';
import 'package:ssoss_flutter/features/content/domain/entities/upload_purpose.dart';
import 'package:ssoss_flutter/features/content/presentation/cubit/content_create_state.dart';

class ContentCreateCubit extends Cubit<ContentCreateState> {
  ContentCreateCubit({
    UploadChannel? initialChannel,
  }) : super(
          ContentCreateState(
            channel: initialChannel,
            // 채널 바로가기 진입 시 콘텐츠 설정(2단계)부터 시작
            step: initialChannel != null
                ? ContentCreateStep.content
                : ContentCreateStep.channel,
          ),
        );

  void selectChannel(UploadChannel channel) {
    emit(state.copyWith(channel: channel, errorMessage: null));
  }

  void selectPurpose(UploadPurpose purpose) {
    emit(state.copyWith(purpose: purpose, errorMessage: null));
  }

  void selectTone(ContentTone tone) {
    emit(state.copyWith(tone: tone, errorMessage: null));
  }

  void setHighlight(String value) {
    emit(state.copyWith(highlight: value, errorMessage: null));
  }

  void setForbidden(String value) {
    emit(state.copyWith(forbidden: value));
  }

  static const int maxKeywords = 10;

  void addKeyword(String raw) {
    var text = raw.trim();
    if (text.startsWith('#')) {
      text = text.substring(1).trim();
    }
    if (text.isEmpty) {
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
        current.channel == null ||
        current.purpose == null ||
        current.tone == null) {
      return null;
    }
    return ContentCreateInput(
      channel: current.channel!,
      purpose: current.purpose!,
      tone: current.tone!,
      highlight: current.highlight,
      forbidden: current.forbidden,
      keywords: current.keywords,
      photoGuideEnabled: current.photoGuideEnabled,
    );
  }
}
