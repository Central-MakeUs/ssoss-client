import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ssoss_flutter/features/content/domain/entities/content_create_input.dart';
import 'package:ssoss_flutter/features/content/domain/entities/upload_channel.dart';

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
    required ContentCreateInput baseInput,
    required List<UploadChannel> completedChannels,
  })  : _baseInput = baseInput,
        super(
          ContentOtherChannelCreateState(
            availableChannels: UploadChannel.values
                .where((channel) => !completedChannels.contains(channel))
                .toList(growable: false),
          ),
        );

  final ContentCreateInput _baseInput;

  ContentCreateInput get baseInput => _baseInput;

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

  ContentCreateInput? buildCreateInput() {
    if (!state.canSubmit) {
      return null;
    }
    return ContentCreateInput(
      channels: List<UploadChannel>.unmodifiable(state.selected),
      purpose: _baseInput.purpose,
      tone: _baseInput.tone,
      highlight: _baseInput.highlight,
      forbidden: _baseInput.forbidden,
      keywords: _baseInput.keywords,
      photoGuideEnabled: _baseInput.photoGuideEnabled,
    );
  }
}
