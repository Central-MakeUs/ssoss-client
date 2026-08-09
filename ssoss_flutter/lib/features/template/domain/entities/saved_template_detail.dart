import 'package:ssoss_flutter/features/template/domain/entities/recommended_template_category.dart';

class SavedTemplateDetail {
  const SavedTemplateDetail({
    required this.savedTemplateId,
    required this.category,
    required this.title,
    required this.description,
    required this.body,
    required this.recommendedChannels,
    required this.savedAt,
  });

  final int savedTemplateId;
  final RecommendedTemplateCategory category;
  final String title;
  final String description;
  final String body;
  final List<String> recommendedChannels;
  final DateTime savedAt;
}
