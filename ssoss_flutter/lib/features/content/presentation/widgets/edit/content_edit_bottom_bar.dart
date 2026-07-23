import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ssoss_flutter/common/widgets/button/ssoss_button.dart';
import 'package:ssoss_flutter/common/widgets/text/app_text.dart';

import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/constants/assets.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';

/// 콘텐츠 편집 하단바 — 초기화 + 수정하기.
class ContentEditBottomBar extends StatelessWidget {
  const ContentEditBottomBar({
    required this.canSubmit,
    required this.onReset,
    required this.onSubmit,
    super.key,
  });

  final bool canSubmit;
  final VoidCallback onReset;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(
          top: BorderSide(color: AppColors.neutral200),
        ),
      ),
      child: Row(
        children: [
          _ResetButton(onPressed: onReset),
          const SizedBox(width: 12),
          Expanded(
            child: SsossButton(
              label: '수정하기',
              width: double.infinity,
              enabled: canSubmit,
              onPressed: canSubmit ? onSubmit : null,
            ),
          ),
        ],
      ),
    );
  }
}

class _ResetButton extends StatelessWidget {
  const _ResetButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 60,
        height: 56,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.neutral200),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AppAssets.icRefresh,
              width: 22,
              height: 22,
              colorFilter: const ColorFilter.mode(
                AppColors.neutral600,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(height: 2),
            AppText(
              '초기화',
              style: AppTextStyles.h9.copyWith(color: AppColors.neutral600),
            ),
          ],
        ),
      ),
    );
  }
}
