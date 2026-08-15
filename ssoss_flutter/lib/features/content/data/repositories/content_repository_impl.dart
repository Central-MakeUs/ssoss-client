import 'package:dio/dio.dart';

import 'package:ssoss_flutter/core/exception/app_exception.dart';
import 'package:ssoss_flutter/features/content/data/datasources/content_remote_datasource.dart';
import 'package:ssoss_flutter/features/content/data/mappers/content_create_api_mapper.dart';
import 'package:ssoss_flutter/features/content/data/models/content_channel_edit_request.dart';
import 'package:ssoss_flutter/features/content/data/models/content_channel_response_model.dart';
import 'package:ssoss_flutter/features/content/data/models/content_detail_response_model.dart';
import 'package:ssoss_flutter/features/content/data/models/content_list_response_model.dart';
import 'package:ssoss_flutter/features/content/data/models/content_rename_request.dart';
import 'package:ssoss_flutter/features/content/data/models/content_save_request.dart';
import 'package:ssoss_flutter/features/content/data/models/content_save_response_model.dart';
import 'package:ssoss_flutter/features/content/data/models/generation_channel_result_model.dart';
import 'package:ssoss_flutter/features/content/data/models/generation_detail_model.dart';
import 'package:ssoss_flutter/features/content/data/models/generation_start_request.dart';
import 'package:ssoss_flutter/features/content/data/models/style_reuse_request.dart';
import 'package:ssoss_flutter/features/content/domain/entities/style_reuse_input.dart';
import 'package:ssoss_flutter/features/content/domain/entities/content_channel_content.dart';
import 'package:ssoss_flutter/features/content/domain/entities/content_create_input.dart';
import 'package:ssoss_flutter/features/content/domain/entities/content_detail.dart';
import 'package:ssoss_flutter/features/content/domain/entities/content_list_page.dart';
import 'package:ssoss_flutter/features/content/domain/entities/content_sort.dart';
import 'package:ssoss_flutter/features/content/domain/entities/generation_channel_result.dart';
import 'package:ssoss_flutter/features/content/domain/entities/generation_detail.dart';
import 'package:ssoss_flutter/features/content/domain/entities/saved_content.dart';
import 'package:ssoss_flutter/features/content/domain/entities/upload_channel.dart';
import 'package:ssoss_flutter/features/content/domain/repositories/content_repository.dart';

class ContentRepositoryImpl implements ContentRepository {
  ContentRepositoryImpl({
    required ContentRemoteDatasource remoteDatasource,
  }) : _remote = remoteDatasource;

  final ContentRemoteDatasource _remote;
  CancelToken? _activeCancelToken;

  @override
  Future<int> startGeneration(ContentCreateInput input) async {
    _activeCancelToken?.cancel('superseded');
    _activeCancelToken = CancelToken();
    try {
      final response = await _remote.startGeneration(
        GenerationStartRequest.fromEntity(input),
        cancelToken: _activeCancelToken,
      );
      return response.generationId;
    } on DioException catch (e) {
      throw _mapCancel(e);
    }
  }

  @override
  Future<int> startStyleReuse(StyleReuseInput input) async {
    _activeCancelToken?.cancel('superseded');
    _activeCancelToken = CancelToken();
    try {
      final response = await _remote.startStyleReuse(
        contentId: input.contentId,
        contentChannelId: input.contentChannelId,
        request: StyleReuseRequest.fromEntity(input),
        cancelToken: _activeCancelToken,
      );
      return response.generationId;
    } on DioException catch (e) {
      throw _mapCancel(e);
    }
  }

  @override
  Future<GenerationDetail> getGeneration(int generationId) async {
    final model = await _remote.getGeneration(
      generationId,
      cancelToken: _activeCancelToken,
    );
    return model.toEntity();
  }

  @override
  Future<SavedContent> saveContent({
    required int generationId,
    required List<GenerationChannelResult> channels,
  }) async {
    final model = await _remote.saveContent(
      ContentSaveRequest(
        generationId: generationId,
        contents: channels.map((c) => c.toSaveModel()).toList(growable: false),
      ),
    );
    return model.toEntity();
  }

  @override
  Future<ContentChannelContent> editChannel({
    required int contentId,
    required int contentChannelId,
    required GenerationChannelResult channel,
  }) async {
    final saveModel = channel.toSaveModel();
    final model = await _remote.editChannel(
      contentId: contentId,
      contentChannelId: contentChannelId,
      request: ContentChannelEditRequest(
        title: saveModel.title,
        body: saveModel.body,
        hashtags: saveModel.hashtags,
      ),
    );
    return model.toEntity();
  }

  @override
  Future<ContentListPage> listContents({
    UploadChannel? channel,
    ContentSort sort = ContentSort.latest,
    int page = 0,
    int size = 20,
  }) async {
    final model = await _remote.listContents(
      channel: channel == null ? null : ContentCreateApiMapper.channel(channel),
      sort: ContentCreateApiMapper.sort(sort),
      page: page,
      size: size,
    );
    return model.toEntity();
  }

  @override
  Future<ContentDetail> getContent(int contentId) async {
    final model = await _remote.getContent(contentId);
    return model.toEntity();
  }

  @override
  Future<void> deleteContent(int contentId) {
    return _remote.deleteContent(contentId);
  }

  @override
  Future<ContentDetail> renameContent({
    required int contentId,
    required String name,
  }) async {
    final model = await _remote.renameContent(
      contentId: contentId,
      request: ContentRenameRequest(name: name),
    );
    return model.toEntity();
  }

  @override
  void cancelGeneration() {
    _activeCancelToken?.cancel('user_exit');
    _activeCancelToken = null;
  }

  Never _mapCancel(DioException e) {
    if (e.type == DioExceptionType.cancel || CancelToken.isCancel(e)) {
      throw const CancelledException();
    }
    throw e.error is AppException ? e.error as AppException : e;
  }
}
