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

// TODO: API 연동 후 제거하고 repository 조회 결과를 사용한다.
final contentRecentPreviewItems = <ContentRecentItem>[
  ContentRecentItem(
    id: '1',
    title: '여름엔 시원한 수박빙수 어때요?',
    createdAt: DateTime(2026, 9, 24),
    channels: ['블로그'],
  ),
  ContentRecentItem(
    id: '2',
    title: '신메뉴 버터떡 출시! 쫀득 바삭한 떡 맛있어요',
    createdAt: DateTime(2026, 9, 22),
    channels: ['블로그', '스레드', '당근'],
  ),
  ContentRecentItem(
    id: '3',
    title: '스친들만을 위한 특별 할인 이벤트!',
    createdAt: DateTime(2026, 9, 21),
    channels: ['스레드'],
  ),
];
