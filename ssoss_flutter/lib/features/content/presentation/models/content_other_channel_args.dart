import 'package:ssoss_flutter/features/content/domain/entities/upload_channel.dart';

/// 다른 채널용 생성 화면 route extra.
class ContentOtherChannelArgs {
  const ContentOtherChannelArgs({
    required this.sourceContentId,
    required this.excludedChannels,
  });

  /// 원문으로 사용할 저장된 콘텐츠 ID.
  final String sourceContentId;

  /// 선택 목록에서 제외할 채널 (이미 만들거나 보고 있는 채널).
  final List<UploadChannel> excludedChannels;
}
