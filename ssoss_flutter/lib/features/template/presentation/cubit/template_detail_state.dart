import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:ssoss_flutter/features/template/domain/entities/recommended_template_detail.dart';

part 'template_detail_state.freezed.dart';

@freezed
abstract class TemplateDetailState with _$TemplateDetailState {
  const factory TemplateDetailState({
    RecommendedTemplateDetail? detail,
    @Default(true) bool isLoading,
    @Default(false) bool isApplying,
    @Default(false) bool isTogglingBookmark,
    String? errorMessage,
  }) = _TemplateDetailState;
}
