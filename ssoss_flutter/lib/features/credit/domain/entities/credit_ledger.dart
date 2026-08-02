import 'package:ssoss_flutter/features/credit/domain/entities/credit_ledger_type.dart';

class CreditLedger {
  const CreditLedger({
    required this.ledgerId,
    required this.type,
    required this.description,
    required this.amount,
    required this.occurredAt,
  });

  final int ledgerId;
  final CreditLedgerType type;
  final String description;
  final int amount;
  final DateTime occurredAt;

  bool get isGain => amount >= 0;
}
