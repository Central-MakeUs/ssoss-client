/// 편집 화면 수정하기 영속화 방식.
enum ContentEditPersistMode {
  /// 결과 화면: API 없이 pop 만.
  none,

  /// 상세 등: PUT 채널 편집.
  put,
}
