import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/constants/assets.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';

enum SsossTagType {
  primary,
  secondary,
  success,
  info,
  warning,
  error,
  gray,
}

class SsossTag extends StatelessWidget {
  const SsossTag({
    required this.label,
    super.key,
    this.type = SsossTagType.primary,
    this.isIconOnly = false,
    this.showLeftIcon = true,
    this.showRightIcon = true,
    this.icon,
    this.iconAsset = AppAssets.icToastInfo,
    this.backgroundColor,
    this.foregroundColor,
    this.padding,
    this.borderRadius,
    this.gap = 4,
    this.iconSize = 12,
    this.textStyle,
  });

  final String label;
  final SsossTagType type;
  final bool isIconOnly;
  final bool showLeftIcon;
  final bool showRightIcon;
  final Widget? icon;
  final String iconAsset;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;
  final double gap;
  final double iconSize;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final style = _TagStyle.from(type);
    final resolvedForegroundColor = foregroundColor ?? style.foregroundColor;

    return Container(
      padding: padding ??
          (isIconOnly
              ? const EdgeInsets.all(4)
              : const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                )),
      decoration: BoxDecoration(
        color: backgroundColor ?? style.backgroundColor,
        borderRadius: borderRadius ?? BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isIconOnly || showLeftIcon) _buildIcon(resolvedForegroundColor),
          if (!isIconOnly) ...[
            if (showLeftIcon) SizedBox(width: gap),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: (textStyle ?? AppTextStyles.b5).copyWith(
                color: resolvedForegroundColor,
                letterSpacing: -0.14,
              ),
            ),
            if (showRightIcon) ...[
              SizedBox(width: gap),
              _buildIcon(resolvedForegroundColor),
            ],
          ],
        ],
      ),
    );
  }

  Widget _buildIcon(Color color) {
    return SizedBox.square(
      dimension: iconSize,
      child: Center(
        child: icon ??
            SvgPicture.asset(
              iconAsset,
              width: iconSize,
              height: iconSize,
              colorFilter: ColorFilter.mode(
                color,
                BlendMode.srcIn,
              ),
            ),
      ),
    );
  }
}

class _TagStyle {
  const _TagStyle({
    required this.backgroundColor,
    required this.foregroundColor,
  });

  final Color backgroundColor;
  final Color foregroundColor;

  static _TagStyle from(SsossTagType type) {
    switch (type) {
      case SsossTagType.primary:
        return const _TagStyle(
          backgroundColor: AppColors.primary50,
          foregroundColor: AppColors.primary600,
        );
      case SsossTagType.secondary:
        return const _TagStyle(
          backgroundColor: AppColors.secondary50,
          foregroundColor: AppColors.secondary600,
        );
      case SsossTagType.success:
        return const _TagStyle(
          backgroundColor: AppColors.success50,
          foregroundColor: AppColors.success700,
        );
      case SsossTagType.info:
        return const _TagStyle(
          backgroundColor: AppColors.info50,
          foregroundColor: AppColors.info700,
        );
      case SsossTagType.warning:
        return const _TagStyle(
          backgroundColor: AppColors.warning50,
          foregroundColor: AppColors.warning700,
        );
      case SsossTagType.error:
        return const _TagStyle(
          backgroundColor: AppColors.error50,
          foregroundColor: AppColors.error700,
        );
      case SsossTagType.gray:
        return const _TagStyle(
          backgroundColor: AppColors.neutral100,
          foregroundColor: AppColors.neutral500,
        );
    }
  }
}
