import 'package:ssoss_flutter/features/content/domain/entities/content_detail.dart';
import 'package:ssoss_flutter/features/content/domain/repositories/content_repository.dart';

class GetContentUseCase {
  GetContentUseCase(this._repository);

  final ContentRepository _repository;

  Future<ContentDetail> call(int contentId) {
    return _repository.getContent(contentId);
  }
}
