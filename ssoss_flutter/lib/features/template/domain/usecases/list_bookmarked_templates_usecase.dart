import 'package:ssoss_flutter/features/template/domain/entities/recommended_template.dart';
import 'package:ssoss_flutter/features/template/domain/repositories/template_repository.dart';

class ListBookmarkedTemplatesUseCase {
  ListBookmarkedTemplatesUseCase(this._repository);

  final TemplateRepository _repository;

  Future<List<RecommendedTemplate>> call() {
    return _repository.listBookmarkedTemplates();
  }
}
