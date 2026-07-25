/// 최근 생성된 콘텐츠 목록에 표시하는 항목.
class ContentRecentItem {
  const ContentRecentItem({
    required this.id,
    required this.title,
    required this.createdAt,
    required this.channels,
  });

  final String id;
  final String title;
  final DateTime createdAt;

  /// 표시용 채널명 목록. 예: `['블로그']`, `['블로그', '스레드', '당근']`
  final List<String> channels;

  String get formattedDate {
    final month = createdAt.month.toString().padLeft(2, '0');
    final day = createdAt.day.toString().padLeft(2, '0');
    return '${createdAt.year}.$month.$day';
  }

  String get channelsLabel => channels.join(', ');
}
