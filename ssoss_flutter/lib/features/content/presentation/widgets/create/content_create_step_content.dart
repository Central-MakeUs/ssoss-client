import 'package:flutter/material.dart';
import 'package:ssoss_flutter/common/widgets/button/ssoss_text_button.dart';
import 'package:ssoss_flutter/common/widgets/selection/ssoss_square_selection_button.dart';
import 'package:ssoss_flutter/common/widgets/text/app_text.dart';

import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';
import 'package:ssoss_flutter/features/content/domain/entities/content_tone.dart';
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
  final ContentTone? selectedTone;
  final ValueChanged<UploadPurpose> onSelectPurpose;
  final ValueChanged<ContentTone> onSelectTone;

  static const _purposes = <({UploadPurpose value, String label, IconData icon})>[
    (
      value: UploadPurpose.informative,
      label: '정보성',
      icon: Icons.description_outlined,
    ),
    (
      value: UploadPurpose.eventDiscount,
      label: '이벤트/할인',
      icon: Icons.local_offer_outlined,
    ),
    (
      value: UploadPurpose.newMenuPromo,
      label: '신메뉴/홍보',
      icon: Icons.local_cafe_outlined,
    ),
  ];

  static const _tones = <({ContentTone value, String label, String description})>[
    (
      value: ContentTone.daily,
      label: '일상형',
      description: '자연스럽고 편안한 말투',
    ),
    (
      value: ContentTone.emotional,
      label: '감성형',
      description: '분위기와 감정을 살린 말투',
    ),
    (
      value: ContentTone.informational,
      label: '정보형',
      description: '메뉴, 재료, 특징을 중심으로 설명하는 말투',
    ),
    (
      value: ContentTone.promotional,
      label: '홍보형',
      description: '장점과 방문 유도를 강조하는 말투',
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
                  icon: Icon(
                    _purposes[i].icon,
                    size: 28,
                    color: selectedPurpose == _purposes[i].value
                        ? AppColors.primary500
                        : AppColors.neutral400,
                  ),
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
        for (var i = 0; i < _tones.length; i++) ...[
          if (i > 0) const SizedBox(height: 12),
          SsossTextButton(
            title: _tones[i].label,
            subtitle: _tones[i].description,
            width: double.infinity,
            height: 56,
            type: selectedTone == _tones[i].value
                ? SsossTextButtonType.selected
                : SsossTextButtonType.normal,
            onTap: () => onSelectTone(_tones[i].value),
          ),
        ],
      ],
    );
  }
}
