import 'package:ssoss_flutter/features/content/domain/entities/upload_channel.dart';

/// 저장 API 응답의 채널별 ID.
class SavedContentChannel {
  const SavedContentChannel({
    required this.contentChannelId,
    required this.channel,
  });

  final int contentChannelId;
  final UploadChannel channel;
}

/// 콘텐츠 저장 결과.
class SavedContent {
  const SavedContent({
    required this.contentId,
    required this.channels,
  });

  final int contentId;
  final List<SavedContentChannel> channels;
}
