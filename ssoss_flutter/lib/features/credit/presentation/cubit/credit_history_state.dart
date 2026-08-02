import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:ssoss_flutter/features/credit/domain/entities/credit_ledger.dart';
import 'package:ssoss_flutter/features/credit/domain/entities/credit_ledger_filter.dart';

part 'credit_history_state.freezed.dart';

@freezed
abstract class CreditHistoryState with _$CreditHistoryState {
  const factory CreditHistoryState({
    @Default(CreditLedgerFilter.all) CreditLedgerFilter filter,
    @Default(<CreditLedger>[]) List<CreditLedger> items,
    @Default(0) int page,
    @Default(false) bool hasNext,
    @Default(false) bool isLoading,
    @Default(false) bool isLoadingMore,
    String? errorMessage,
  }) = _CreditHistoryState;
}
