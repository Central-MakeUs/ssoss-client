import 'package:ssoss_flutter/features/template/domain/entities/recommended_template_category.dart';
import 'package:ssoss_flutter/features/template/domain/entities/recommended_template_list_page.dart';
import 'package:ssoss_flutter/features/template/domain/repositories/template_repository.dart';

class ListTemplatesUseCase {
  ListTemplatesUseCase(this._repository);

  final TemplateRepository _repository;

  Future<RecommendedTemplateListPage> call({
    RecommendedTemplateCategory? category,
    int page = 0,
    int size = 20,
  }) {
    return _repository.listTemplates(
      category: category,
      page: page,
      size: size,
    );
  }
}
