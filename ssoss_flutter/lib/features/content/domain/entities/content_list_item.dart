import 'package:ssoss_flutter/features/content/domain/entities/content_tone.dart';
import 'package:ssoss_flutter/features/content/domain/entities/upload_channel.dart';
import 'package:ssoss_flutter/features/content/domain/entities/upload_purpose.dart';

/// 저장 콘텐츠 목록 카드 1건.
class ContentListItem {
  const ContentListItem({
    required this.contentId,
    required this.savedAt,
    required this.channels,
    required this.purpose,
    required this.tone,
    required this.title,
    required this.hashtags,
  });

  final int contentId;
  final DateTime savedAt;
  final List<UploadChannel> channels;
  final UploadPurpose purpose;
  final ContentTone tone;
  final String title;
  final List<String> hashtags;
}
