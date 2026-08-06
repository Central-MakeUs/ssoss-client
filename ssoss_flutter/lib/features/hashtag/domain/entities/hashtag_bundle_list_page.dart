import 'package:ssoss_flutter/features/hashtag/domain/entities/hashtag_bundle.dart';

class HashtagBundleListPage {
  const HashtagBundleListPage({
    required this.totalCount,
    required this.page,
    required this.size,
    required this.hasNext,
    required this.bundles,
  });

  final int totalCount;
  final int page;
  final int size;
  final bool hasNext;
  final List<HashtagBundle> bundles;
}
