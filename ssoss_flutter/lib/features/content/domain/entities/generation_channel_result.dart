import 'package:ssoss_flutter/features/content/domain/entities/upload_channel.dart';

/// 생성 작업 채널별 결과.
class GenerationChannelResult {
  const GenerationChannelResult({
    required this.channel,
    required this.body,
    this.title,
    this.hashtags = const [],
  });

  final UploadChannel channel;
  final String? title;
  final String body;
  final List<String> hashtags;
}
