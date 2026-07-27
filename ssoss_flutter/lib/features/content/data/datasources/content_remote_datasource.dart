import 'package:dio/dio.dart';

import 'package:ssoss_flutter/features/content/data/models/content_channel_edit_request.dart';
import 'package:ssoss_flutter/features/content/data/models/content_channel_response_model.dart';
import 'package:ssoss_flutter/features/content/data/models/content_save_request.dart';
import 'package:ssoss_flutter/features/content/data/models/content_save_response_model.dart';
import 'package:ssoss_flutter/features/content/data/models/generation_detail_model.dart';
import 'package:ssoss_flutter/features/content/data/models/generation_start_request.dart';
import 'package:ssoss_flutter/features/content/data/models/generation_start_response.dart';

abstract class ContentRemoteDatasource {
  Future<GenerationStartResponse> startGeneration(
    GenerationStartRequest request, {
    CancelToken? cancelToken,
  });

  Future<GenerationDetailModel> getGeneration(
    int generationId, {
    CancelToken? cancelToken,
  });

  Future<ContentSaveResponseModel> saveContent(
    ContentSaveRequest request, {
    CancelToken? cancelToken,
  });

  Future<ContentChannelResponseModel> editChannel({
    required int contentId,
    required int contentChannelId,
    required ContentChannelEditRequest request,
    CancelToken? cancelToken,
  });
}
