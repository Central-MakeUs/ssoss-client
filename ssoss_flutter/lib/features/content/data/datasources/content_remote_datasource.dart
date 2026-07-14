import 'package:dio/dio.dart';

import 'package:ssoss_flutter/features/content/data/models/create_content_request.dart';
import 'package:ssoss_flutter/features/content/data/models/create_content_result_model.dart';

abstract class ContentRemoteDatasource {
  Future<CreateContentResultModel> createContent(
    CreateContentRequest request, {
    CancelToken? cancelToken,
  });
}
