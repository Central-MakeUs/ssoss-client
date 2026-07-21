import 'package:flutter/material.dart';
import 'package:ssoss_flutter/common/widgets/text/app_text.dart';

import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';

enum SsossTextButtonType {
  selected,
  hover,
  normal,
}

class SsossTextButton extends StatelessWidget {
  const SsossTextButton({
    required this.title,
    super.key,
    this.subtitle,
    this.type = SsossTextButtonType.selected,
    this.onTap,
    this.enabled = true,
    this.icon,
    this.width,
    this.height,
    this.padding,
    this.borderRadius,
    this.backgroundColor,
    this.borderColor,
    this.titleColor,
    this.subtitleColor,
    this.disabledBackgroundColor,
    this.disabledBorderColor,
    this.disabledTitleColor,
    this.disabledSubtitleColor,
  });

  final String title;
  final String? subtitle;
  final SsossTextButtonType type;
  final VoidCallback? onTap;
  final bool enabled;
  final Widget? icon;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? titleColor;
  final Color? subtitleColor;
  final Color? disabledBackgroundColor;
  final Color? disabledBorderColor;
  final Color? disabledTitleColor;
  final Color? disabledSubtitleColor;

  bool get _isEnabled => enabled && onTap != null;
  bool get _hasSubtitle => subtitle != null && subtitle!.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final style = _TextButtonStyle.from(type);
    final resolvedBorderRadius = borderRadius ?? BorderRadius.circular(12);
    final resolvedBackgroundColor = _isEnabled
        ? backgroundColor ?? style.backgroundColor
        : disabledBackgroundColor ?? AppColors.neutral100;
    final resolvedBorderColor = _isEnabled
        ? borderColor ?? style.borderColor
        : disabledBorderColor ?? AppColors.neutral300;
    final resolvedTitleColor = _isEnabled
        ? titleColor ?? style.titleColor
        : disabledTitleColor ?? AppColors.neutral400;
    final resolvedSubtitleColor = _isEnabled
        ? subtitleColor ?? style.subtitleColor
        : disabledSubtitleColor ?? AppColors.neutral400;
    final resolvedPadding = padding ??
        EdgeInsets.symmetric(
          horizontal: 16,
          vertical: height == null ? 13 : 0,
        );

    return GestureDetector(
      onTap: _isEnabled ? onTap : null,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: width,
        height: height,
        padding: resolvedPadding,
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: resolvedBackgroundColor,
          borderRadius: resolvedBorderRadius,
          border: Border.all(color: resolvedBorderColor),
        ),
        child: Row(
          children: [
            if (icon != null) ...[
              IconTheme(
                data: IconThemeData(color: resolvedTitleColor, size: 24),
                child: icon!,
              ),
              const SizedBox(width: 8),
            ],
            AppText(
              title,
              style: AppTextStyles.h6.copyWith(
                color: resolvedTitleColor,
              ),
            ),
            if (_hasSubtitle) ...[
              const SizedBox(width: 8),
              AppText(
                subtitle!,
                style: AppTextStyles.b5.copyWith(
                  color: resolvedSubtitleColor,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _TextButtonStyle {
  const _TextButtonStyle({
    required this.backgroundColor,
    required this.borderColor,
    required this.titleColor,
    required this.subtitleColor,
  });

  final Color backgroundColor;
  final Color borderColor;
  final Color titleColor;
  final Color subtitleColor;

  static _TextButtonStyle from(SsossTextButtonType type) {
    switch (type) {
      case SsossTextButtonType.selected:
        return const _TextButtonStyle(
          backgroundColor: AppColors.primary50,
          borderColor: AppColors.primary300,
          titleColor: AppColors.primary500,
          subtitleColor: AppColors.neutral600,
        );
      case SsossTextButtonType.hover:
        return const _TextButtonStyle(
          backgroundColor: AppColors.neutral50,
          borderColor: AppColors.neutral400,
          titleColor: AppColors.neutral800,
          subtitleColor: AppColors.neutral500,
        );
      case SsossTextButtonType.normal:
        return const _TextButtonStyle(
          backgroundColor: AppColors.white,
          borderColor: AppColors.neutral200,
          titleColor: AppColors.neutral400,
          subtitleColor: AppColors.neutral400,
        );
    }
  }
}
