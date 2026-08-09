import 'package:freezed_annotation/freezed_annotation.dart';

part 'template_apply_state.freezed.dart';

@freezed
abstract class TemplateApplyState with _$TemplateApplyState {
  const factory TemplateApplyState({
    @Default(false) bool isSaving,
    String? errorMessage,
  }) = _TemplateApplyState;
}
