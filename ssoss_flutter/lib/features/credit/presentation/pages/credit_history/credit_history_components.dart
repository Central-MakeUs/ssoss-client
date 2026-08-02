import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:ssoss_flutter/common/widgets/selection/ssoss_filter_chip.dart';
import 'package:ssoss_flutter/common/widgets/text/app_text.dart';
import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/constants/assets.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';
import 'package:ssoss_flutter/features/credit/domain/entities/credit_ledger.dart';
import 'package:ssoss_flutter/features/credit/domain/entities/credit_ledger_filter.dart';
import 'package:ssoss_flutter/features/credit/domain/entities/credit_ledger_type.dart';

class CreditHistoryBalanceHeader extends StatelessWidget {
  const CreditHistoryBalanceHeader({
    required this.isLoading,
    super.key,
    this.balance,
  });

  final int? balance;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.neutral200),
        ),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            AppAssets.icCoins,
            width: 20,
            height: 20,
            colorFilter: const ColorFilter.mode(
              AppColors.neutral500,
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(width: 6),
          AppText(
            '크레딧',
            style: AppTextStyles.h6.copyWith(color: AppColors.neutral500),
          ),
          const Spacer(),
          if (isLoading)
            const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: AppColors.primary400,
              ),
            )
          else ...[
            AppText(
              '${balance ?? 0}',
              style: AppTextStyles.h4.copyWith(color: AppColors.primary500),
            ),
            const SizedBox(width: 4),
            SvgPicture.asset(
              AppAssets.icCredit,
              width: 16,
              height: 16,
              colorFilter: const ColorFilter.mode(
                AppColors.primary500,
                BlendMode.srcIn,
              ),
            ),
          ],
          // TODO: 충전 기능 활성화 시 아래 주석 해제
          // const SizedBox(width: 12),
          // SsossButton(
          //   label: '충전하기',
          //   size: SsossButtonSize.small,
          //   type: SsossButtonType.outline,
          //   onPressed: () {},
          // ),
        ],
      ),
    );
  }
}

class CreditHistoryFilterBar extends StatelessWidget {
  const CreditHistoryFilterBar({
    required this.selectedFilter,
    required this.onFilterSelected,
    super.key,
  });

  final CreditLedgerFilter selectedFilter;
  final ValueChanged<CreditLedgerFilter> onFilterSelected;

  static const filters = CreditLedgerFilter.values;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          for (final filter in filters) ...[
            SsossFilterChip(
              label: filter.label,
              state: filter == selectedFilter
                  ? SsossFilterChipState.selected
                  : SsossFilterChipState.normal,
              backgroundColor: filter == selectedFilter
                  ? AppColors.black
                  : AppColors.neutral100,
              foregroundColor:
                  filter == selectedFilter ? AppColors.white : AppColors.black,
              onTap: () => onFilterSelected(filter),
            ),
            if (filter != filters.last) const SizedBox(width: 8),
          ],
        ],
      ),
    );
  }
}

class CreditHistoryLedgerTile extends StatelessWidget {
  const CreditHistoryLedgerTile({
    required this.ledger,
    super.key,
  });

  final CreditLedger ledger;

  @override
  Widget build(BuildContext context) {
    final isGain = ledger.isGain;
    final amountText = isGain
        ? '+${ledger.amount}개'
        : '${ledger.amount}개'; // amount already negative

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.neutral200),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  ledger.description,
                  style: AppTextStyles.h6.copyWith(color: AppColors.neutral800),
                ),
                const SizedBox(height: 2),
                AppText(
                  _formatDate(ledger.occurredAt),
                  style: AppTextStyles.b6.copyWith(color: AppColors.neutral400),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              AppText(
                amountText,
                style: AppTextStyles.h6.copyWith(
                  color: isGain ? AppColors.primary500 : AppColors.neutral600,
                ),
              ),
              const SizedBox(height: 2),
              AppText(
                ledger.type.label,
                style: AppTextStyles.b6.copyWith(color: AppColors.neutral500),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static String _formatDate(DateTime date) {
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '${date.year}.$month.$day';
  }
}

class CreditHistoryGuideSection extends StatelessWidget {
  const CreditHistoryGuideSection({super.key});

  static const _guides = [
    '크레딧은 콘텐츠 1건 생성 시 5C가 차감됩니다.',
    '무료 크레딧은 매월 3일에 지급되며 당월 말 만료되고 이월이 불가합니다.',
  ];

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.neutral50,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              '크레딧 이용안내',
              style: AppTextStyles.b4.copyWith(color: AppColors.black),
            ),
            const SizedBox(height: 12),
            for (final guide in _guides) ...[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Container(
                      width: 3,
                      height: 3,
                      decoration: const BoxDecoration(
                        color: AppColors.neutral600,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: AppText(
                      guide,
                      style: AppTextStyles.b6.copyWith(
                        color: AppColors.neutral600,
                      ),
                    ),
                  ),
                ],
              ),
              if (guide != _guides.last) const SizedBox(height: 2),
            ],
          ],
        ),
      ),
    );
  }
}
