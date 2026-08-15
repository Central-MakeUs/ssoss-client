import 'package:freezed_annotation/freezed_annotation.dart';

part 'new_style_detail_state.freezed.dart';

@freezed
abstract class NewStyleDetailState with _$NewStyleDetailState {
  const NewStyleDetailState._();

  const factory NewStyleDetailState({
    @Default('') String highlight,
    @Default('') String forbidden,
    @Default(<String>[]) List<String> keywords,
    @Default(true) bool photoGuideEnabled,
  }) = _NewStyleDetailState;

  bool get canSubmit => highlight.trim().isNotEmpty;
}
