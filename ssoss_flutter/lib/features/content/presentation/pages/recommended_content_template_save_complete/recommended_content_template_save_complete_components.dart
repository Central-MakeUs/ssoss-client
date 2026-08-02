import 'package:flutter/material.dart';

import 'package:ssoss_flutter/common/widgets/button/ssoss_button.dart';
import 'package:ssoss_flutter/common/widgets/text/app_text.dart';
import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/constants/assets.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';

class RecommendedContentTemplateSaveCompleteBody extends StatelessWidget {
  const RecommendedContentTemplateSaveCompleteBody({
    required this.onViewHistory,
    required this.onViewTemplates,
    super.key,
  });

  final VoidCallback onViewHistory;
  final VoidCallback onViewTemplates;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Expanded(
          child: RecommendedContentTemplateSaveCompleteMessage(),
        ),
        RecommendedContentTemplateSaveCompleteActions(
          onViewHistory: onViewHistory,
          onViewTemplates: onViewTemplates,
        ),
      ],
    );
  }
}

class RecommendedContentTemplateSaveCompleteMessage extends StatelessWidget {
  const RecommendedContentTemplateSaveCompleteMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
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
              style: AppTextStyles.h3.copyWith(color: AppColors.black),
            ),
            const SizedBox(height: 8),
            AppText(
              '저장한 콘텐츠는 저장 내역에서\n확인할 수 있어요',
              textAlign: TextAlign.center,
              style: AppTextStyles.b4.copyWith(color: AppColors.neutral400),
            ),
          ],
        ),
      ),
    );
  }
}

class RecommendedContentTemplateSaveCompleteActions extends StatelessWidget {
  const RecommendedContentTemplateSaveCompleteActions({
    required this.onViewHistory,
    required this.onViewTemplates,
    super.key,
  });

  final VoidCallback onViewHistory;
  final VoidCallback onViewTemplates;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
        child: Column(
          children: [
            SsossButton(
              label: '저장 내역 보기',
              width: double.infinity,
              height: 56,
              type: SsossButtonType.primary,
              onPressed: onViewHistory,
            ),
            const SizedBox(height: 12),
            SsossButton(
              label: '다른 템플릿 보기',
              width: double.infinity,
              height: 56,
              type: SsossButtonType.secondary,
              onPressed: onViewTemplates,
            ),
          ],
        ),
      ),
    );
  }
}
