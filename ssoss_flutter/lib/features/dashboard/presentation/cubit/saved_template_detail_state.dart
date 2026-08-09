import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:ssoss_flutter/features/template/domain/entities/saved_template_detail.dart';

part 'saved_template_detail_state.freezed.dart';

@freezed
abstract class SavedTemplateDetailState with _$SavedTemplateDetailState {
  const factory SavedTemplateDetailState({
    SavedTemplateDetail? detail,
    @Default(true) bool isLoading,
    String? errorMessage,
  }) = _SavedTemplateDetailState;
}
