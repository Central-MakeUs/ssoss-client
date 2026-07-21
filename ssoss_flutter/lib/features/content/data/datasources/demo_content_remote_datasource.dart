import 'package:dio/dio.dart';

import 'package:ssoss_flutter/features/content/data/datasources/content_remote_datasource.dart';
import 'package:ssoss_flutter/features/content/data/models/create_content_request.dart';
import 'package:ssoss_flutter/features/content/data/models/create_content_result_model.dart';

/// 백엔드 미연동 단계용 데모 구현.
///
/// 약 2초 지연 후 더미 contentId 를 반환한다.
class DemoContentRemoteDatasource implements ContentRemoteDatasource {
  const DemoContentRemoteDatasource();

  @override
  Future<CreateContentResultModel> createContent(
    CreateContentRequest request, {
    CancelToken? cancelToken,
  }) async {
    for (var i = 0; i < 20; i++) {
      await Future<void>.delayed(const Duration(milliseconds: 100));
      if (cancelToken?.isCancelled ?? false) {
        throw DioException(
          requestOptions: RequestOptions(path: '/api/v1/contents'),
          type: DioExceptionType.cancel,
          error: 'cancelled',
        );
      }
    }
    return CreateContentResultModel(
      contentId: 'demo_${DateTime.now().millisecondsSinceEpoch}',
    );
  }
}
