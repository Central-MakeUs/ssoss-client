import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import 'package:ssoss_flutter/common/widgets/text/app_text.dart';
import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/constants/assets.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';
import 'package:ssoss_flutter/features/home/presentation/pages/home_page.dart';
import 'package:ssoss_flutter/features/onboarding/presentation/pages/onboarding_components.dart';

class OnboardingStoreInfoCompletePage extends StatelessWidget {
  const OnboardingStoreInfoCompletePage({super.key});

  static const String routeName = 'onboarding-store-info-complete';
  static const String routePath = '/onboarding/store-info-complete';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            OnboardingTopBar(
              showBackButton: true,
              onBack: () {
                if (Navigator.of(context).canPop()) {
                  Navigator.of(context).pop();
                  return;
                }
                context.go('/onboarding/operation-info');
              },
            ),
            const Expanded(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 108),
                  child: _CompleteContent(),
                ),
              ),
            ),
            OnboardingActionBar(
              primaryLabel: '시작하기',
              showSkipButton: false,
              onPrimaryTap: () => context.go(HomePage.routePath),
              onSkipTap: () => context.go(HomePage.routePath),
            ),
          ],
        ),
      ),
    );
  }
}

class _CompleteContent extends StatelessWidget {
  const _CompleteContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          AppAssets.icOnboardingStoreInfoComplete,
          width: 135,
          height: 135,
        ),
        const SizedBox(height: 16),
        AppText(
          '매장 정보 입력이\n완료되었어요',
          textAlign: TextAlign.center,
          style: AppTextStyles.h3.copyWith(color: const Color(0xFF151515)),
        ),
        const SizedBox(height: 8),
        AppText(
          '저장한 정보는 마이페이지에서\n언제든 수정할 수 있어요',
          textAlign: TextAlign.center,
          style: AppTextStyles.b4.copyWith(color: const Color(0xFF8C8C8C)),
        ),
      ],
    );
  }
}
