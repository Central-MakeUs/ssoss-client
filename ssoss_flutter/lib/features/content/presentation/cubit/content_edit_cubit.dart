import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ssoss_flutter/common/widgets/card/content-edit/ssoss_contents_edit_document.dart';
import 'package:ssoss_flutter/common/widgets/input/ssoss_hashtag_input.dart';
import 'package:ssoss_flutter/features/content/domain/entities/content_channel_limits.dart';
import 'package:ssoss_flutter/features/content/domain/entities/upload_channel.dart';
import 'package:ssoss_flutter/features/content/presentation/cubit/content_edit_state.dart';
import 'package:ssoss_flutter/features/content/presentation/models/content_edit_args.dart';
import 'package:ssoss_flutter/features/content/presentation/models/content_edit_result.dart';
import 'package:ssoss_flutter/features/content/presentation/models/content_edit_target.dart';
import 'package:ssoss_flutter/features/content/presentation/models/content_photo_guide_display.dart';
import 'package:ssoss_flutter/utils/photo_guide_parser.dart';

class ContentEditCubit extends Cubit<ContentEditState> {
  ContentEditCubit({
    required ContentEditArgs args,
  })  : channel = args.channel,
        originalPhotoGuides = List<PhotoGuidePlacement>.of(args.photoGuides),
        managesPhotoGuide = args.photoGuides.isNotEmpty &&
            args.target == ContentEditTarget.body,
        super(_initialState(args));

  final UploadChannel channel;
  final List<PhotoGuidePlacement> originalPhotoGuides;

  /// 본문 편집에서 추천사진 블록을 다루는 경우 true.
  final bool managesPhotoGuide;

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
        final includeGuide = args.photoGuides.isNotEmpty;
        final document = includeGuide
            ? SsossContentsEditDocument.fromPlainText(
                plainText: args.initialBody,
                anchors: photoGuideEditAnchors(
                  args.photoGuides,
                  dismissible: true,
                ),
              )
            : SsossContentsEditDocument.fromPlainText(
                plainText: args.initialBody,
              );
        final tags = SsossHashtagNormalizer.stripAll(args.initialHashtags);
        return ContentEditState(
          target: args.target,
          document: document,
          originalPlainText: document.plainText,
          originalRecommendationIds:
              document.recommendationAnchors.map((a) => a.id).toList(),
          hashtags: tags,
          originalHashtags: List<String>.of(tags),
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
        final document = state.document;
        if (document == null) {
          return;
        }
        emit(state.copyWith(document: document.reset()));
      case ContentEditTarget.body:
        final document = state.document;
        if (document == null) {
          return;
        }
        emit(
          state.copyWith(
            document: document.reset(),
            hashtags: List<String>.of(state.originalHashtags),
          ),
        );
    }
  }

  bool get canSubmit => state.isDirty && _isWithinLimit;

  bool get _isWithinLimit {
    switch (state.target) {
      case ContentEditTarget.title:
        final length = state.document?.plainText.length ?? 0;
        final max = ContentChannelLimits.titleMaxLength(channel);
        return max == null || length <= max;
      case ContentEditTarget.body:
        final length = state.document?.plainText.length ?? 0;
        return length <= ContentChannelLimits.bodyMaxLength(channel);
      case ContentEditTarget.hashtags:
        return true;
    }
  }

  ContentEditResult? buildResult() {
    if (!canSubmit) {
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
        final photoGuides = managesPhotoGuide && document != null
            ? photoGuidesFromAnchors(
                document.recommendationAnchors,
                original: originalPhotoGuides,
              )
            : (managesPhotoGuide ? const <PhotoGuidePlacement>[] : null);
        return ContentEditResult(
          channel: channel,
          target: state.target,
          body: document?.plainText ?? '',
          photoGuides: photoGuides,
          hashtags: channel == UploadChannel.blog
              ? List<String>.of(state.hashtags)
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
        return ContentChannelLimits.titleMaxLength(channel) ?? 0;
      case ContentEditTarget.body:
        return ContentChannelLimits.bodyMaxLength(channel);
      case ContentEditTarget.hashtags:
        return SsossHashtagLimits.maxLength;
    }
  }
}
