import 'package:ssoss_flutter/features/template/domain/entities/recommended_template_category.dart';

class SavedTemplateListItem {
  const SavedTemplateListItem({
    required this.savedTemplateId,
    required this.category,
    required this.title,
    required this.description,
    required this.savedAt,
  });

  final int savedTemplateId;
  final RecommendedTemplateCategory category;
  final String title;
  final String description;
  final DateTime savedAt;
}
