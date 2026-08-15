/// 콘텐츠 생성 플로우 종류.
enum ContentCreateFlow {
  /// 최초 3단계 위저드 생성.
  initial,

  /// 저장 완료 후 다른 채널용 이어만들기.
  otherChannel,

  /// 저장 콘텐츠 스타일 재사용 생성.
  styleReuse,
}
