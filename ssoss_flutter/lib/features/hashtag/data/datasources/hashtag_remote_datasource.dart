import 'package:dio/dio.dart';

import 'package:ssoss_flutter/features/hashtag/data/models/bookmarked_hashtag_bundle_list_response_model.dart';
import 'package:ssoss_flutter/features/hashtag/data/models/hashtag_bundle_list_response_model.dart';

abstract class HashtagRemoteDatasource {
  Future<HashtagBundleListResponseModel> listBundles({
    String? keyword,
    int page = 0,
    int size = 20,
    CancelToken? cancelToken,
  });

  Future<BookmarkedHashtagBundleListResponseModel> listBookmarkedBundles({
    CancelToken? cancelToken,
  });

  Future<void> bookmarkBundle(
    int bundleId, {
    CancelToken? cancelToken,
  });

  Future<void> unbookmarkBundle(
    int bundleId, {
    CancelToken? cancelToken,
  });
}
