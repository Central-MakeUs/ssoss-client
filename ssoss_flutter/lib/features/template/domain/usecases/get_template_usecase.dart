import 'package:ssoss_flutter/features/template/domain/entities/recommended_template_detail.dart';
import 'package:ssoss_flutter/features/template/domain/repositories/template_repository.dart';

class GetTemplateUseCase {
  GetTemplateUseCase(this._repository);

  final TemplateRepository _repository;

  Future<RecommendedTemplateDetail> call(int templateId) {
    return _repository.getTemplate(templateId);
  }
}
