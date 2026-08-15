import 'package:ssoss_flutter/features/template/domain/entities/saved_template_detail.dart';
import 'package:ssoss_flutter/features/template/domain/repositories/template_repository.dart';

class RenameSavedTemplateUseCase {
  RenameSavedTemplateUseCase(this._repository);

  final TemplateRepository _repository;

  Future<SavedTemplateDetail> call({
    required int savedTemplateId,
    required String title,
  }) {
    return _repository.renameSavedTemplate(
      savedTemplateId: savedTemplateId,
      title: title,
    );
  }
}
