import 'package:ssoss_flutter/features/template/domain/entities/recommended_template_category.dart';

class RecommendedTemplate {
  const RecommendedTemplate({
    required this.id,
    required this.category,
    required this.title,
    required this.description,
    required this.recommendedChannels,
    required this.bookmarked,
  });

  final int id;
  final RecommendedTemplateCategory category;
  final String title;
  final String description;
  final List<String> recommendedChannels;
  final bool bookmarked;

  RecommendedTemplate copyWith({bool? bookmarked}) {
    return RecommendedTemplate(
      id: id,
      category: category,
      title: title,
      description: description,
      recommendedChannels: recommendedChannels,
      bookmarked: bookmarked ?? this.bookmarked,
    );
  }
}
