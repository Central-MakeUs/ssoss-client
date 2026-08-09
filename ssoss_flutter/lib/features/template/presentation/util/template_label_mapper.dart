import 'package:ssoss_flutter/features/template/domain/entities/recommended_template_category.dart';
import 'package:ssoss_flutter/features/template/presentation/widgets/template_models.dart';

class TemplateLabelMapper {
  const TemplateLabelMapper._();

  static String channel(String code) => switch (code) {
        'DAANGN_BIZ' || 'CARROT' => '당근',
        'INSTAGRAM' => '인스타그램',
        'BLOG' => '블로그',
        'THREADS' || 'THREAD' => '스레드',
        _ => code,
      };

  static List<String> channels(List<String> codes) =>
      codes.map(channel).toList(growable: false);

  static TemplateCategory category(RecommendedTemplateCategory value) =>
      switch (value) {
        RecommendedTemplateCategory.newMenu => TemplateCategory.newMenu,
        RecommendedTemplateCategory.event => TemplateCategory.event,
        RecommendedTemplateCategory.storeIntro => TemplateCategory.storeIntro,
        RecommendedTemplateCategory.notice => TemplateCategory.notice,
      };

  static RecommendedTemplateCategory? apiCategory(TemplateCategory value) =>
      switch (value) {
        TemplateCategory.all => null,
        TemplateCategory.newMenu => RecommendedTemplateCategory.newMenu,
        TemplateCategory.event => RecommendedTemplateCategory.event,
        TemplateCategory.storeIntro => RecommendedTemplateCategory.storeIntro,
        TemplateCategory.notice => RecommendedTemplateCategory.notice,
      };
}
