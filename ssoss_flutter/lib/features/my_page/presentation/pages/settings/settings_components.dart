import 'package:flutter/material.dart';

import 'package:ssoss_flutter/common/widgets/text/app_text.dart';
import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';

class SettingsMenuGroup extends StatelessWidget {
  const SettingsMenuGroup({
    required this.children,
    super.key,
  });

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }
}

class SettingsMenuItem extends StatelessWidget {
  const SettingsMenuItem({
    required this.label,
    this.onTap,
    super.key,
  });

  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        height: 56,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14.5),
          child: Align(
            alignment: Alignment.centerLeft,
            child: AppText(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.h5.copyWith(
                color: AppColors.neutral500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SettingsWithdrawButton extends StatelessWidget {
  const SettingsWithdrawButton({
    required this.onTap,
    super.key,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppText(
              '탈퇴 하기',
              style: AppTextStyles.h6.copyWith(
                color: AppColors.primary600,
              ),
            ),
            const SizedBox(width: 6),
            const Icon(
              Icons.logout_rounded,
              size: 20,
              color: AppColors.primary600,
            ),
          ],
        ),
      ),
    );
  }
}
