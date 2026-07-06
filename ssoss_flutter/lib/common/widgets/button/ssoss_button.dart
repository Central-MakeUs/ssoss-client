import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/constants/assets.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';

enum SsossButtonSize {
  large,
  medium,
  small,
}

enum SsossButtonType {
  primary,
  secondary,
  outline,
  neutral,
  link,
  ghost,
}

class SsossButton extends StatelessWidget {
  const SsossButton({
    required this.label,
    super.key,
    this.size = SsossButtonSize.large,
    this.type = SsossButtonType.primary,
    this.onPressed,
    this.enabled = true,
    this.isIconOnly = false,
    this.showLeftIcon = false,
    this.showRightIcon = false,
    this.icon,
    this.iconAssetPath,
    this.width,
    this.height,
    this.padding,
    this.borderRadius,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.iconColor,
    this.disabledBackgroundColor,
    this.disabledForegroundColor,
    this.disabledBorderColor,
    this.textStyle,
    this.child,
  });

  final String label;
  final SsossButtonSize size;
  final SsossButtonType type;
  final VoidCallback? onPressed;
  final bool enabled;
  final bool isIconOnly;
  final bool showLeftIcon;
  final bool showRightIcon;
  final Widget? icon;
  final String? iconAssetPath;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;
  final Color? iconColor;
  final Color? disabledBackgroundColor;
  final Color? disabledForegroundColor;
  final Color? disabledBorderColor;
  final TextStyle? textStyle;
  final Widget? child;

  bool get _isEnabled => enabled && onPressed != null;

  @override
  Widget build(BuildContext context) {
    final style = _ButtonStyle.from(size, type, isIconOnly);
    final resolvedForegroundColor = _isEnabled
        ? foregroundColor ?? style.foregroundColor
        : disabledForegroundColor ?? AppColors.neutral400;
    final resolvedBackgroundColor = _isEnabled
        ? backgroundColor ?? style.backgroundColor
        : disabledBackgroundColor ?? AppColors.neutral100;
    final resolvedBorderColor = _isEnabled
        ? borderColor ?? style.borderColor
        : disabledBorderColor ?? style.disabledBorderColor;
    final resolvedBorderRadius = borderRadius ?? BorderRadius.circular(8);

    return Material(
      color: resolvedBackgroundColor,
      borderRadius: resolvedBorderRadius,
      child: InkWell(
        onTap: _isEnabled ? onPressed : null,
        customBorder: RoundedRectangleBorder(
          borderRadius: resolvedBorderRadius,
        ),
        child: Container(
          width: width ?? style.width,
          height: height ?? style.height,
          padding: padding ?? style.padding,
          decoration: BoxDecoration(
            borderRadius: resolvedBorderRadius,
            border: resolvedBorderColor == null
                ? null
                : Border.all(color: resolvedBorderColor),
          ),
          alignment: Alignment.center,
          child: isIconOnly
              ? _ButtonIcon(
                  icon: icon,
                  assetPath: iconAssetPath,
                  size: style.iconSize,
                  color: iconColor ?? resolvedForegroundColor,
                )
              : _ButtonContent(
                  label: label,
                  icon: icon,
                  iconAssetPath: iconAssetPath,
                  showLeftIcon: showLeftIcon,
                  showRightIcon: showRightIcon,
                  iconSize: style.iconSize,
                  gap: style.gap,
                  iconColor: iconColor ?? resolvedForegroundColor,
                  textStyle: (textStyle ?? style.textStyle).copyWith(
                    color: resolvedForegroundColor,
                    letterSpacing: style.letterSpacing,
                  ),
                  child: child,
                ),
        ),
      ),
    );
  }
}

class _ButtonContent extends StatelessWidget {
  const _ButtonContent({
    required this.label,
    required this.showLeftIcon,
    required this.showRightIcon,
    required this.iconSize,
    required this.gap,
    required this.iconColor,
    required this.textStyle,
    this.icon,
    this.iconAssetPath,
    this.child,
  });

  final String label;
  final Widget? icon;
  final String? iconAssetPath;
  final bool showLeftIcon;
  final bool showRightIcon;
  final double iconSize;
  final double gap;
  final Color iconColor;
  final TextStyle textStyle;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (showLeftIcon) ...[
          _ButtonIcon(
            icon: icon,
            assetPath: iconAssetPath,
            size: iconSize,
            color: iconColor,
          ),
          SizedBox(width: gap),
        ],
        Flexible(
          child: DefaultTextStyle(
            style: textStyle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            child: child ?? Text(label),
          ),
        ),
        if (showRightIcon) ...[
          SizedBox(width: gap),
          _ButtonIcon(
            icon: icon,
            assetPath: iconAssetPath,
            size: iconSize,
            color: iconColor,
          ),
        ],
      ],
    );
  }
}

class _ButtonIcon extends StatelessWidget {
  const _ButtonIcon({
    required this.size,
    required this.color,
    this.icon,
    this.assetPath,
  });

