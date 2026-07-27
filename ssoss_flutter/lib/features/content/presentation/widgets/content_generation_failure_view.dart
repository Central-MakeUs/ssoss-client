import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ssoss_flutter/common/widgets/app_bar/ssoss_app_bar.dart';
import 'package:ssoss_flutter/common/widgets/button/ssoss_button.dart';
import 'package:ssoss_flutter/common/widgets/text/app_text.dart';

import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/constants/assets.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';

/// 콘텐츠 생성 실패 화면 (Figma 1543:8009).
class ContentGenerationFailureView extends StatelessWidget {
  const ContentGenerationFailureView({
    required this.onBack,
    required this.onClose,
    required this.onRetry,
    super.key,
  });

  /// 앱바 뒤로가기 — 생성 입력 화면으로 복귀.
  final VoidCallback onBack;

  /// 앱바 닫기 — 홈으로 이동.
  final VoidCallback onClose;

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SsossAppBar.backWithLabel(
          title: '',
          label: '닫기',
          onBack: onBack,
          onDone: onClose,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const Spacer(flex: 2),
                Image.asset(
                  AppAssets.imgFail,
                  width: 135,
                  height: 135,
                ),
                const SizedBox(height: 16),
                AppText(
                  '콘텐츠 생성에 실패했어요',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.h3.copyWith(color: AppColors.black),
                ),
                const SizedBox(height: 8),
                AppText(
                  '콘텐츠를 생성하는 중 문제가 발생했어요\n잠시 후 다시 시도해 주세요',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.b4.copyWith(color: AppColors.neutral400),
                ),
                const Spacer(flex: 3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      AppAssets.icToastInfo,
                      width: 18,
                      height: 18,
                      colorFilter: const ColorFilter.mode(
                        AppColors.info700,
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(width: 10),
                    AppText(
                      '실패한 요청은 크레딧이 차감되지 않습니다',
                      style: AppTextStyles.b5.copyWith(
                        color: AppColors.info700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: SsossButton(
            label: '다시 시도하기',
            width: double.infinity,
            onPressed: onRetry,
          ),
        ),
      ],
    );
  }
}
