import 'package:ssoss_flutter/common/widgets/input/ssoss_hashtag_input.dart';
import 'package:ssoss_flutter/features/content/domain/entities/generation_channel_result.dart';
import 'package:ssoss_flutter/features/content/domain/entities/upload_channel.dart';
import 'package:ssoss_flutter/features/content/presentation/models/content_edit_result.dart';
import 'package:ssoss_flutter/features/content/presentation/models/content_edit_target.dart';
import 'package:ssoss_flutter/utils/photo_guide_parser.dart';

/// 편집 결과 + 초기값을 채널 단위 완전체로 합친다.
GenerationChannelResult mergeEditToChannelResult({
  required UploadChannel channel,
  required String initialTitle,
  required String initialBody,
  required List<String> initialHashtags,
  required ContentEditResult editResult,
  List<PhotoGuidePlacement> initialPhotoGuides = const [],
}) {
  var title = initialTitle;
  var body = initialBody;
  var hashtags = List<String>.of(initialHashtags);
  var photoGuides = List<PhotoGuidePlacement>.of(initialPhotoGuides);

  switch (editResult.target) {
    case ContentEditTarget.title:
      title = editResult.title ?? title;
    case ContentEditTarget.body:
      body = editResult.body ?? body;
      if (editResult.photoGuides != null) {
        photoGuides = List<PhotoGuidePlacement>.of(editResult.photoGuides!);
      }
      if (editResult.hashtags != null) {
        hashtags = List<String>.of(editResult.hashtags!);
      }
    case ContentEditTarget.hashtags:
      hashtags = editResult.hashtags ?? hashtags;
  }

  final trimmed = title.trim();
  final saveTitle = channel == UploadChannel.blog
      ? (trimmed.isEmpty ? null : trimmed)
      : null;

  return GenerationChannelResult(
    channel: channel,
    title: saveTitle,
    body: PhotoGuideParser.serialize(
      body,
      placements: photoGuides,
    ),
    hashtags: [
      for (final tag in hashtags) SsossHashtagNormalizer.display(tag),
    ],
  );
}
