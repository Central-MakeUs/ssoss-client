import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/constants/assets.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';

enum SsossToastType {
  success,
  info,
  warning,
  error,
}

class SsossToast extends StatelessWidget {
  const SsossToast({
    required this.title,
    super.key,
    this.type = SsossToastType.success,
    this.caption,
    this.width = 320,
    this.showIcon = true,
    this.icon,
    this.backgroundColor,
    this.borderColor,
    this.titleColor,
    this.captionColor,
    this.padding,
    this.borderRadius,
    this.gap = 9,
    this.contentGap = 4,
    this.titleStyle,
    this.captionStyle,
  });

  final String title;
  final SsossToastType type;
  final String? caption;
  final double? width;
  final bool showIcon;
  final Widget? icon;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? titleColor;
  final Color? captionColor;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;
  final double gap;
  final double contentGap;
  final TextStyle? titleStyle;
  final TextStyle? captionStyle;

  bool get _hasCaption => caption != null && caption!.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final style = _ToastStyle.from(type);
    final resolvedBorderRadius = borderRadius ?? BorderRadius.circular(8);
    final resolvedTitleColor = titleColor ?? style.titleColor;
    final resolvedCaptionColor = captionColor ?? AppColors.neutral500;

    return Container(
      width: width,
      padding: padding ?? const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: backgroundColor ?? style.backgroundColor,
        borderRadius: resolvedBorderRadius,
        border: Border.all(color: borderColor ?? style.borderColor),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showIcon) ...[
            SizedBox.square(
              dimension: 20,
              child: Center(
                child: icon ??
                    SvgPicture.asset(
                      style.iconAsset,
                      width: 20,
                      height: 20,
                    ),
              ),
            ),
            SizedBox(width: gap),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: (titleStyle ?? AppTextStyles.h8).copyWith(
                    color: resolvedTitleColor,
                    letterSpacing: -0.14,
                  ),
                ),
                if (_hasCaption) ...[
                  SizedBox(height: contentGap),
                  Text(
                    caption!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: (captionStyle ?? AppTextStyles.b6).copyWith(
                      color: resolvedCaptionColor,
                      letterSpacing: -0.12,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ToastStyle {
  const _ToastStyle({
    required this.iconAsset,
    required this.backgroundColor,
    required this.borderColor,
    required this.titleColor,
  });

  final String iconAsset;
  final Color backgroundColor;
  final Color borderColor;
  final Color titleColor;

  static _ToastStyle from(SsossToastType type) {
    switch (type) {
      case SsossToastType.success:
        return const _ToastStyle(
          iconAsset: AppAssets.icToastSuccess,
          backgroundColor: AppColors.success50,
          borderColor: AppColors.success500,
          titleColor: AppColors.success700,
        );
      case SsossToastType.info:
        return const _ToastStyle(
          iconAsset: AppAssets.icToastInfo,
          backgroundColor: AppColors.info50,
          borderColor: AppColors.info500,
          titleColor: AppColors.info700,
        );
      case SsossToastType.warning:
        return const _ToastStyle(
          iconAsset: AppAssets.icToastWarning,
          backgroundColor: AppColors.warning50,
          borderColor: AppColors.warning500,
          titleColor: AppColors.warning700,
        );
      case SsossToastType.error:
        return const _ToastStyle(
          iconAsset: AppAssets.icToastError,
          backgroundColor: AppColors.error50,
          borderColor: AppColors.error500,
          titleColor: AppColors.error700,
        );
    }
  }
}
