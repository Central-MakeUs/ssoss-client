import 'package:dio/dio.dart';

import 'package:ssoss_flutter/core/network/dio_error_mapper.dart';
import 'package:ssoss_flutter/features/credit/data/datasources/credit_remote_datasource.dart';
import 'package:ssoss_flutter/features/credit/data/models/credit_balance_response_model.dart';
import 'package:ssoss_flutter/features/credit/data/models/credit_ledger_list_response_model.dart';

class CreditRemoteDatasourceImpl implements CreditRemoteDatasource {
  CreditRemoteDatasourceImpl(this._dio);

  final Dio _dio;

  static const _balancePath = '/v1/credits/me';
  static const _ledgersPath = '/v1/credits/me/ledgers';

  @override
  Future<CreditBalanceResponseModel> getBalance({
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        _balancePath,
        cancelToken: cancelToken,
      );
      return CreditBalanceResponseModel.fromJson(response.data!);
    } on DioException catch (e) {
      throw mapDioError(e);
    }
  }

  @override
  Future<CreditLedgerListResponseModel> listLedgers({
    String type = 'ALL',
    int page = 0,
    int size = 20,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        _ledgersPath,
        queryParameters: <String, dynamic>{
          'type': type,
          'page': page,
          'size': size,
        },
        cancelToken: cancelToken,
      );
      return CreditLedgerListResponseModel.fromJson(response.data!);
    } on DioException catch (e) {
      throw mapDioError(e);
    }
  }
}
