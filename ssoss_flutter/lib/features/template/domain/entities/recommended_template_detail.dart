import 'package:ssoss_flutter/features/template/domain/entities/recommended_template_category.dart';

class RecommendedTemplateDetail {
  const RecommendedTemplateDetail({
    required this.id,
    required this.category,
    required this.title,
    required this.description,
    required this.body,
    required this.exampleBody,
    required this.recommendedChannels,
    required this.bookmarked,
  });

  final int id;
  final RecommendedTemplateCategory category;
  final String title;
  final String description;
  final String body;
  final String exampleBody;
  final List<String> recommendedChannels;
  final bool bookmarked;
}
