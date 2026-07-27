import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:ssoss_flutter/features/content/domain/entities/generation_detail.dart';

part 'content_generating_state.freezed.dart';

@freezed
abstract class ContentGeneratingState with _$ContentGeneratingState {
  const factory ContentGeneratingState.loading() = _Loading;
  const factory ContentGeneratingState.success(GenerationDetail detail) =
      _Success;
  const factory ContentGeneratingState.failure({String? message}) = _Failure;
}
