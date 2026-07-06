import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/constants/assets.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';

enum SsossSquareSelectionButtonType {
  normal,
  primarySelected,
  secondarySelected,
}

class SsossSquareSelectionButton extends StatelessWidget {
  const SsossSquareSelectionButton({
    required this.label,
    super.key,
    this.type = SsossSquareSelectionButtonType.normal,
    this.enabled = true,
    this.onTap,
    this.showIcon = true,
    this.icon,
    this.iconAsset = AppAssets.icArrowLeft,
    this.width = 108,
    this.height = 99,
    this.backgroundColor,
    this.borderColor,
    this.foregroundColor,
    this.disabledBackgroundColor,
    this.disabledBorderColor,
    this.disabledForegroundColor,
    this.borderRadius,
    this.padding,
    this.gap = 6,
    this.textStyle,
  });

  final String label;
  final SsossSquareSelectionButtonType type;
  final bool enabled;
  final VoidCallback? onTap;
  final bool showIcon;
  final Widget? icon;
  final String iconAsset;
  final double width;
  final double height;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? foregroundColor;
  final Color? disabledBackgroundColor;
  final Color? disabledBorderColor;
  final Color? disabledForegroundColor;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? padding;
  final double gap;
  final TextStyle? textStyle;

  bool get _isInteractive => enabled && onTap != null;

  @override
  Widget build(BuildContext context) {
    final style = _SquareSelectionButtonStyle.from(type);
    final resolvedBorderRadius = borderRadius ?? BorderRadius.circular(12);
    final resolvedBackgroundColor = enabled
        ? backgroundColor ?? style.backgroundColor
        : disabledBackgroundColor ?? AppColors.neutral50;
    final resolvedBorderColor = enabled
        ? borderColor ?? style.borderColor
        : disabledBorderColor ?? AppColors.neutral400;
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
          width: width,
          height: height,
          padding: padding ??
              const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 7,
              ),
          decoration: BoxDecoration(
            borderRadius: resolvedBorderRadius,
            border: Border.all(color: resolvedBorderColor),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (showIcon) ...[
                SizedBox.square(
                  dimension: 40,
                  child: Center(
                    child: icon ??
                        SvgPicture.asset(
                          iconAsset,
                          width: 27,
                          height: 16,
                          colorFilter: ColorFilter.mode(
                            resolvedForegroundColor,
                            BlendMode.srcIn,
                          ),
                        ),
                  ),
                ),
                SizedBox(height: gap),
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

class _SquareSelectionButtonStyle {
  const _SquareSelectionButtonStyle({
    required this.backgroundColor,
    required this.borderColor,
    required this.foregroundColor,
  });

  final Color backgroundColor;
  final Color borderColor;
  final Color foregroundColor;

  static _SquareSelectionButtonStyle from(SsossSquareSelectionButtonType type) {
    switch (type) {
      case SsossSquareSelectionButtonType.normal:
        return const _SquareSelectionButtonStyle(
          backgroundColor: AppColors.white,
          borderColor: AppColors.neutral300,
          foregroundColor: AppColors.neutral500,
        );
      case SsossSquareSelectionButtonType.primarySelected:
        return const _SquareSelectionButtonStyle(
          backgroundColor: AppColors.primary50,
          borderColor: AppColors.primary700,
          foregroundColor: AppColors.primary900,
        );
      case SsossSquareSelectionButtonType.secondarySelected:
        return const _SquareSelectionButtonStyle(
          backgroundColor: AppColors.secondary50,
          borderColor: AppColors.secondary500,
          foregroundColor: AppColors.secondary900,
        );
    }
  }
}
