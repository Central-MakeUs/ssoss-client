enum CreditLedgerType {
  deduct,
  grant,
  unknown,
}

extension CreditLedgerTypeX on CreditLedgerType {
  String get label => switch (this) {
        CreditLedgerType.deduct => '사용',
        CreditLedgerType.grant => '지급',
        CreditLedgerType.unknown => '지급',
      };

  bool get isUse => this == CreditLedgerType.deduct;

  static CreditLedgerType fromApi(String value) {
    switch (value.toUpperCase()) {
      case 'DEDUCT':
        return CreditLedgerType.deduct;
      case 'GRANT':
        return CreditLedgerType.grant;
      default:
        return CreditLedgerType.unknown;
    }
  }
}
