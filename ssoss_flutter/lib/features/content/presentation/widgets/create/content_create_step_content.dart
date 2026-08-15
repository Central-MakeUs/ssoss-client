import 'package:flutter/material.dart';
import 'package:ssoss_flutter/common/widgets/button/ssoss_text_button.dart';
import 'package:ssoss_flutter/common/widgets/selection/ssoss_square_selection_button.dart';
import 'package:ssoss_flutter/common/widgets/text/app_text.dart';

import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/constants/assets.dart';
import 'package:ssoss_flutter/core/constants/writing_tone.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';
import 'package:ssoss_flutter/features/content/domain/entities/upload_purpose.dart';

class ContentCreateStepContent extends StatelessWidget {
  const ContentCreateStepContent({
    required this.selectedPurpose,
    required this.selectedTone,
    required this.onSelectPurpose,
    required this.onSelectTone,
    super.key,
  });

  final UploadPurpose? selectedPurpose;
  final WritingTone? selectedTone;
  final ValueChanged<UploadPurpose> onSelectPurpose;
  final ValueChanged<WritingTone> onSelectTone;

  static const _purposes = <({UploadPurpose value, String label, String icon})>[
    (
      value: UploadPurpose.informative,
      label: '정보성',
      icon: AppAssets.icDocument,
    ),
    (
      value: UploadPurpose.eventDiscount,
      label: '이벤트/할인',
      icon: AppAssets.icSale,
    ),
    (
      value: UploadPurpose.newMenuPromo,
      label: '신메뉴/홍보',
      icon: AppAssets.icCoffee,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            AppText(
              '업로드 목적',
              style: AppTextStyles.h5.copyWith(color: AppColors.neutral700),
            ),
            const SizedBox(width: 2),
            AppText(
              '*',
              style: AppTextStyles.h5.copyWith(color: AppColors.primary600),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            for (var i = 0; i < _purposes.length; i++) ...[
              if (i > 0) const SizedBox(width: 12),
              Expanded(
                child: SsossSquareSelectionButton(
                  label: _purposes[i].label,
                  type: selectedPurpose == _purposes[i].value
                      ? SsossSquareSelectionButtonType.primarySelected
                      : SsossSquareSelectionButtonType.normal,
                  iconAsset: _purposes[i].icon,
                  onTap: () => onSelectPurpose(_purposes[i].value),
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 36),
        Row(
          children: [
            AppText(
              '콘텐츠 작성 톤',
              style: AppTextStyles.h5.copyWith(color: AppColors.neutral700),
            ),
            const SizedBox(width: 2),
            AppText(
              '*',
              style: AppTextStyles.h5.copyWith(color: AppColors.primary600),
            ),
          ],
        ),
        const SizedBox(height: 12),
        for (var i = 0; i < WritingTone.values.length; i++) ...[
          if (i > 0) const SizedBox(height: 12),
          SsossTextButton(
            title: WritingTone.values[i].label,
            subtitle: WritingTone.values[i].description,
            width: double.infinity,
            height: 56,
            type: selectedTone == WritingTone.values[i]
                ? SsossTextButtonType.selected
                : SsossTextButtonType.normal,
            onTap: () => onSelectTone(WritingTone.values[i]),
          ),
        ],
      ],
    );
  }
}
