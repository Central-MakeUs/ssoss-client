import 'package:ssoss_flutter/features/credit/domain/entities/credit_ledger.dart';

class CreditLedgerPage {
  const CreditLedgerPage({
    required this.totalCount,
    required this.page,
    required this.size,
    required this.hasNext,
    required this.ledgers,
  });

  final int totalCount;
  final int page;
  final int size;
  final bool hasNext;
  final List<CreditLedger> ledgers;
}
