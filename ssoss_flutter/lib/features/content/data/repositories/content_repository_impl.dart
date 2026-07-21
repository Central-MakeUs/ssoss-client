import 'package:dio/dio.dart';

import 'package:ssoss_flutter/core/exception/app_exception.dart';
import 'package:ssoss_flutter/features/content/data/datasources/content_remote_datasource.dart';
import 'package:ssoss_flutter/features/content/data/models/create_content_request.dart';
import 'package:ssoss_flutter/features/content/data/models/create_content_result_model.dart';
import 'package:ssoss_flutter/features/content/domain/entities/content_create_input.dart';
import 'package:ssoss_flutter/features/content/domain/entities/create_content_result.dart';
import 'package:ssoss_flutter/features/content/domain/repositories/content_repository.dart';

class ContentRepositoryImpl implements ContentRepository {
  ContentRepositoryImpl({
    required ContentRemoteDatasource remoteDatasource,
  }) : _remote = remoteDatasource;

  final ContentRemoteDatasource _remote;
  CancelToken? _activeCancelToken;

  @override
  Future<CreateContentResult> createContent(ContentCreateInput input) async {
    _activeCancelToken?.cancel('superseded');
    _activeCancelToken = CancelToken();
    try {
      final model = await _remote.createContent(
        CreateContentRequest.fromEntity(input),
        cancelToken: _activeCancelToken,
      );
      return model.toEntity();
    } on DioException catch (e) {
      if (e.type == DioExceptionType.cancel || CancelToken.isCancel(e)) {
        throw const CancelledException();
      }
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.connectionError) {
        throw const NetworkException();
      }
      final statusCode = e.response?.statusCode ?? 0;
      throw ServerException(statusCode, e.message ?? '서버 오류가 발생했습니다.');
    } finally {
      _activeCancelToken = null;
    }
  }

  @override
  void cancelCreate() {
    _activeCancelToken?.cancel('user_exit');
    _activeCancelToken = null;
  }
}
