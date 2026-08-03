import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ssoss_flutter/core/constants/writing_tone.dart';
import 'package:ssoss_flutter/features/content/domain/entities/content_create_input.dart';
import 'package:ssoss_flutter/features/content/domain/entities/upload_channel.dart';
import 'package:ssoss_flutter/features/content/domain/entities/upload_purpose.dart';

class ContentOtherChannelCreateState {
  const ContentOtherChannelCreateState({
    required this.availableChannels,
    this.selected = const [],
  });

  final List<UploadChannel> availableChannels;
  final List<UploadChannel> selected;

  bool get canSubmit => selected.isNotEmpty;

  bool get isAllSelected =>
      availableChannels.isNotEmpty &&
      availableChannels.every(selected.contains);

  ContentOtherChannelCreateState copyWith({
    List<UploadChannel>? availableChannels,
    List<UploadChannel>? selected,
  }) {
    return ContentOtherChannelCreateState(
      availableChannels: availableChannels ?? this.availableChannels,
      selected: selected ?? this.selected,
    );
  }
}

class ContentOtherChannelCreateCubit
    extends Cubit<ContentOtherChannelCreateState> {
  ContentOtherChannelCreateCubit({
    required String sourceContentId,
    required List<UploadChannel> excludedChannels,
    ContentCreateInput? previousInput,
    List<UploadChannel> initialSelected = const [],
  })  : _sourceContentId = sourceContentId,
        _previousInput = previousInput,
        super(
          ContentOtherChannelCreateState(
            availableChannels: UploadChannel.values
                .where((channel) => !excludedChannels.contains(channel))
                .toList(growable: false),
            selected: initialSelected
                .where((channel) => !excludedChannels.contains(channel))
                .toList(growable: false),
          ),
        );

  final String _sourceContentId;
  final ContentCreateInput? _previousInput;

  String get sourceContentId => _sourceContentId;

  void toggleChannel(UploadChannel channel) {
    if (!state.availableChannels.contains(channel)) {
      return;
    }
    final current = List<UploadChannel>.of(state.selected);
    if (current.contains(channel)) {
      current.remove(channel);
    } else {
      current.add(channel);
    }
    emit(state.copyWith(selected: current));
  }

  void toggleSelectAll() {
    if (state.isAllSelected) {
      emit(state.copyWith(selected: const []));
      return;
    }
    emit(
      state.copyWith(
        selected: List<UploadChannel>.of(state.availableChannels),
      ),
    );
  }

  /// 이전 생성 입력 + 선택 채널 + sourceContentId로 생성 입력을 만든다.
  ContentCreateInput? buildCreateInput() {
    if (!state.canSubmit) {
      return null;
    }

    final previous = _previousInput;
    if (previous != null) {
      return ContentCreateInput(
        channels: List<UploadChannel>.unmodifiable(state.selected),
        purpose: previous.purpose,
        tone: previous.tone,
        highlight: previous.highlight,
        forbidden: previous.forbidden,
        keywords: List<String>.unmodifiable(previous.keywords),
        photoGuideEnabled: previous.photoGuideEnabled,
        sourceContentId: _sourceContentId,
      );
    }

    // 상세 등 previousInput이 없는 진입: sourceContentId만 넘기고 기본값 사용.
    return ContentCreateInput(
      channels: List<UploadChannel>.unmodifiable(state.selected),
      purpose: UploadPurpose.informative,
      tone: WritingTone.daily,
      highlight: 'source-content',
      sourceContentId: _sourceContentId,
    );
  }
}
