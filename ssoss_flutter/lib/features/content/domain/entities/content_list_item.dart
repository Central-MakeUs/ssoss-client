import 'package:ssoss_flutter/core/constants/writing_tone.dart';
import 'package:ssoss_flutter/features/content/domain/entities/upload_channel.dart';
import 'package:ssoss_flutter/features/content/domain/entities/upload_purpose.dart';

/// 저장 콘텐츠 목록 카드 1건.
class ContentListItem {
  const ContentListItem({
    required this.contentId,
    required this.name,
    required this.savedAt,
    required this.channels,
    required this.purpose,
    required this.tone,
    required this.title,
    required this.hashtags,
  });

  final int contentId;

  /// 목록 카드에 표시되는 콘텐츠 이름. 채널 편집과 무관하게 유지된다.
  final String name;
  final DateTime savedAt;
  final List<UploadChannel> channels;
  final UploadPurpose purpose;
  final WritingTone tone;

  /// 첫 채널 제목 미리보기. 채널 편집 시 함께 바뀐다.
  final String title;
  final List<String> hashtags;
}
