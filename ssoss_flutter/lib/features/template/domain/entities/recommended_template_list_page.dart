import 'package:ssoss_flutter/features/template/domain/entities/recommended_template.dart';

class RecommendedTemplateListPage {
  const RecommendedTemplateListPage({
    required this.totalCount,
    required this.page,
    required this.size,
    required this.hasNext,
    required this.templates,
  });

  final int totalCount;
  final int page;
  final int size;
  final bool hasNext;
  final List<RecommendedTemplate> templates;
}
