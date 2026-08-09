import 'package:ssoss_flutter/features/template/domain/entities/applied_template.dart';
import 'package:ssoss_flutter/features/template/domain/repositories/template_repository.dart';

class GetAppliedTemplateUseCase {
  GetAppliedTemplateUseCase(this._repository);

  final TemplateRepository _repository;

  Future<AppliedTemplate> call(int templateId) {
    return _repository.getAppliedTemplate(templateId);
  }
}
