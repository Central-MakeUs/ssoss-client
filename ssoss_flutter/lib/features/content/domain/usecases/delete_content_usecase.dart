import 'package:ssoss_flutter/features/content/domain/repositories/content_repository.dart';

class DeleteContentUseCase {
  DeleteContentUseCase(this._repository);

  final ContentRepository _repository;

  Future<void> call(int contentId) {
    return _repository.deleteContent(contentId);
  }
}
