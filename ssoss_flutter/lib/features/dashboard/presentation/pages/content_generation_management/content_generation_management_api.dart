/// API connection point for the content generation management screen.
///
/// The backend contract is not connected yet, so methods are stubs until
/// request/response models are defined.
class ContentGenerationManagementApi {
  const ContentGenerationManagementApi();

  /// 저장 콘텐츠 목록 조회.
  Future<void> fetchItems() async {}

  /// 저장 콘텐츠 삭제.
  Future<void> deleteItem(String id) async {}
}
