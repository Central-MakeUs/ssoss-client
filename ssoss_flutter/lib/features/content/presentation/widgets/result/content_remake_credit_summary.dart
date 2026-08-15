import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:ssoss_flutter/common/widgets/text/app_text.dart';
import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/constants/assets.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';

/// 다시 생성 확인 모달용 크레딧 차감·보유 요약.
class ContentRemakeCreditSummary extends StatelessWidget {
  const ContentRemakeCreditSummary({
    required this.deductAmount,
    required this.balance,
    super.key,
    this.isBalanceLoading = false,
  });

  final int deductAmount;
  final int? balance;
  final bool isBalanceLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.neutral50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          _CreditRow(
            label: '차감 크레딧',
            value: '$deductAmount',
            valueColor: AppColors.primary500,
          ),
          const SizedBox(height: 2),
          _CreditRow(
            label: '보유 크레딧',
            value: isBalanceLoading ? null : '${balance ?? 0}',
            valueColor: AppColors.neutral500,
            isLoading: isBalanceLoading,
          ),
        ],
      ),
    );
  }
}

class _CreditRow extends StatelessWidget {
  const _CreditRow({
    required this.label,
    required this.valueColor,
    this.value,
    this.isLoading = false,
  });

  final String label;
  final String? value;
  final Color valueColor;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppText(
          label,
          style: AppTextStyles.b4.copyWith(color: AppColors.neutral500),
        ),
        const Spacer(),
        if (isLoading)
          const SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: AppColors.primary400,
            ),
          )
        else ...[
          AppText(
            value ?? '0',
            style: AppTextStyles.b4.copyWith(color: valueColor),
          ),
          const SizedBox(width: 2),
          SvgPicture.asset(
            AppAssets.icCredit,
            width: 16,
            height: 16,
            colorFilter: ColorFilter.mode(
              valueColor,
              BlendMode.srcIn,
            ),
          ),
        ],
      ],
    );
  }
}
