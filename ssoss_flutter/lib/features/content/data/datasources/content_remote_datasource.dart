import 'package:dio/dio.dart';

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

  Future<ContentListResponseModel> listContents({
    String? channel,
    String sort = 'LATEST',
    int page = 0,
    int size = 20,
    CancelToken? cancelToken,
  });

  Future<ContentDetailResponseModel> getContent(
    int contentId, {
    CancelToken? cancelToken,
  });

  Future<void> deleteContent(
    int contentId, {
    CancelToken? cancelToken,
  });

  Future<ContentDetailResponseModel> renameContent({
    required int contentId,
    required ContentRenameRequest request,
    CancelToken? cancelToken,
  });
}
