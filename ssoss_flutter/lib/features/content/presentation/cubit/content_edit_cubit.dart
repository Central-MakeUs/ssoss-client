import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ssoss_flutter/common/widgets/card/content-edit/ssoss_contents_edit_document.dart';
import 'package:ssoss_flutter/common/widgets/card/ssoss_recommendation_card.dart';
import 'package:ssoss_flutter/common/widgets/input/ssoss_hashtag_input.dart';
import 'package:ssoss_flutter/features/content/domain/entities/upload_channel.dart';
import 'package:ssoss_flutter/features/content/presentation/cubit/content_edit_state.dart';
import 'package:ssoss_flutter/features/content/presentation/models/content_edit_args.dart';
import 'package:ssoss_flutter/features/content/presentation/models/content_edit_result.dart';
import 'package:ssoss_flutter/features/content/presentation/models/content_edit_target.dart';

class ContentEditCubit extends Cubit<ContentEditState> {
  ContentEditCubit({
    required ContentEditArgs args,
  })  : channel = args.channel,
        managesPhotoGuide = args.channel != UploadChannel.blog &&
            args.photoGuideEnabled &&
            args.recommendation != null,
        super(_initialState(args));

  final UploadChannel channel;

  /// 비블로그 본문 편집에서 추천사진 블록을 다루는 경우 true.
  final bool managesPhotoGuide;

  static const int titleMaxLength = 40;
  static const int bodyMaxLength = 5000;

  static ContentEditState _initialState(ContentEditArgs args) {
    switch (args.target) {
      case ContentEditTarget.title:
        final document = SsossContentsEditDocument.single(
          text: args.initialTitle,
        );
        return ContentEditState(
          target: args.target,
          document: document,
          originalPlainText: document.plainText,
        );
      case ContentEditTarget.body:
        final includeGuide = args.channel != UploadChannel.blog &&
            args.photoGuideEnabled &&
            args.recommendation != null;
        final recommendation = includeGuide
            ? SsossRecommendationCardItem(
                id: args.recommendation!.id,
                label: args.recommendation!.label,
                title: args.recommendation!.title,
                description: args.recommendation!.description,
                dismissible: true,
              )
            : null;
        final document = recommendation == null
            ? SsossContentsEditDocument.fromPlainText(
                plainText: args.initialBody,
              )
            : SsossContentsEditDocument.fromPlainText(
                plainText: args.initialBody,
                anchors: [
                  SsossContentsEditRecommendationAnchor(
                    offset: 0,
                    item: recommendation,
                  ),
                ],
              );
        return ContentEditState(
          target: args.target,
          document: document,
          originalPlainText: document.plainText,
          originalRecommendationIds:
              document.recommendationAnchors.map((a) => a.id).toList(),
        );
      case ContentEditTarget.hashtags:
        final tags = SsossHashtagNormalizer.stripAll(args.initialHashtags);
        return ContentEditState(
          target: args.target,
          hashtags: tags,
          originalHashtags: List<String>.of(tags),
        );
    }
  }

  void updateDocument(SsossContentsEditDocument document) {
    emit(state.copyWith(document: document));
  }

  /// 추가 성공 시 true. 한도·중복·형식 오류 시 false.
  bool addHashtag(String raw) {
    final normalized = SsossHashtagNormalizer.normalize(raw);
    if (normalized == null) {
      return false;
    }
    if (state.hashtags.contains(normalized)) {
      return false;
    }
    if (state.hashtags.length >= SsossHashtagLimits.maxCount) {
      return false;
    }
    emit(state.copyWith(hashtags: [...state.hashtags, normalized]));
    return true;
  }

  void removeHashtag(String tag) {
    emit(
      state.copyWith(
        hashtags: state.hashtags.where((item) => item != tag).toList(),
      ),
    );
  }

  void reset() {
    switch (state.target) {
      case ContentEditTarget.hashtags:
        emit(
          state.copyWith(
            hashtags: List<String>.of(state.originalHashtags),
          ),
        );
      case ContentEditTarget.title:
      case ContentEditTarget.body:
        final document = state.document;
        if (document == null) {
          return;
        }
        emit(state.copyWith(document: document.reset()));
    }
  }

  ContentEditResult? buildResult() {
    if (!state.canSubmit) {
      return null;
    }
    switch (state.target) {
      case ContentEditTarget.title:
        return ContentEditResult(
          channel: channel,
          target: state.target,
          title: state.document?.plainText ?? '',
        );
      case ContentEditTarget.body:
        final document = state.document;
        return ContentEditResult(
          channel: channel,
          target: state.target,
          body: document?.plainText ?? '',
          photoGuidePresent: managesPhotoGuide
              ? document != null && document.recommendationAnchors.isNotEmpty
              : null,
        );
      case ContentEditTarget.hashtags:
        return ContentEditResult(
          channel: channel,
          target: state.target,
          hashtags: List<String>.of(state.hashtags),
        );
    }
  }

  int get maxLength {
    switch (state.target) {
      case ContentEditTarget.title:
        return titleMaxLength;
      case ContentEditTarget.body:
        return bodyMaxLength;
      case ContentEditTarget.hashtags:
        return SsossHashtagLimits.maxLength;
    }
  }
}
