import 'package:dio/dio.dart';

import 'package:ssoss_flutter/core/network/dio_error_mapper.dart';
import 'package:ssoss_flutter/features/template/data/datasources/template_remote_datasource.dart';
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

class TemplateRemoteDatasourceImpl implements TemplateRemoteDatasource {
  TemplateRemoteDatasourceImpl(this._dio);

  final Dio _dio;

  static const _templatesPath = '/v1/templates';
  static const _savedTemplatesPath = '/v1/saved-templates';
  static const _memberTemplatesPath = '/v1/members/me/templates';

  @override
  Future<RecommendedTemplateListResponseModel> listTemplates({
    String? category,
    int page = 0,
    int size = 20,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        _templatesPath,
        queryParameters: <String, dynamic>{
          if (category != null) 'category': category,
          'page': page,
          'size': size,
        },
        cancelToken: cancelToken,
      );
      return RecommendedTemplateListResponseModel.fromJson(response.data!);
    } on DioException catch (e) {
      throw mapDioError(e);
    }
  }

  @override
  Future<RecommendedTemplateDetailResponseModel> getTemplate(
    int templateId, {
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '$_templatesPath/$templateId',
        cancelToken: cancelToken,
      );
      return RecommendedTemplateDetailResponseModel.fromJson(response.data!);
    } on DioException catch (e) {
      throw mapDioError(e);
    }
  }

  @override
  Future<AppliedTemplateResponseModel> getAppliedTemplate(
    int templateId, {
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '$_templatesPath/$templateId/applied',
        cancelToken: cancelToken,
      );
      return AppliedTemplateResponseModel.fromJson(response.data!);
    } on DioException catch (e) {
      throw mapDioError(e);
    }
  }

  @override
  Future<SavedTemplateSaveResponseModel> saveTemplate(
    SavedTemplateSaveRequest request, {
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        _savedTemplatesPath,
        data: request.toJson(),
        cancelToken: cancelToken,
      );
      return SavedTemplateSaveResponseModel.fromJson(response.data!);
    } on DioException catch (e) {
      throw mapDioError(e);
    }
  }

  @override
  Future<SavedTemplateListResponseModel> listSavedTemplates({
    String sort = 'LATEST',
    int page = 0,
    int size = 20,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        _savedTemplatesPath,
        queryParameters: <String, dynamic>{
          'sort': sort,
          'page': page,
          'size': size,
        },
        cancelToken: cancelToken,
      );
      return SavedTemplateListResponseModel.fromJson(response.data!);
    } on DioException catch (e) {
      throw mapDioError(e);
    }
  }

  @override
  Future<SavedTemplateDetailResponseModel> getSavedTemplate(
    int savedTemplateId, {
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '$_savedTemplatesPath/$savedTemplateId',
        cancelToken: cancelToken,
      );
      return SavedTemplateDetailResponseModel.fromJson(response.data!);
    } on DioException catch (e) {
      throw mapDioError(e);
    }
  }

  @override
  Future<SavedTemplateDetailResponseModel> editSavedTemplate(
    int savedTemplateId,
    SavedTemplateEditRequest request, {
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.put<Map<String, dynamic>>(
        '$_savedTemplatesPath/$savedTemplateId',
        data: request.toJson(),
        cancelToken: cancelToken,
      );
      return SavedTemplateDetailResponseModel.fromJson(response.data!);
    } on DioException catch (e) {
      throw mapDioError(e);
    }
  }

  @override
  Future<SavedTemplateDetailResponseModel> renameSavedTemplate(
    int savedTemplateId,
    SavedTemplateRenameRequest request, {
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.put<Map<String, dynamic>>(
        '$_savedTemplatesPath/$savedTemplateId/title',
        data: request.toJson(),
        cancelToken: cancelToken,
      );
      return SavedTemplateDetailResponseModel.fromJson(response.data!);
    } on DioException catch (e) {
      throw mapDioError(e);
    }
  }

  @override
  Future<void> deleteSavedTemplate(
    int savedTemplateId, {
    CancelToken? cancelToken,
  }) async {
    try {
      await _dio.delete<void>(
        '$_savedTemplatesPath/$savedTemplateId',
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      throw mapDioError(e);
    }
  }

  @override
  Future<void> bookmarkTemplate(
    int templateId, {
    CancelToken? cancelToken,
  }) async {
    try {
      await _dio.put<void>(
        '$_memberTemplatesPath/$templateId',
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      throw mapDioError(e);
    }
  }

  @override
  Future<void> unbookmarkTemplate(
    int templateId, {
    CancelToken? cancelToken,
  }) async {
    try {
      await _dio.delete<void>(
        '$_memberTemplatesPath/$templateId',
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      throw mapDioError(e);
    }
  }

  @override
  Future<BookmarkedTemplateListResponseModel> listBookmarkedTemplates({
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        _memberTemplatesPath,
        cancelToken: cancelToken,
      );
      return BookmarkedTemplateListResponseModel.fromJson(response.data!);
    } on DioException catch (e) {
      throw mapDioError(e);
    }
  }
}
