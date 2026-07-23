import 'package:ssoss_flutter/features/content/domain/entities/upload_channel.dart';
import 'package:ssoss_flutter/features/content/presentation/models/content_edit_target.dart';

/// 편집 화면에서 결과 화면으로 넘기는 값.
class ContentEditResult {
  const ContentEditResult({
    required this.channel,
    required this.target,
    this.title,
    this.body,
    this.hashtags,
    this.photoGuidePresent,
  });

  final UploadChannel channel;
  final ContentEditTarget target;
  final String? title;
  final String? body;
  final List<String>? hashtags;

  /// 본문 편집 후 추천사진 블록이 남아 있는지. null이면 미변경.
  final bool? photoGuidePresent;
}
