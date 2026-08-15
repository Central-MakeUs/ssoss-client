import 'package:ssoss_flutter/features/content/domain/entities/upload_channel.dart';

/// 다른 채널용 변환 API 요청에 필요한 입력 값.
class ChannelConversionInput {
  const ChannelConversionInput({
    required this.contentId,
    required this.contentChannelId,
    required this.channels,
  });

  /// 원본 저장 콘텐츠 ID.
  final int contentId;

  /// 원본으로 쓸 채널별 콘텐츠 ID (상세에서 보고 있는 탭).
  final int contentChannelId;

  /// 새로 만들 채널 목록 (1~3, 원본 채널 제외).
  final List<UploadChannel> channels;
}
