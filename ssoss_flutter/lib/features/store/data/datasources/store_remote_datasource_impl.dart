import 'package:dio/dio.dart';

import 'package:ssoss_flutter/core/network/dio_error_mapper.dart';
import 'package:ssoss_flutter/features/store/data/datasources/store_remote_datasource.dart';
import 'package:ssoss_flutter/features/store/data/models/store_info_requests.dart';
import 'package:ssoss_flutter/features/store/data/models/store_info_response_model.dart';

class StoreRemoteDatasourceImpl implements StoreRemoteDatasource {
  StoreRemoteDatasourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<StoreInfoResponseModel> getMyStore() async {
    try {
      final response = await _dio.get<Map<String, dynamic>>('/v1/stores/me');
      return StoreInfoResponseModel.fromJson(response.data ?? const {});
    } on DioException catch (e) {
      throw mapDioError(e);
    }
  }

  @override
  Future<void> saveBasicInfo(StoreBasicInfoRequest request) async {
    try {
      await _dio.put<void>(
        '/v1/stores/me/basic',
        data: request.toJson(),
      );
    } on DioException catch (e) {
      throw mapDioError(e);
    }
  }

  @override
  Future<void> saveOperationInfo(StoreOperationInfoRequest request) async {
    try {
      await _dio.put<void>(
        '/v1/stores/me/operation',
        data: request.toJson(),
      );
    } on DioException catch (e) {
      throw mapDioError(e);
    }
  }

  @override
  Future<void> saveContentInfo(StoreContentInfoRequest request) async {
    try {
      await _dio.put<void>(
        '/v1/stores/me/content',
        data: request.toJson(),
      );
    } on DioException catch (e) {
      throw mapDioError(e);
    }
  }
}
