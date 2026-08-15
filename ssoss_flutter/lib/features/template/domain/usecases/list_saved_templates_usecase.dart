import 'package:ssoss_flutter/features/template/domain/entities/saved_template_list_page.dart';
import 'package:ssoss_flutter/features/template/domain/entities/saved_template_sort.dart';
import 'package:ssoss_flutter/features/template/domain/repositories/template_repository.dart';

class ListSavedTemplatesUseCase {
  ListSavedTemplatesUseCase(this._repository);

  final TemplateRepository _repository;

  Future<SavedTemplateListPage> call({
    SavedTemplateSort sort = SavedTemplateSort.latest,
    int page = 0,
    int size = 20,
  }) {
    return _repository.listSavedTemplates(
      sort: sort,
      page: page,
      size: size,
    );
  }
}
