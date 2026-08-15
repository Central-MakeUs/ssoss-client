import 'package:ssoss_flutter/features/template/domain/entities/saved_template.dart';
import 'package:ssoss_flutter/features/template/domain/repositories/template_repository.dart';

class SaveTemplateUseCase {
  SaveTemplateUseCase(this._repository);

  final TemplateRepository _repository;

  Future<SavedTemplate> call({
    required int templateId,
    required String body,
  }) {
    return _repository.saveTemplate(
      templateId: templateId,
      body: body,
    );
  }
}
