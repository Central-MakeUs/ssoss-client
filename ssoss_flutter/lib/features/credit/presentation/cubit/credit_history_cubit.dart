import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ssoss_flutter/features/credit/domain/entities/credit_ledger_filter.dart';
import 'package:ssoss_flutter/features/credit/domain/usecases/list_credit_ledgers_usecase.dart';
import 'package:ssoss_flutter/features/credit/presentation/cubit/credit_history_state.dart';

class CreditHistoryCubit extends Cubit<CreditHistoryState> {
  CreditHistoryCubit({
    required ListCreditLedgersUseCase listCreditLedgers,
  })  : _listCreditLedgers = listCreditLedgers,
        super(const CreditHistoryState());

  static const int pageSize = 20;

  final ListCreditLedgersUseCase _listCreditLedgers;

  Future<void> loadInitial() => _load(page: 0, replace: true);

  Future<void> refresh() => _load(page: 0, replace: true);

  Future<void> loadMore() async {
    if (!state.hasNext || state.isLoadingMore || state.isLoading) {
      return;
    }
    emit(state.copyWith(isLoadingMore: true, errorMessage: null));
    await _load(page: state.page + 1, replace: false);
  }

  Future<void> selectFilter(CreditLedgerFilter filter) async {
    if (filter == state.filter) {
      return;
    }
    emit(state.copyWith(filter: filter));
    await _load(page: 0, replace: true);
  }

  Future<void> _load({
    required int page,
    required bool replace,
  }) async {
    if (replace) {
      emit(
        state.copyWith(
          isLoading: true,
          errorMessage: null,
        ),
      );
    }
    try {
      final result = await _listCreditLedgers(
        filter: state.filter,
        page: page,
        size: pageSize,
      );
      if (isClosed) {
        return;
      }
      emit(
        state.copyWith(
          items: replace ? result.ledgers : [...state.items, ...result.ledgers],
          page: result.page,
          hasNext: result.hasNext,
          isLoading: false,
          isLoadingMore: false,
          errorMessage: null,
        ),
      );
    } catch (_) {
      if (isClosed) {
        return;
      }
      emit(
        state.copyWith(
          isLoading: false,
          isLoadingMore: false,
          errorMessage: '크레딧 내역을 불러오지 못했습니다.',
        ),
      );
    }
  }
}
