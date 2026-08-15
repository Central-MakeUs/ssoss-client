import 'package:ssoss_flutter/features/template/domain/entities/recommended_template_category.dart';
import 'package:ssoss_flutter/features/template/domain/entities/saved_template_sort.dart';

class TemplateApiMapper {
  const TemplateApiMapper._();

  static String category(RecommendedTemplateCategory value) => switch (value) {
        RecommendedTemplateCategory.newMenu => 'NEW_MENU',
        RecommendedTemplateCategory.event => 'EVENT',
        RecommendedTemplateCategory.storeIntro => 'STORE_INTRO',
        RecommendedTemplateCategory.notice => 'NOTICE',
      };

  static String sort(SavedTemplateSort value) => switch (value) {
        SavedTemplateSort.latest => 'LATEST',
        SavedTemplateSort.oldest => 'OLDEST',
      };

  static RecommendedTemplateCategory categoryFromApi(String value) =>
      switch (value) {
        'NEW_MENU' => RecommendedTemplateCategory.newMenu,
        'EVENT' => RecommendedTemplateCategory.event,
        'STORE_INTRO' => RecommendedTemplateCategory.storeIntro,
        'NOTICE' => RecommendedTemplateCategory.notice,
        _ => throw ArgumentError('Unknown template category: $value'),
      };
}
