import 'package:freezed_annotation/freezed_annotation.dart';

part 'content_state.freezed.dart';

@freezed
abstract class ContentState with _$ContentState {
  const factory ContentState.initial() = _Initial;
}
