import 'package:ssoss_flutter/features/template/domain/entities/applied_template.dart';
import 'package:ssoss_flutter/features/template/domain/entities/recommended_template.dart';
import 'package:ssoss_flutter/features/template/domain/entities/recommended_template_category.dart';
import 'package:ssoss_flutter/features/template/domain/entities/recommended_template_detail.dart';
import 'package:ssoss_flutter/features/template/domain/entities/recommended_template_list_page.dart';
import 'package:ssoss_flutter/features/template/domain/entities/saved_template.dart';
import 'package:ssoss_flutter/features/template/domain/entities/saved_template_detail.dart';
import 'package:ssoss_flutter/features/template/domain/entities/saved_template_list_page.dart';
import 'package:ssoss_flutter/features/template/domain/entities/saved_template_sort.dart';

abstract class TemplateRepository {
  Future<RecommendedTemplateListPage> listTemplates({
    RecommendedTemplateCategory? category,
    int page = 0,
    int size = 20,
  });

  Future<RecommendedTemplateDetail> getTemplate(int templateId);

  Future<AppliedTemplate> getAppliedTemplate(int templateId);

  Future<SavedTemplate> saveTemplate({
    required int templateId,
    required String body,
  });

  Future<SavedTemplateListPage> listSavedTemplates({
    SavedTemplateSort sort = SavedTemplateSort.latest,
    int page = 0,
    int size = 20,
  });

  Future<SavedTemplateDetail> getSavedTemplate(int savedTemplateId);

  Future<SavedTemplateDetail> editSavedTemplate({
    required int savedTemplateId,
    required String body,
  });

  Future<SavedTemplateDetail> renameSavedTemplate({
    required int savedTemplateId,
    required String title,
  });

  Future<void> deleteSavedTemplate(int savedTemplateId);

  Future<void> bookmarkTemplate(int templateId);

  Future<void> unbookmarkTemplate(int templateId);

  Future<List<RecommendedTemplate>> listBookmarkedTemplates();
}
