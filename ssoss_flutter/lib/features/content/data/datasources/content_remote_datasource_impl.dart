import 'package:dio/dio.dart';

import 'package:ssoss_flutter/core/network/dio_error_mapper.dart';
import 'package:ssoss_flutter/features/content/data/datasources/content_remote_datasource.dart';
import 'package:ssoss_flutter/features/content/data/models/content_channel_edit_request.dart';
import 'package:ssoss_flutter/features/content/data/models/content_channel_response_model.dart';
import 'package:ssoss_flutter/features/content/data/models/content_detail_response_model.dart';
import 'package:ssoss_flutter/features/content/data/models/content_list_response_model.dart';
import 'package:ssoss_flutter/features/content/data/models/content_rename_request.dart';
import 'package:ssoss_flutter/features/content/data/models/content_save_request.dart';
import 'package:ssoss_flutter/features/content/data/models/content_save_response_model.dart';
import 'package:ssoss_flutter/features/content/data/models/generation_detail_model.dart';
import 'package:ssoss_flutter/features/content/data/models/generation_start_request.dart';
import 'package:ssoss_flutter/features/content/data/models/generation_start_response.dart';
import 'package:ssoss_flutter/features/content/data/models/style_reuse_request.dart';

class ContentRemoteDatasourceImpl implements ContentRemoteDatasource {
  ContentRemoteDatasourceImpl(this._dio);

  final Dio _dio;

  static const _generationsPath = '/v1/generations';
  static const _contentsPath = '/v1/contents';

  @override
  Future<GenerationStartResponse> startGeneration(
    GenerationStartRequest request, {
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        _generationsPath,
        data: request.toJson(),
        cancelToken: cancelToken,
      );
      return GenerationStartResponse.fromJson(response.data!);
    } on DioException catch (e) {
      throw mapDioError(e);
    }
  }

  @override
  Future<GenerationStartResponse> startStyleReuse({
    required int contentId,
    required int contentChannelId,
    required StyleReuseRequest request,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        '$_contentsPath/$contentId/channels/$contentChannelId/reuses',
        data: request.toJson(),
        cancelToken: cancelToken,
      );
      return GenerationStartResponse.fromJson(response.data!);
    } on DioException catch (e) {
      throw mapDioError(e);
    }
  }

  @override
  Future<GenerationDetailModel> getGeneration(
    int generationId, {
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '$_generationsPath/$generationId',
        cancelToken: cancelToken,
      );
      return GenerationDetailModel.fromJson(response.data!);
    } on DioException catch (e) {
      throw mapDioError(e);
    }
  }

  @override
  Future<ContentSaveResponseModel> saveContent(
    ContentSaveRequest request, {
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        _contentsPath,
        data: request.toApiJson(),
        cancelToken: cancelToken,
      );
      return ContentSaveResponseModel.fromJson(response.data!);
    } on DioException catch (e) {
      throw mapDioError(e);
    }
  }

  @override
  Future<ContentChannelResponseModel> editChannel({
    required int contentId,
    required int contentChannelId,
    required ContentChannelEditRequest request,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.put<Map<String, dynamic>>(
        '$_contentsPath/$contentId/channels/$contentChannelId',
        data: request.toApiJson(),
        cancelToken: cancelToken,
      );
      return ContentChannelResponseModel.fromJson(response.data!);
    } on DioException catch (e) {
      throw mapDioError(e);
    }
  }

  @override
  Future<ContentListResponseModel> listContents({
    String? channel,
    String sort = 'LATEST',
    int page = 0,
    int size = 20,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        _contentsPath,
        queryParameters: <String, dynamic>{
          if (channel != null) 'channel': channel,
          'sort': sort,
          'page': page,
          'size': size,
        },
        cancelToken: cancelToken,
      );
      return ContentListResponseModel.fromJson(response.data!);
    } on DioException catch (e) {
      throw mapDioError(e);
    }
  }

  @override
  Future<ContentDetailResponseModel> getContent(
    int contentId, {
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '$_contentsPath/$contentId',
        cancelToken: cancelToken,
      );
      return ContentDetailResponseModel.fromJson(response.data!);
    } on DioException catch (e) {
      throw mapDioError(e);
    }
  }

  @override
  Future<void> deleteContent(
    int contentId, {
    CancelToken? cancelToken,
  }) async {
    try {
      await _dio.delete<void>(
        '$_contentsPath/$contentId',
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      throw mapDioError(e);
    }
  }

  @override
  Future<ContentDetailResponseModel> renameContent({
    required int contentId,
    required ContentRenameRequest request,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.put<Map<String, dynamic>>(
        '$_contentsPath/$contentId/name',
        data: request.toJson(),
        cancelToken: cancelToken,
      );
      return ContentDetailResponseModel.fromJson(response.data!);
    } on DioException catch (e) {
      throw mapDioError(e);
    }
  }
}
