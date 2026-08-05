import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:ssoss_flutter/features/content/domain/entities/upload_channel.dart';

part 'new_style_channel_state.freezed.dart';

@freezed
abstract class NewStyleChannelState with _$NewStyleChannelState {
  const NewStyleChannelState._();

  const factory NewStyleChannelState({
    @Default(<UploadChannel>[]) List<UploadChannel> channels,
  }) = _NewStyleChannelState;

  bool get canGoNext => channels.isNotEmpty;
}
