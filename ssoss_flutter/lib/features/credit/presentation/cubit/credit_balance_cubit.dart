import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ssoss_flutter/features/credit/domain/usecases/get_credit_balance_usecase.dart';
import 'package:ssoss_flutter/features/credit/presentation/cubit/credit_balance_state.dart';

class CreditBalanceCubit extends Cubit<CreditBalanceState> {
  CreditBalanceCubit({
    required GetCreditBalanceUseCase getCreditBalance,
  })  : _getCreditBalance = getCreditBalance,
        super(const CreditBalanceState());

  final GetCreditBalanceUseCase _getCreditBalance;

  Future<void> load() => _fetch();

  Future<void> refresh() => _fetch();

  Future<void> _fetch() async {
    emit(
      state.copyWith(
        isLoading: true,
        errorMessage: null,
      ),
    );
    try {
      final result = await _getCreditBalance();
      if (isClosed) {
        return;
      }
      emit(
        CreditBalanceState(
          isLoading: false,
          balance: result.balance,
        ),
      );
    } catch (_) {
      if (isClosed) {
        return;
      }
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: '크레딧 잔액을 불러오지 못했습니다.',
        ),
      );
    }
  }
}
