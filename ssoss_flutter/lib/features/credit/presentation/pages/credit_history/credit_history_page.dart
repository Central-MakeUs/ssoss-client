import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ssoss_flutter/common/widgets/app_bar/ssoss_app_bar.dart';
import 'package:ssoss_flutter/common/widgets/toast/ssoss_toast.dart';
import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/features/credit/domain/usecases/list_credit_ledgers_usecase.dart';
import 'package:ssoss_flutter/features/credit/presentation/cubit/credit_balance_cubit.dart';
import 'package:ssoss_flutter/features/credit/presentation/cubit/credit_balance_state.dart';
import 'package:ssoss_flutter/features/credit/presentation/cubit/credit_history_cubit.dart';
import 'package:ssoss_flutter/features/credit/presentation/cubit/credit_history_state.dart';
import 'package:ssoss_flutter/features/credit/presentation/pages/credit_history/credit_history_components.dart';

class CreditHistoryPage extends StatefulWidget {
  const CreditHistoryPage({super.key});

  static const String routeName = 'credit-history';
  static const String routePath = '/credit-history';

  @override
  State<CreditHistoryPage> createState() => _CreditHistoryPageState();
}

class _CreditHistoryPageState extends State<CreditHistoryPage> {
  late final CreditHistoryCubit _historyCubit;

  @override
  void initState() {
    super.initState();
    _historyCubit = CreditHistoryCubit(
      listCreditLedgers: context.read<ListCreditLedgersUseCase>(),
    );
    unawaited(context.read<CreditBalanceCubit>().refresh());
    unawaited(_historyCubit.loadInitial());
  }

  @override
  void dispose() {
    unawaited(_historyCubit.close());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _historyCubit,
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: Column(
            children: [
              SsossAppBar.back(
                title: '크레딧 내역',
                onBack: () => Navigator.of(context).pop(),
              ),
              const Expanded(child: _CreditHistoryView()),
            ],
          ),
        ),
      ),
    );
  }
}

class _CreditHistoryView extends StatefulWidget {
  const _CreditHistoryView();

  @override
  State<_CreditHistoryView> createState() => _CreditHistoryViewState();
}

class _CreditHistoryViewState extends State<_CreditHistoryView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) {
      return;
    }
    final position = _scrollController.position;
    if (position.pixels >= position.maxScrollExtent - 200) {
      unawaited(context.read<CreditHistoryCubit>().loadMore());
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CreditHistoryCubit, CreditHistoryState>(
          listenWhen: (previous, current) =>
              previous.errorMessage != current.errorMessage &&
              current.errorMessage != null,
          listener: (context, state) {
            final message = state.errorMessage;
            if (message == null) {
              return;
            }
            showSsossToast(
              context,
              title: message,
              type: SsossToastType.error,
            );
          },
        ),
        BlocListener<CreditBalanceCubit, CreditBalanceState>(
          listenWhen: (previous, current) =>
              previous.errorMessage != current.errorMessage &&
              current.errorMessage != null,
          listener: (context, state) {
            final message = state.errorMessage;
            if (message == null) {
              return;
            }
            showSsossToast(
              context,
              title: message,
              type: SsossToastType.error,
            );
          },
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          BlocBuilder<CreditBalanceCubit, CreditBalanceState>(
            builder: (context, balanceState) {
              return CreditHistoryBalanceHeader(
                balance: balanceState.balance,
                isLoading: balanceState.isLoading,
              );
            },
          ),
          const SizedBox(height: 12),
          BlocBuilder<CreditHistoryCubit, CreditHistoryState>(
            buildWhen: (previous, current) => previous.filter != current.filter,
            builder: (context, state) {
              return CreditHistoryFilterBar(
                selectedFilter: state.filter,
                onFilterSelected: (filter) {
                  unawaited(
                    context.read<CreditHistoryCubit>().selectFilter(filter),
                  );
                },
              );
            },
          ),
          const SizedBox(height: 12),
          Expanded(
            child: BlocBuilder<CreditHistoryCubit, CreditHistoryState>(
              builder: (context, state) {
                if (state.isLoading && state.items.isEmpty) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primary400,
                    ),
                  );
                }

                return CustomScrollView(
                  controller: _scrollController,
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  slivers: [
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return CreditHistoryLedgerTile(
                            ledger: state.items[index],
                          );
                        },
                        childCount: state.items.length,
                      ),
                    ),
                    if (state.isLoadingMore)
                      const SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 24),
                          child: Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primary400,
                            ),
                          ),
                        ),
                      ),
                    const SliverFillRemaining(
                      hasScrollBody: false,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: CreditHistoryGuideSection(),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
