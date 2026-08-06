import 'package:dio/dio.dart';

import 'package:ssoss_flutter/core/network/dio_error_mapper.dart';
import 'package:ssoss_flutter/features/hashtag/data/datasources/hashtag_remote_datasource.dart';
import 'package:ssoss_flutter/features/hashtag/data/models/hashtag_bundle_list_response_model.dart';

class HashtagRemoteDatasourceImpl implements HashtagRemoteDatasource {
  HashtagRemoteDatasourceImpl(this._dio);

  final Dio _dio;

  static const _catalogPath = '/v1/hashtag-bundles';
  static const _memberBundlesPath = '/v1/members/me/hashtag-bundles';

  @override
  Future<HashtagBundleListResponseModel> listBundles({
    String? keyword,
    int page = 0,
    int size = 20,
    CancelToken? cancelToken,
  }) async {
    try {
      final trimmedKeyword = keyword?.trim();
      final response = await _dio.get<Map<String, dynamic>>(
        _catalogPath,
        queryParameters: <String, dynamic>{
          if (trimmedKeyword != null && trimmedKeyword.isNotEmpty)
            'keyword': trimmedKeyword,
          'page': page,
          'size': size,
        },
        cancelToken: cancelToken,
      );
      return HashtagBundleListResponseModel.fromJson(response.data!);
    } on DioException catch (e) {
      throw mapDioError(e);
    }
  }

  @override
  Future<void> bookmarkBundle(
    int bundleId, {
    CancelToken? cancelToken,
  }) async {
    try {
      await _dio.put<void>(
        '$_memberBundlesPath/$bundleId',
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      throw mapDioError(e);
    }
  }

  @override
  Future<void> unbookmarkBundle(
    int bundleId, {
    CancelToken? cancelToken,
  }) async {
    try {
      await _dio.delete<void>(
        '$_memberBundlesPath/$bundleId',
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      throw mapDioError(e);
    }
  }
}
