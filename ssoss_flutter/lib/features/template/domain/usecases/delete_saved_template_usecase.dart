import 'package:ssoss_flutter/features/template/domain/repositories/template_repository.dart';

class DeleteSavedTemplateUseCase {
  DeleteSavedTemplateUseCase(this._repository);

  final TemplateRepository _repository;

  Future<void> call(int savedTemplateId) {
    return _repository.deleteSavedTemplate(savedTemplateId);
  }
}
