import 'package:ssoss_flutter/features/template/domain/entities/saved_template_detail.dart';
import 'package:ssoss_flutter/features/template/domain/repositories/template_repository.dart';

class GetSavedTemplateUseCase {
  GetSavedTemplateUseCase(this._repository);

  final TemplateRepository _repository;

  Future<SavedTemplateDetail> call(int savedTemplateId) {
    return _repository.getSavedTemplate(savedTemplateId);
  }
}
