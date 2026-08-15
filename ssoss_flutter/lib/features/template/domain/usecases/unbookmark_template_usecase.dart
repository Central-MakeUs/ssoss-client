import 'package:ssoss_flutter/features/template/domain/repositories/template_repository.dart';

class UnbookmarkTemplateUseCase {
  UnbookmarkTemplateUseCase(this._repository);

  final TemplateRepository _repository;

  Future<void> call(int templateId) {
    return _repository.unbookmarkTemplate(templateId);
  }
}
