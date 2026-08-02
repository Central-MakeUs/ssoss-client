import 'package:dio/dio.dart';

import 'package:ssoss_flutter/features/credit/data/models/credit_balance_response_model.dart';
import 'package:ssoss_flutter/features/credit/data/models/credit_ledger_list_response_model.dart';

abstract class CreditRemoteDatasource {
  Future<CreditBalanceResponseModel> getBalance({CancelToken? cancelToken});

  Future<CreditLedgerListResponseModel> listLedgers({
    String type = 'ALL',
    int page = 0,
    int size = 20,
    CancelToken? cancelToken,
  });
}
