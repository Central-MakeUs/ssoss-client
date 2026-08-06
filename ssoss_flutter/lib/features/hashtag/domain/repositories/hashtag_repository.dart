import 'package:ssoss_flutter/features/hashtag/domain/entities/hashtag_bundle_list_page.dart';

abstract class HashtagRepository {
  Future<HashtagBundleListPage> listBundles({
    String? keyword,
    int page = 0,
    int size = 20,
  });

  Future<void> bookmarkBundle(int bundleId);

  Future<void> unbookmarkBundle(int bundleId);
}
