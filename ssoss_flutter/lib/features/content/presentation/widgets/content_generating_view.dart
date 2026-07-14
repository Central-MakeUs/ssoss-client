import 'package:flutter/material.dart';
import 'package:ssoss_flutter/common/widgets/text/app_text.dart';

import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';

/// 생성 중 본문. 로딩 GIF 자리는 [placeholder] Container 로 둔다.
class ContentGeneratingView extends StatelessWidget {
  const ContentGeneratingView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // TODO: 추후 GIF 에셋으로 교체
              Container(
                width: 117,
                height: 102,
                decoration: BoxDecoration(
                  color: AppColors.primary50,
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              const SizedBox(height: 24),
              AppText(
                '콘텐츠 발행 중이에요',
                textAlign: TextAlign.center,
                style: AppTextStyles.h2.copyWith(color: AppColors.neutral700),
              ),
              const SizedBox(height: 12),
              AppText(
                '*응답이 진행된 만큼\n충전된 크레딧이 차감될 수 있어요',
                textAlign: TextAlign.center,
                style: AppTextStyles.b4.copyWith(color: AppColors.neutral400),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
