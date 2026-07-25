import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ssoss_flutter/features/content/domain/entities/content_create_input.dart';
import 'package:ssoss_flutter/features/content/domain/entities/content_tone.dart';
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
  })  : _sourceContentId = sourceContentId,
        super(
          ContentOtherChannelCreateState(
            availableChannels: UploadChannel.values
                .where((channel) => !excludedChannels.contains(channel))
                .toList(growable: false),
          ),
        );

  final String _sourceContentId;

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

  /// 원문 콘텐츠 ID + 선택 채널로 생성 입력을 만든다.
  ///
  /// purpose/tone/highlight는 API가 원문에서 조회할 예정이며,
  /// 연동 전 더미 기본값을 채운다.
  ContentCreateInput? buildCreateInput() {
    if (!state.canSubmit) {
      return null;
    }
    return ContentCreateInput(
      channels: List<UploadChannel>.unmodifiable(state.selected),
      purpose: UploadPurpose.informative,
      tone: ContentTone.daily,
      highlight: 'source-content',
      sourceContentId: _sourceContentId,
    );
  }
}
