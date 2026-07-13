import 'package:flutter/material.dart';
import 'package:ssoss_flutter/common/widgets/text/app_text.dart';

import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';

enum SsossFilterChipState {
  normal,
  hover,
  selected,
}

class SsossFilterChip extends StatelessWidget {
  const SsossFilterChip({
    required this.label,
    super.key,
    this.state = SsossFilterChipState.normal,
    this.enabled = true,
    this.onTap,
    this.backgroundColor,
    this.foregroundColor,
    this.disabledBackgroundColor,
    this.disabledForegroundColor,
    this.padding,
    this.borderRadius,
    this.height = 36,
    this.gap = 4,
    this.icon,
    this.textStyle,
  });

  final String label;
  final SsossFilterChipState state;
  final bool enabled;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? disabledBackgroundColor;
  final Color? disabledForegroundColor;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;
  final double height;
  final double gap;
  final Widget? icon;
  final TextStyle? textStyle;

  bool get _isInteractive => enabled && onTap != null;

  @override
  Widget build(BuildContext context) {
    final style = _FilterChipStyle.from(state);
    final resolvedBorderRadius = borderRadius ?? BorderRadius.circular(8);
    final resolvedBackgroundColor = enabled
        ? backgroundColor ?? style.backgroundColor
        : disabledBackgroundColor ?? AppColors.neutral100;
    final resolvedForegroundColor = enabled
        ? foregroundColor ?? style.foregroundColor
        : disabledForegroundColor ?? AppColors.neutral400;

    return Material(
      color: resolvedBackgroundColor,
      borderRadius: resolvedBorderRadius,
      child: InkWell(
        onTap: _isInteractive ? onTap : null,
        customBorder: RoundedRectangleBorder(
          borderRadius: resolvedBorderRadius,
        ),
        child: Container(
          height: height,
          padding: padding ??
              const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                IconTheme(
                  data: IconThemeData(
                    color: resolvedForegroundColor,
                    size: 16,
                  ),
                  child: icon!,
                ),
                SizedBox(width: gap),
              ],
              AppText(
                label,
                textAlign: TextAlign.center,
                style: (textStyle ?? AppTextStyles.h8).copyWith(
                  color: resolvedForegroundColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FilterChipStyle {
  const _FilterChipStyle({
    required this.backgroundColor,
    required this.foregroundColor,
  });

  final Color backgroundColor;
  final Color foregroundColor;

  static _FilterChipStyle from(SsossFilterChipState state) {
    switch (state) {
      case SsossFilterChipState.normal:
        return const _FilterChipStyle(
          backgroundColor: AppColors.white,
          foregroundColor: AppColors.neutral700,
        );
      case SsossFilterChipState.hover:
        return const _FilterChipStyle(
          backgroundColor: AppColors.neutral200,
          foregroundColor: AppColors.neutral700,
        );
      case SsossFilterChipState.selected:
        return const _FilterChipStyle(
          backgroundColor: AppColors.black,
          foregroundColor: AppColors.white,
        );
    }
  }
}
