import 'package:ssoss_flutter/features/hashtag/domain/entities/hashtag_bundle_list_page.dart';
import 'package:ssoss_flutter/features/hashtag/domain/repositories/hashtag_repository.dart';

class ListHashtagBundlesUseCase {
  ListHashtagBundlesUseCase(this._repository);

  final HashtagRepository _repository;

  Future<HashtagBundleListPage> call({
    String? keyword,
    int page = 0,
    int size = 20,
  }) {
    return _repository.listBundles(
      keyword: keyword,
      page: page,
      size: size,
    );
  }
}
