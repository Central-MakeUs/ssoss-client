import 'package:freezed_annotation/freezed_annotation.dart';

part 'credit_balance_state.freezed.dart';

@freezed
abstract class CreditBalanceState with _$CreditBalanceState {
  const factory CreditBalanceState({
    @Default(false) bool isLoading,
    int? balance,
    String? errorMessage,
  }) = _CreditBalanceState;
}
