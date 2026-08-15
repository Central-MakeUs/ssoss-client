import 'package:ssoss_flutter/features/hashtag/domain/entities/hashtag_bundle.dart';
import 'package:ssoss_flutter/features/hashtag/domain/repositories/hashtag_repository.dart';

class ListBookmarkedHashtagBundlesUseCase {
  ListBookmarkedHashtagBundlesUseCase(this._repository);

  final HashtagRepository _repository;

  Future<List<HashtagBundle>> call() {
    return _repository.listBookmarkedBundles();
  }
}
