import 'package:ssoss_flutter/features/template/domain/entities/saved_template_list_item.dart';

class SavedTemplateListPage {
  const SavedTemplateListPage({
    required this.totalCount,
    required this.page,
    required this.size,
    required this.hasNext,
    required this.savedTemplates,
  });

  final int totalCount;
  final int page;
  final int size;
  final bool hasNext;
  final List<SavedTemplateListItem> savedTemplates;
}
