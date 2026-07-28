import 'package:ssoss_flutter/features/content/domain/entities/content_list_item.dart';

/// `GET /v1/contents` 페이지 응답.
class ContentListPage {
  const ContentListPage({
    required this.totalCount,
    required this.page,
    required this.size,
    required this.hasNext,
    required this.contents,
  });

  final int totalCount;
  final int page;
  final int size;
  final bool hasNext;
  final List<ContentListItem> contents;
}
