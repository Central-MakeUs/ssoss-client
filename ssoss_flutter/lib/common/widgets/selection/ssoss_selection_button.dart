import 'package:flutter/material.dart';
import 'package:ssoss_flutter/common/widgets/text/app_text.dart';

import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';

enum SsossSelectionButtonType {
  normal,
  disabled,
  hover,
  primarySelected,
}

class SsossSelectionButton extends StatelessWidget {
  const SsossSelectionButton({
    required this.label,
    super.key,
    this.type = SsossSelectionButtonType.normal,
    this.enabled = true,
    this.onTap,
    this.icon,
    this.backgroundColor,
    this.borderColor,
    this.foregroundColor,
    this.disabledBackgroundColor,
    this.disabledBorderColor,
    this.disabledForegroundColor,
    this.padding,
    this.borderRadius,
    this.gap = 6,
    this.textStyle,
  });

  final String label;
  final SsossSelectionButtonType type;
  final bool enabled;
  final VoidCallback? onTap;
  final Widget? icon;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? foregroundColor;
  final Color? disabledBackgroundColor;
  final Color? disabledBorderColor;
  final Color? disabledForegroundColor;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;
  final double gap;
  final TextStyle? textStyle;

  bool get _isEnabled => enabled && onTap != null;

  @override
  Widget build(BuildContext context) {
    final style = _SelectionButtonStyle.from(type);
    final resolvedBorderRadius = borderRadius ?? BorderRadius.circular(9999);
    final resolvedBackgroundColor = _isEnabled
        ? backgroundColor ?? style.backgroundColor
        : disabledBackgroundColor ?? AppColors.neutral50;
    final resolvedBorderColor = _isEnabled
        ? borderColor ?? style.borderColor
        : disabledBorderColor ?? AppColors.neutral300;
    final resolvedForegroundColor = _isEnabled
        ? foregroundColor ?? style.foregroundColor
        : disabledForegroundColor ?? AppColors.neutral400;

    return GestureDetector(
      onTap: _isEnabled ? onTap : null,
      behavior: HitTestBehavior.opaque,
      child: Container(
          height: 36,
          padding: padding ??
              const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 7,
              ),
          decoration: BoxDecoration(
            color: resolvedBackgroundColor,
            borderRadius: resolvedBorderRadius,
            border: Border.all(color: resolvedBorderColor),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                IconTheme(
                  data: IconThemeData(
                    color: resolvedForegroundColor,
                    size: 20,
                  ),
                  child: icon!,
                ),
                SizedBox(width: gap),
              ],
              AppText(
                label,
                style: (textStyle ?? AppTextStyles.h8).copyWith(
                  color: resolvedForegroundColor,
                ),
              ),
            ],
          ),
        ),
    );
  }
}

class _SelectionButtonStyle {
  const _SelectionButtonStyle({
    required this.backgroundColor,
    required this.borderColor,
    required this.foregroundColor,
  });

  final Color backgroundColor;
  final Color borderColor;
  final Color foregroundColor;

  static _SelectionButtonStyle from(SsossSelectionButtonType type) {
    switch (type) {
      case SsossSelectionButtonType.normal:
        return const _SelectionButtonStyle(
          backgroundColor: AppColors.white,
          borderColor: AppColors.neutral300,
          foregroundColor: AppColors.neutral500,
        );
      case SsossSelectionButtonType.disabled:
        return const _SelectionButtonStyle(
          backgroundColor: AppColors.neutral50,
          borderColor: AppColors.neutral300,
          foregroundColor: AppColors.neutral400,
        );
      case SsossSelectionButtonType.hover:
        return const _SelectionButtonStyle(
          backgroundColor: AppColors.neutral50,
          borderColor: AppColors.neutral400,
          foregroundColor: AppColors.neutral800,
        );
      case SsossSelectionButtonType.primarySelected:
        return const _SelectionButtonStyle(
          backgroundColor: AppColors.primary50,
          borderColor: AppColors.primary300,
          foregroundColor: AppColors.primary500,
        );
    }
  }
}
