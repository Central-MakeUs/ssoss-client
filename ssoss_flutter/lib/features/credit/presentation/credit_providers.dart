import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'package:ssoss_flutter/features/credit/data/datasources/credit_remote_datasource.dart';
import 'package:ssoss_flutter/features/credit/data/datasources/credit_remote_datasource_impl.dart';
import 'package:ssoss_flutter/features/credit/data/repositories/credit_repository_impl.dart';
import 'package:ssoss_flutter/features/credit/domain/repositories/credit_repository.dart';
import 'package:ssoss_flutter/features/credit/domain/usecases/get_credit_balance_usecase.dart';
import 'package:ssoss_flutter/features/credit/domain/usecases/list_credit_ledgers_usecase.dart';

/// credit 피처 전용 provider 묶음.
class CreditProviders {
  CreditProviders._();

  static List<SingleChildWidget> build() => [
        ProxyProvider<Dio, CreditRemoteDatasource>(
          update: (_, dio, __) => CreditRemoteDatasourceImpl(dio),
        ),
        ProxyProvider<CreditRemoteDatasource, CreditRepository>(
          update: (_, remote, __) => CreditRepositoryImpl(
            remoteDatasource: remote,
          ),
        ),
        ProxyProvider<CreditRepository, GetCreditBalanceUseCase>(
          update: (_, repository, __) => GetCreditBalanceUseCase(repository),
        ),
        ProxyProvider<CreditRepository, ListCreditLedgersUseCase>(
          update: (_, repository, __) => ListCreditLedgersUseCase(repository),
        ),
      ];
}
