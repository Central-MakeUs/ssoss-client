import 'package:ssoss_flutter/features/content/domain/entities/upload_channel.dart';

/// 최근 생성된 콘텐츠 목록에 표시하는 항목.
class ContentRecentItem {
  const ContentRecentItem({
    required this.id,
    required this.title,
    required this.createdAt,
    required this.channels,
    this.firstChannel,
  });

  final String id;
  final String title;
  final DateTime createdAt;

  /// 표시용 채널명 목록. 예: `['블로그']`, `['블로그', '스레드', '당근']`
  final List<String> channels;

  /// 상세 진입 시 처음 보여줄 채널 (목록의 첫 채널).
  final UploadChannel? firstChannel;

  String get formattedDate {
    final month = createdAt.month.toString().padLeft(2, '0');
    final day = createdAt.day.toString().padLeft(2, '0');
    return '${createdAt.year}.$month.$day';
  }

  String get channelsLabel => channels.join(', ');
}
