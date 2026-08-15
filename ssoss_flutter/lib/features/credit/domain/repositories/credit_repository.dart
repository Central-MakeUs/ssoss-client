import 'package:ssoss_flutter/features/credit/domain/entities/credit_balance.dart';
import 'package:ssoss_flutter/features/credit/domain/entities/credit_ledger_filter.dart';
import 'package:ssoss_flutter/features/credit/domain/entities/credit_ledger_page.dart';

abstract class CreditRepository {
  Future<CreditBalance> getBalance();

  Future<CreditLedgerPage> listLedgers({
    CreditLedgerFilter filter = CreditLedgerFilter.all,
    int page = 0,
    int size = 20,
  });
}
