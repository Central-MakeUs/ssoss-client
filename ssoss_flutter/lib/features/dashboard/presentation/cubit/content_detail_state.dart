import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:ssoss_flutter/features/content/domain/entities/content_detail.dart';

part 'content_detail_state.freezed.dart';

@freezed
abstract class ContentDetailState with _$ContentDetailState {
  const factory ContentDetailState({
    ContentDetail? detail,
    @Default(true) bool isLoading,
    @Default(false) bool didMutate,
    String? errorMessage,
  }) = _ContentDetailState;
}
