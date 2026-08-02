import 'package:ssoss_flutter/features/credit/domain/entities/credit_ledger_filter.dart';
import 'package:ssoss_flutter/features/credit/domain/entities/credit_ledger_page.dart';
import 'package:ssoss_flutter/features/credit/domain/repositories/credit_repository.dart';

class ListCreditLedgersUseCase {
  ListCreditLedgersUseCase(this._repository);

  final CreditRepository _repository;

  Future<CreditLedgerPage> call({
    CreditLedgerFilter filter = CreditLedgerFilter.all,
    int page = 0,
    int size = 20,
  }) {
    return _repository.listLedgers(
      filter: filter,
      page: page,
      size: size,
    );
  }
}
