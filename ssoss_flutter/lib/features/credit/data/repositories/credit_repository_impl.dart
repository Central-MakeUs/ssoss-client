import 'package:ssoss_flutter/features/credit/data/datasources/credit_remote_datasource.dart';
import 'package:ssoss_flutter/features/credit/data/models/credit_balance_response_model.dart';
import 'package:ssoss_flutter/features/credit/data/models/credit_ledger_list_response_model.dart';
import 'package:ssoss_flutter/features/credit/domain/entities/credit_balance.dart';
import 'package:ssoss_flutter/features/credit/domain/entities/credit_ledger_filter.dart';
import 'package:ssoss_flutter/features/credit/domain/entities/credit_ledger_page.dart';
import 'package:ssoss_flutter/features/credit/domain/repositories/credit_repository.dart';

class CreditRepositoryImpl implements CreditRepository {
  CreditRepositoryImpl({
    required CreditRemoteDatasource remoteDatasource,
  }) : _remote = remoteDatasource;

  final CreditRemoteDatasource _remote;

  @override
  Future<CreditBalance> getBalance() async {
    final model = await _remote.getBalance();
    return model.toEntity();
  }

  @override
  Future<CreditLedgerPage> listLedgers({
    CreditLedgerFilter filter = CreditLedgerFilter.all,
    int page = 0,
    int size = 20,
  }) async {
    final model = await _remote.listLedgers(
      type: filter.apiValue,
      page: page,
      size: size,
    );
    return model.toEntity();
  }
}
