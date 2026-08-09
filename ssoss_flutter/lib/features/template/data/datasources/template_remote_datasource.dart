import 'package:dio/dio.dart';

import 'package:ssoss_flutter/features/template/data/models/applied_template_response_model.dart';
import 'package:ssoss_flutter/features/template/data/models/bookmarked_template_list_response_model.dart';
import 'package:ssoss_flutter/features/template/data/models/recommended_template_detail_response_model.dart';
import 'package:ssoss_flutter/features/template/data/models/recommended_template_list_response_model.dart';
import 'package:ssoss_flutter/features/template/data/models/saved_template_detail_response_model.dart';
import 'package:ssoss_flutter/features/template/data/models/saved_template_edit_request.dart';
import 'package:ssoss_flutter/features/template/data/models/saved_template_list_response_model.dart';
import 'package:ssoss_flutter/features/template/data/models/saved_template_rename_request.dart';
import 'package:ssoss_flutter/features/template/data/models/saved_template_save_request.dart';
import 'package:ssoss_flutter/features/template/data/models/saved_template_save_response_model.dart';

abstract class TemplateRemoteDatasource {
  Future<RecommendedTemplateListResponseModel> listTemplates({
    String? category,
    int page = 0,
    int size = 20,
    CancelToken? cancelToken,
  });

  Future<RecommendedTemplateDetailResponseModel> getTemplate(
    int templateId, {
    CancelToken? cancelToken,
  });

  Future<AppliedTemplateResponseModel> getAppliedTemplate(
    int templateId, {
    CancelToken? cancelToken,
  });

  Future<SavedTemplateSaveResponseModel> saveTemplate(
    SavedTemplateSaveRequest request, {
    CancelToken? cancelToken,
  });

  Future<SavedTemplateListResponseModel> listSavedTemplates({
    String sort = 'LATEST',
    int page = 0,
    int size = 20,
    CancelToken? cancelToken,
  });

  Future<SavedTemplateDetailResponseModel> getSavedTemplate(
    int savedTemplateId, {
    CancelToken? cancelToken,
  });

  Future<SavedTemplateDetailResponseModel> editSavedTemplate(
    int savedTemplateId,
    SavedTemplateEditRequest request, {
    CancelToken? cancelToken,
  });

  Future<SavedTemplateDetailResponseModel> renameSavedTemplate(
    int savedTemplateId,
    SavedTemplateRenameRequest request, {
    CancelToken? cancelToken,
  });

  Future<void> deleteSavedTemplate(
    int savedTemplateId, {
    CancelToken? cancelToken,
  });

  Future<void> bookmarkTemplate(
    int templateId, {
    CancelToken? cancelToken,
  });

  Future<void> unbookmarkTemplate(
    int templateId, {
    CancelToken? cancelToken,
  });

  Future<BookmarkedTemplateListResponseModel> listBookmarkedTemplates({
    CancelToken? cancelToken,
  });
}
