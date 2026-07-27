import 'package:dio/dio.dart';

import 'package:ssoss_flutter/core/network/auth_request_extra.dart';
import 'package:ssoss_flutter/core/network/dio_error_mapper.dart';
import 'package:ssoss_flutter/features/app_version/data/models/app_version_response_model.dart';

/// 앱 버전 조회 원격 API.
abstract class AppVersionRemoteDatasource {
  Future<AppVersionResponseModel> checkVersion({
    required String os,
    required String version,
  });
}

class AppVersionRemoteDatasourceImpl implements AppVersionRemoteDatasource {
  AppVersionRemoteDatasourceImpl(this._dio);

  final Dio _dio;

  static const _pathPrefix = '/v1/app-versions';

  @override
  Future<AppVersionResponseModel> checkVersion({
    required String os,
    required String version,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '$_pathPrefix/$os',
        queryParameters: <String, dynamic>{'version': version},
        options: Options(
          extra: const {AuthRequestExtra.skipAuth: true},
        ),
      );
      return AppVersionResponseModel.fromJson(response.data!);
    } on DioException catch (e) {
      throw mapDioError(e);
    }
  }
}
