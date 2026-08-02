enum CreditLedgerFilter {
  all,
  use,
  gain,
}

extension CreditLedgerFilterX on CreditLedgerFilter {
  String get apiValue => switch (this) {
        CreditLedgerFilter.all => 'ALL',
        CreditLedgerFilter.use => 'USE',
        CreditLedgerFilter.gain => 'GAIN',
      };

  String get label => switch (this) {
        CreditLedgerFilter.all => '전체',
        CreditLedgerFilter.use => '사용',
        CreditLedgerFilter.gain => '지급',
      };
}
