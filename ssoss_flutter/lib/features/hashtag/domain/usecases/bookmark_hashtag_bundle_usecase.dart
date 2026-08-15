import 'package:ssoss_flutter/features/hashtag/domain/repositories/hashtag_repository.dart';

class BookmarkHashtagBundleUseCase {
  BookmarkHashtagBundleUseCase(this._repository);

  final HashtagRepository _repository;

  Future<void> call(int bundleId) {
    return _repository.bookmarkBundle(bundleId);
  }
}
