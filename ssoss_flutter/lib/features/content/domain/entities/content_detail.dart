import 'package:ssoss_flutter/features/content/domain/entities/content_channel_content.dart';
import 'package:ssoss_flutter/features/content/domain/entities/content_tone.dart';
import 'package:ssoss_flutter/features/content/domain/entities/upload_purpose.dart';

/// 저장 콘텐츠 상세.
class ContentDetail {
  const ContentDetail({
    required this.contentId,
    required this.purpose,
    required this.tone,
    required this.keywords,
    required this.contents,
  });

  final int contentId;
  final UploadPurpose purpose;
  final ContentTone tone;
  final List<String> keywords;
  final List<ContentChannelContent> contents;
}
