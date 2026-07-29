import 'package:flutter/material.dart';

import 'package:ssoss_flutter/common/widgets/input/ssoss_text_field.dart';
import 'package:ssoss_flutter/common/widgets/selection/ssoss_radio.dart';
import 'package:ssoss_flutter/common/widgets/text/app_text.dart';
import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';

class WithdrawReasonOption {
  const WithdrawReasonOption(this.label);

  final String label;
}

const List<WithdrawReasonOption> kWithdrawReasonOptions = [
  WithdrawReasonOption('원하는 기능이 없어요'),
  WithdrawReasonOption('콘텐츠 품질이 기대와 달랐어요'),
  WithdrawReasonOption('사용 방법이 어려웠어요'),
  WithdrawReasonOption('자주 사용하지 않게 되었어요'),
  WithdrawReasonOption('기타'),
];

const int kWithdrawReasonOtherIndex = 4;

class WithdrawReasonHeader extends StatelessWidget {
  const WithdrawReasonHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppText(
          '탈퇴하시려는 이유를 알려주세요',
          textAlign: TextAlign.start,
          style: AppTextStyles.h3.copyWith(color: AppColors.black),
        ),
        const SizedBox(height: 8),
        AppText(
          '더 나은 서비스를 만들기 위해 의견을 남겨주시면\n큰 도움이 됩니다',
          textAlign: TextAlign.start,
          style: AppTextStyles.b4.copyWith(color: AppColors.neutral500),
        ),
      ],
    );
  }
}

class WithdrawReasonOptionList extends StatelessWidget {
  const WithdrawReasonOptionList({
    required this.selectedIndex,
    required this.isDisabled,
    required this.onSelected,
    required this.otherController,
    super.key,
  });

  final int? selectedIndex;
  final bool isDisabled;
  final ValueChanged<int> onSelected;
  final TextEditingController otherController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (var i = 0; i < kWithdrawReasonOptions.length; i++) ...[
          if (i > 0) const SizedBox(height: 16),
          SsossRadio(
            isChecked: selectedIndex == i,
            isDisabled: isDisabled,
            label: kWithdrawReasonOptions[i].label,
            gap: 14,
            labelColor: AppColors.neutral600,
            textStyle: AppTextStyles.b4,
            onTap: () => onSelected(i),
          ),
          if (i == kWithdrawReasonOtherIndex &&
              selectedIndex == kWithdrawReasonOtherIndex) ...[
            const SizedBox(height: 14),
            Padding(
              padding: const EdgeInsets.only(left: 34),
              child: SsossTextField(
                controller: otherController,
                enabled: !isDisabled,
                multiline: true,
                hintText: '의견을 자유롭게 작성해주세요.',
                hintColor: AppColors.neutral500,
                height: 68,
              ),
            ),
          ],
        ],
      ],
    );
  }
}
