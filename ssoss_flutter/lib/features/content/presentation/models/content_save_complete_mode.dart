/// 저장 완료 화면 CTA 분기.
///
/// 채널 개수가 아니라 호출 측에서 명시적으로 전달한다.
enum ContentSaveCompleteMode {
  /// 미생성 채널이 남아 다른 채널용으로 이어만들 수 있는 경우.
  continueAvailable,

  /// 전체 채널 생성 완료, 또는 이어만들기 후 저장한 경우.
  finalSave,
}
