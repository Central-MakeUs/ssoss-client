import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:ssoss_flutter/common/widgets/text/app_text.dart';
import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/constants/assets.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';

/// Apple 브랜드 로그인 버튼. iOS 에서만 노출한다.
class AppleLoginButton extends StatelessWidget {
  const AppleLoginButton({
    required this.onPressed,
    super.key,
    this.enabled = true,
    this.isLoading = false,
  });

  final VoidCallback onPressed;
  final bool enabled;
  final bool isLoading;

  bool get _isInteractive => enabled && !isLoading;

  @override
  Widget build(BuildContext context) {
    if (!Platform.isIOS) {
      return const SizedBox.shrink();
    }

    return Semantics(
      button: true,
      label: 'Apple로 빠르게 시작하기',
      child: SizedBox(
        width: double.infinity,
        height: 54,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: _isInteractive ? onPressed : null,
            borderRadius: BorderRadius.circular(8),
            splashFactory: NoSplash.splashFactory,
            highlightColor: Colors.transparent,
            child: Ink(
              decoration: BoxDecoration(
                color: _isInteractive
                    ? Colors.black
                    : Colors.black.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.white,
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            AppAssets.brandApple,
                            width: 17,
                            height: 20,
                          ),
                          const SizedBox(width: 15),
                          AppText(
                            'Apple로 빠르게 시작하기',
                            style: AppTextStyles.h6.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
