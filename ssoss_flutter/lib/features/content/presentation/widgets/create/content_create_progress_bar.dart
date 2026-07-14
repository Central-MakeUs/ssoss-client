import 'package:flutter/material.dart';
import 'package:ssoss_flutter/common/widgets/text/app_text.dart';

import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';
import 'package:ssoss_flutter/features/content/presentation/cubit/content_create_state.dart';

class ContentCreateProgressBar extends StatelessWidget {
  const ContentCreateProgressBar({
    required this.currentStep,
    super.key,
  });

  final ContentCreateStep currentStep;

  static const _steps = <(ContentCreateStep, String, String)>[
    (ContentCreateStep.channel, '01', '채널 선택'),
    (ContentCreateStep.content, '02', '콘텐츠 설정'),
    (ContentCreateStep.detail, '03', '세부 설정'),
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var i = 0; i < _steps.length; i++) ...[
          if (i > 0) const SizedBox(width: 8),
          Expanded(
            child: _ProgressItem(
              number: _steps[i].$2,
              label: _steps[i].$3,
              isActive: _steps[i].$1 == currentStep,
            ),
          ),
        ],
      ],
    );
  }
}

class _ProgressItem extends StatelessWidget {
  const _ProgressItem({
    required this.number,
    required this.label,
    required this.isActive,
  });

  final String number;
  final String label;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final color = isActive ? AppColors.primary400 : AppColors.neutral300;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            AppText(
              number,
              style: AppTextStyles.h8.copyWith(color: color),
            ),
            const SizedBox(width: 4),
            Flexible(
              child: AppText(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.h8.copyWith(color: color),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          height: 2,
          width: double.infinity,
          color: color,
        ),
      ],
    );
  }
}
