import 'package:flutter/material.dart';
import 'package:ssoss_flutter/common/widgets/button/ssoss_button.dart';
import 'package:ssoss_flutter/common/widgets/text/app_text.dart';

import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/constants/assets.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';

class ContentHeroSection extends StatelessWidget {
  const ContentHeroSection({
    super.key,
    this.onCreateTap,
  });

  final VoidCallback? onCreateTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    '오늘은 어떤 콘텐츠를\n만들어 볼까요?',
                    style: AppTextStyles.h4.copyWith(color: AppColors.black),
                  ),
                  const SizedBox(height: 4),
                  AppText(
                    '우리 가게 맞춤 콘텐츠 생성',
                    style: AppTextStyles.b5.copyWith(
                      color: AppColors.primary600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Image.asset(
              AppAssets.imgContent,
              width: 108,
              height: 108,
              fit: BoxFit.contain,
            ),
          ],
        ),
        const SizedBox(height: 16),
        SsossButton(
          label: '생성하러 가기',
          size: SsossButtonSize.medium,
          type: SsossButtonType.primary,
          width: double.infinity,
          onPressed: onCreateTap,
        ),
      ],
    );
  }
}
