import 'package:freezed_annotation/freezed_annotation.dart';

part 'content_generating_state.freezed.dart';

@freezed
abstract class ContentGeneratingState with _$ContentGeneratingState {
  const factory ContentGeneratingState.loading() = _Loading;
  const factory ContentGeneratingState.success(String contentId) = _Success;
  const factory ContentGeneratingState.failure(String message) = _Failure;
}
