import 'package:flutter/material.dart';
import 'package:ssoss_flutter/common/widgets/text/app_text.dart';

import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';

/// 다른 채널용 생성 안내 배너.
class ContentOtherChannelInfoBanner extends StatelessWidget {
  const ContentOtherChannelInfoBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primary50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.lightbulb_outline,
                size: 20,
                color: AppColors.primary700,
              ),
              const SizedBox(width: 8),
              AppText(
                '채널별 콘텐츠 만들기',
                style: AppTextStyles.h5.copyWith(color: AppColors.primary700),
              ),
            ],
          ),
          const SizedBox(height: 8),
          AppText(
            '블로그 글을 활용해 다른 채널용 짧은 문구를\n만들 수 있어요',
            style: AppTextStyles.b4.copyWith(color: AppColors.neutral700),
          ),
        ],
      ),
    );
  }
}
