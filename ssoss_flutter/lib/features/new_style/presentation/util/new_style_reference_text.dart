import 'package:ssoss_flutter/features/content/domain/entities/generation_channel_result.dart';
import 'package:ssoss_flutter/features/content/domain/entities/upload_channel.dart';

/// 채널 결과에서 참고 원문 추출. 블로그 → 제목(없으면 본문), 그 외 → 본문.
String newStyleReferenceRawText(GenerationChannelResult result) {
  if (result.channel == UploadChannel.blog) {
    final title = result.title?.trim();
    if (title != null && title.isNotEmpty) {
      return title;
    }
  }
  return result.body;
}
