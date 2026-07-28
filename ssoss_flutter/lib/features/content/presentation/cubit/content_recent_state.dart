import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:ssoss_flutter/features/content/presentation/models/content_recent_item.dart';

part 'content_recent_state.freezed.dart';

@freezed
abstract class ContentRecentState with _$ContentRecentState {
  const factory ContentRecentState({
    @Default(<ContentRecentItem>[]) List<ContentRecentItem> items,
    @Default(false) bool isLoading,
    String? errorMessage,
  }) = _ContentRecentState;
}
