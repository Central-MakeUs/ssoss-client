import 'package:flutter/material.dart';

import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';

enum SsossSelectionButtonType {
  normal,
  primarySelected,
  secondarySelected,
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

    return Material(
      color: resolvedBackgroundColor,
      borderRadius: resolvedBorderRadius,
      child: InkWell(
        onTap: _isEnabled ? onTap : null,
        customBorder: RoundedRectangleBorder(
          borderRadius: resolvedBorderRadius,
        ),
        child: Container(
          height: 36,
          padding: padding ??
              const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 7,
              ),
          decoration: BoxDecoration(
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
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: (textStyle ?? AppTextStyles.h8).copyWith(
                  color: resolvedForegroundColor,
                  letterSpacing: -0.14,
                ),
              ),
            ],
          ),
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
      case SsossSelectionButtonType.primarySelected:
        return const _SelectionButtonStyle(
          backgroundColor: AppColors.primary50,
          borderColor: AppColors.primary700,
          foregroundColor: AppColors.primary900,
        );
      case SsossSelectionButtonType.secondarySelected:
        return const _SelectionButtonStyle(
          backgroundColor: AppColors.secondary50,
          borderColor: AppColors.secondary500,
          foregroundColor: AppColors.secondary900,
        );
    }
  }
}
