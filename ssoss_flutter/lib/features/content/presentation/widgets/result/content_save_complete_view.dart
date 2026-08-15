import 'package:flutter/material.dart';
import 'package:ssoss_flutter/common/widgets/button/ssoss_button.dart';
import 'package:ssoss_flutter/common/widgets/text/app_text.dart';

import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/constants/assets.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';

/// 저장 완료 본문.
class ContentSaveCompleteView extends StatelessWidget {
  const ContentSaveCompleteView({
    super.key,
    this.onViewHistory,
  });

  final VoidCallback? onViewHistory;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    AppAssets.imgComplete,
                    width: 135,
                    height: 135,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 24),
                  AppText(
                    '저장이 완료되었어요',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.h2.copyWith(
                      color: AppColors.black,
                    ),
                  ),
                  const SizedBox(height: 12),
                  AppText(
                    '저장한 콘텐츠는 저장 내역에서\n확인할 수 있어요',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.b4.copyWith(
                      color: AppColors.neutral400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
          child: SsossButton(
            type: SsossButtonType.primary,
            label: '저장 내역 보기',
            width: double.infinity,
            onPressed: onViewHistory,
          ),
        ),
      ],
    );
  }
}
