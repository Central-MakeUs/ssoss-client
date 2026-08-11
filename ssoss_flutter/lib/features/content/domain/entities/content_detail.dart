import 'package:ssoss_flutter/features/content/domain/entities/content_channel_content.dart';
import 'package:ssoss_flutter/core/constants/writing_tone.dart';
import 'package:ssoss_flutter/features/content/domain/entities/upload_purpose.dart';

/// 저장 콘텐츠 상세.
class ContentDetail {
  const ContentDetail({
    required this.contentId,
    this.name = '',
    required this.purpose,
    required this.tone,
    required this.keywords,
    required this.contents,
  });

  final int contentId;

  /// 목록 카드·상세에 표시되는 콘텐츠 이름.
  final String name;
  final UploadPurpose purpose;
  final WritingTone tone;
  final List<String> keywords;
  final List<ContentChannelContent> contents;
}