  final Widget? icon;
  final String? assetPath;
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    if (icon != null) {
      return IconTheme(
        data: IconThemeData(size: size, color: color),
        child: icon!,
      );
    }

    return SvgPicture.asset(
      assetPath ?? AppAssets.icSearch,
      width: size,
      height: size,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    );
  }
}

class _ButtonStyle {
  const _ButtonStyle({
    required this.width,
    required this.height,
    required this.padding,
    required this.gap,
    required this.iconSize,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.textStyle,
    required this.letterSpacing,
    this.borderColor,
    this.disabledBorderColor,
  });

  final double width;
  final double height;
  final EdgeInsetsGeometry padding;
  final double gap;
  final double iconSize;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color? borderColor;
  final Color? disabledBorderColor;
  final TextStyle textStyle;
  final double letterSpacing;

  static _ButtonStyle from(
    SsossButtonSize size,
    SsossButtonType type,
    bool isIconOnly,
  ) {
    return _ButtonStyle(
      width: isIconOnly ? _height(size) : _width(size),
      height: _height(size),
      padding: isIconOnly ? EdgeInsets.zero : _padding(size),
      gap: _gap(size),
      iconSize: _iconSize(size),
      backgroundColor: _backgroundColor(type),
      foregroundColor: _foregroundColor(type),
      borderColor: _borderColor(type),
      disabledBorderColor: _disabledBorderColor(type),
      textStyle: _textStyle(size),
      letterSpacing: _letterSpacing(size),
    );
  }

  static double _width(SsossButtonSize size) {
    switch (size) {
      case SsossButtonSize.large:
        return 328;
      case SsossButtonSize.medium:
        return 164;
      case SsossButtonSize.small:
        return 111;
    }
  }

  static double _height(SsossButtonSize size) {
    switch (size) {
      case SsossButtonSize.large:
        return 56;
      case SsossButtonSize.medium:
        return 48;
      case SsossButtonSize.small:
        return 40;
    }
  }

  static EdgeInsetsGeometry _padding(SsossButtonSize size) {
    switch (size) {
      case SsossButtonSize.large:
        return const EdgeInsets.symmetric(horizontal: 20, vertical: 15);
      case SsossButtonSize.medium:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 10);
      case SsossButtonSize.small:
        return const EdgeInsets.symmetric(horizontal: 12, vertical: 10);
    }
  }

  static double _gap(SsossButtonSize size) {
    switch (size) {
      case SsossButtonSize.large:
        return 8;
      case SsossButtonSize.medium:
        return 6;
      case SsossButtonSize.small:
        return 4;
    }
  }

  static double _iconSize(SsossButtonSize size) {
    switch (size) {
      case SsossButtonSize.large:
        return 22;
      case SsossButtonSize.medium:
        return 20;
      case SsossButtonSize.small:
        return 18;
    }
  }

  static TextStyle _textStyle(SsossButtonSize size) {
    switch (size) {
      case SsossButtonSize.large:
        return AppTextStyles.h5;
      case SsossButtonSize.medium:
        return AppTextStyles.h6;
      case SsossButtonSize.small:
        return AppTextStyles.h8;
    }
  }

  static double _letterSpacing(SsossButtonSize size) {
    switch (size) {
      case SsossButtonSize.large:
        return -0.18;
      case SsossButtonSize.medium:
        return -0.16;
      case SsossButtonSize.small:
        return -0.14;
    }
  }

  static Color _backgroundColor(SsossButtonType type) {
    switch (type) {
      case SsossButtonType.primary:
        return AppColors.primary400;
      case SsossButtonType.secondary:
        return AppColors.secondary50;
      case SsossButtonType.outline:
        return AppColors.white;
      case SsossButtonType.neutral:
        return AppColors.neutral100;
      case SsossButtonType.link:
      case SsossButtonType.ghost:
        return Colors.transparent;
    }
  }

  static Color _foregroundColor(SsossButtonType type) {
    switch (type) {
      case SsossButtonType.primary:
        return AppColors.white;
      case SsossButtonType.secondary:
        return AppColors.secondary800;
      case SsossButtonType.outline:
      case SsossButtonType.neutral:
        return AppColors.neutral700;
      case SsossButtonType.link:
        return AppColors.primary600;
      case SsossButtonType.ghost:
        return AppColors.neutral500;
    }
  }

  static Color? _borderColor(SsossButtonType type) {
    switch (type) {
      case SsossButtonType.secondary:
        return AppColors.secondary300;
      case SsossButtonType.outline:
        return AppColors.neutral300;
      case SsossButtonType.primary:
      case SsossButtonType.neutral:
      case SsossButtonType.link:
      case SsossButtonType.ghost:
        return null;
    }
  }

  static Color? _disabledBorderColor(SsossButtonType type) {
    switch (type) {
      case SsossButtonType.secondary:
      case SsossButtonType.outline:
        return AppColors.neutral200;
      case SsossButtonType.primary:
      case SsossButtonType.neutral:
      case SsossButtonType.link:
      case SsossButtonType.ghost:
        return null;
    }
  }
}
