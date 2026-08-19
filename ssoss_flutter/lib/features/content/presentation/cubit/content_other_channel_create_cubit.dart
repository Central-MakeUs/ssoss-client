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

  bool get canSubmit => selected.isNotEmpty && selected.length <= 3;

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
    required int sourceContentChannelId,
    required List<UploadChannel> excludedChannels,
    List<UploadChannel> initialSelected = const [],
  })  : _sourceContentId = sourceContentId,
        _sourceContentChannelId = sourceContentChannelId,
        super(
          ContentOtherChannelCreateState(
            availableChannels: UploadChannel.values
                .where((channel) => !excludedChannels.contains(channel))
                .toList(growable: false),
            selected: initialSelected
                .where((channel) => !excludedChannels.contains(channel))
                .take(3)
                .toList(growable: false),
          ),
        );

  final String _sourceContentId;
  final int _sourceContentChannelId;

  String get sourceContentId => _sourceContentId;

  int get sourceContentChannelId => _sourceContentChannelId;

  void toggleChannel(UploadChannel channel) {
    if (!state.availableChannels.contains(channel)) {
      return;
    }
    final current = List<UploadChannel>.of(state.selected);
    if (current.contains(channel)) {
      current.remove(channel);
    } else {
      if (current.length >= 3) {
        return;
      }
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
        selected: state.availableChannels.take(3).toList(growable: false),
      ),
    );
  }

  /// generating route용 최소 input (채널 + 원본 contentId).
  ContentCreateInput? buildCreateInput() {
    if (!state.canSubmit) {
      return null;
    }

    return ContentCreateInput(
      channels: List<UploadChannel>.unmodifiable(state.selected),
      purpose: UploadPurpose.informative,
      tone: WritingTone.daily,
      highlight: '',
      sourceContentId: _sourceContentId,
    );
  }
}
