import 'package:ssoss_flutter/features/content/domain/entities/content_detail.dart';
import 'package:ssoss_flutter/features/content/domain/repositories/content_repository.dart';

class RenameContentUseCase {
  RenameContentUseCase(this._repository);

  final ContentRepository _repository;

  Future<ContentDetail> call({
    required int contentId,
    required String name,
  }) {
    return _repository.renameContent(
      contentId: contentId,
      name: name,
    );
  }
}
