import 'package:ssoss_flutter/features/hashtag/data/datasources/hashtag_remote_datasource.dart';
import 'package:ssoss_flutter/features/hashtag/data/models/hashtag_bundle_list_response_model.dart';
import 'package:ssoss_flutter/features/hashtag/domain/entities/hashtag_bundle_list_page.dart';
import 'package:ssoss_flutter/features/hashtag/domain/repositories/hashtag_repository.dart';

class HashtagRepositoryImpl implements HashtagRepository {
  HashtagRepositoryImpl({
    required HashtagRemoteDatasource remoteDatasource,
  }) : _remote = remoteDatasource;

  final HashtagRemoteDatasource _remote;

  @override
  Future<HashtagBundleListPage> listBundles({
    String? keyword,
    int page = 0,
    int size = 20,
  }) async {
    final model = await _remote.listBundles(
      keyword: keyword,
      page: page,
      size: size,
    );
    return model.toEntity();
  }

  @override
  Future<void> bookmarkBundle(int bundleId) {
    return _remote.bookmarkBundle(bundleId);
  }

  @override
  Future<void> unbookmarkBundle(int bundleId) {
    return _remote.unbookmarkBundle(bundleId);
  }
}
