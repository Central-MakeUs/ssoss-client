import 'package:ssoss_flutter/features/content/domain/entities/generation_channel_result.dart';

/// PUT 채널 편집 응답 (상세 contents 원소와 동일).
class ContentChannelContent {
  const ContentChannelContent({
    required this.contentChannelId,
    required this.channelResult,
  });

  final int contentChannelId;
  final GenerationChannelResult channelResult;
}
