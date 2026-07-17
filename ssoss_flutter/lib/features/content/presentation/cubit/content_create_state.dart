import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:ssoss_flutter/features/content/domain/entities/content_tone.dart';
import 'package:ssoss_flutter/features/content/domain/entities/upload_channel.dart';
import 'package:ssoss_flutter/features/content/domain/entities/upload_purpose.dart';

part 'content_create_state.freezed.dart';

enum ContentCreateStep {
  channel,
  content,
  detail,
}

@freezed
abstract class ContentCreateState with _$ContentCreateState {
  const ContentCreateState._();

  const factory ContentCreateState({
    @Default(ContentCreateStep.channel) ContentCreateStep step,
    @Default(<UploadChannel>[]) List<UploadChannel> channels,
    UploadPurpose? purpose,
    ContentTone? tone,
    @Default('') String highlight,
    @Default('') String forbidden,
    @Default(<String>[]) List<String> keywords,
    @Default(false) bool photoGuideEnabled,
    String? errorMessage,
  }) = _ContentCreateState;

  bool get canGoNextFromChannel => channels.isNotEmpty;

  bool get canGoNextFromContent => purpose != null && tone != null;

  bool get canSubmit => highlight.trim().isNotEmpty;
}
