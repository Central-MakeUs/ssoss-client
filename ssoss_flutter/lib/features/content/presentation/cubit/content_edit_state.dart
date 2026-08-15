import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ssoss_flutter/common/widgets/card/content-edit/ssoss_contents_edit_document.dart';
import 'package:ssoss_flutter/features/content/presentation/models/content_edit_target.dart';

part 'content_edit_state.freezed.dart';

@freezed
abstract class ContentEditState with _$ContentEditState {
  const ContentEditState._();

  const factory ContentEditState({
    required ContentEditTarget target,
    SsossContentsEditDocument? document,
    @Default(<String>[]) List<String> hashtags,
    @Default(<String>[]) List<String> originalHashtags,
    @Default('') String originalPlainText,
    @Default(<String>[]) List<String> originalRecommendationIds,
  }) = _ContentEditState;

  bool get isDirty {
    switch (target) {
      case ContentEditTarget.hashtags:
        return !listEquals(hashtags, originalHashtags);
      case ContentEditTarget.title:
      case ContentEditTarget.body:
        final doc = document;
        if (doc == null) {
          return false;
        }
        if (doc.plainText != originalPlainText) {
          return true;
        }
        final currentIds =
            doc.recommendationAnchors.map((anchor) => anchor.id).toList();
        return !listEquals(currentIds, originalRecommendationIds);
    }
  }

  bool get canSubmit => isDirty;
}
