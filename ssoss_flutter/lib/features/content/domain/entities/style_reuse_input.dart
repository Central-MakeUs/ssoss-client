/// 스타일 재사용 API 요청에 필요한 입력 값.
class StyleReuseInput {
  const StyleReuseInput({
    required this.contentId,
    required this.contentChannelId,
    required this.highlight,
    this.forbidden,
    this.keywords = const [],
    this.photoGuideEnabled = false,
  });

  /// 참고 원본 저장 콘텐츠 ID.
  final int contentId;

  /// 참고할 채널별 콘텐츠 ID.
  final int contentChannelId;

  /// 강조 내용.
  final String highlight;

  /// 금지 내용.
  final String? forbidden;

  final List<String> keywords;
  final bool photoGuideEnabled;
}
