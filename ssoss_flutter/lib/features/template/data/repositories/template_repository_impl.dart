import 'package:ssoss_flutter/features/template/data/datasources/template_remote_datasource.dart';
import 'package:ssoss_flutter/features/template/data/mappers/template_api_mapper.dart';
import 'package:ssoss_flutter/features/template/data/models/applied_template_response_model.dart';
import 'package:ssoss_flutter/features/template/data/models/recommended_template_detail_response_model.dart';
import 'package:ssoss_flutter/features/template/data/models/recommended_template_list_response_model.dart';
import 'package:ssoss_flutter/features/template/data/models/saved_template_detail_response_model.dart';
import 'package:ssoss_flutter/features/template/data/models/saved_template_edit_request.dart';
import 'package:ssoss_flutter/features/template/data/models/saved_template_list_response_model.dart';
import 'package:ssoss_flutter/features/template/data/models/saved_template_rename_request.dart';
import 'package:ssoss_flutter/features/template/data/models/saved_template_save_request.dart';
import 'package:ssoss_flutter/features/template/data/models/saved_template_save_response_model.dart';
import 'package:ssoss_flutter/features/template/domain/entities/applied_template.dart';
import 'package:ssoss_flutter/features/template/domain/entities/recommended_template_category.dart';
import 'package:ssoss_flutter/features/template/domain/entities/recommended_template_detail.dart';
import 'package:ssoss_flutter/features/template/domain/entities/recommended_template_list_page.dart';
import 'package:ssoss_flutter/features/template/domain/entities/saved_template.dart';
import 'package:ssoss_flutter/features/template/domain/entities/saved_template_detail.dart';
import 'package:ssoss_flutter/features/template/domain/entities/saved_template_list_page.dart';
import 'package:ssoss_flutter/features/template/domain/entities/saved_template_sort.dart';
import 'package:ssoss_flutter/features/template/domain/repositories/template_repository.dart';

class TemplateRepositoryImpl implements TemplateRepository {
  TemplateRepositoryImpl({
    required TemplateRemoteDatasource remoteDatasource,
  }) : _remote = remoteDatasource;

  final TemplateRemoteDatasource _remote;

  @override
  Future<RecommendedTemplateListPage> listTemplates({
    RecommendedTemplateCategory? category,
    int page = 0,
    int size = 20,
  }) async {
    final model = await _remote.listTemplates(
      category: category == null ? null : TemplateApiMapper.category(category),
      page: page,
      size: size,
    );
    return model.toEntity();
  }

  @override
  Future<RecommendedTemplateDetail> getTemplate(int templateId) async {
    final model = await _remote.getTemplate(templateId);
    return model.toEntity();
  }

  @override
  Future<AppliedTemplate> getAppliedTemplate(int templateId) async {
    final model = await _remote.getAppliedTemplate(templateId);
    return model.toEntity();
  }

  @override
  Future<SavedTemplate> saveTemplate({
    required int templateId,
    required String body,
  }) async {
    final model = await _remote.saveTemplate(
      SavedTemplateSaveRequest(
        templateId: templateId,
        body: body,
      ),
    );
    return model.toEntity();
  }

  @override
  Future<SavedTemplateListPage> listSavedTemplates({
    SavedTemplateSort sort = SavedTemplateSort.latest,
    int page = 0,
    int size = 20,
  }) async {
    final model = await _remote.listSavedTemplates(
      sort: TemplateApiMapper.sort(sort),
      page: page,
      size: size,
    );
    return model.toEntity();
  }

  @override
  Future<SavedTemplateDetail> getSavedTemplate(int savedTemplateId) async {
    final model = await _remote.getSavedTemplate(savedTemplateId);
    return model.toEntity();
  }

  @override
  Future<SavedTemplateDetail> editSavedTemplate({
    required int savedTemplateId,
    required String body,
  }) async {
    final model = await _remote.editSavedTemplate(
      savedTemplateId,
      SavedTemplateEditRequest(body: body),
    );
    return model.toEntity();
  }

  @override
  Future<SavedTemplateDetail> renameSavedTemplate({
    required int savedTemplateId,
    required String title,
  }) async {
    final model = await _remote.renameSavedTemplate(
      savedTemplateId,
      SavedTemplateRenameRequest(title: title),
    );
    return model.toEntity();
  }

  @override
  Future<void> deleteSavedTemplate(int savedTemplateId) {
    return _remote.deleteSavedTemplate(savedTemplateId);
  }
}
