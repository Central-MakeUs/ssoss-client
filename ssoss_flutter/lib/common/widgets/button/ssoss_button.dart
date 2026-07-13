import 'package:flutter/material.dart';
import 'package:ssoss_flutter/common/widgets/text/app_text.dart';
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

class SsossButton extends StatefulWidget {
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

  @override
  State<SsossButton> createState() => _SsossButtonState();
}

class _SsossButtonState extends State<SsossButton> {
  bool _isPressed = false;

  bool get _isEnabled => widget.enabled && widget.onPressed != null;

  bool get _usePressedStyle =>
      _isPressed &&
      _isEnabled &&
      widget.backgroundColor == null &&
      widget.foregroundColor == null &&
      widget.borderColor == null;

  void _setPressed(bool value) {
    if (_isPressed != value) {
      setState(() => _isPressed = value);
    }
  }

  @override
  Widget build(BuildContext context) {
    final style = _ButtonStyle.from(
      widget.size,
      widget.type,
      widget.isIconOnly,
    );
    final resolvedForegroundColor = !_isEnabled
        ? widget.disabledForegroundColor ??
            style.disabledForegroundColor ??
            AppColors.neutral400
        : _usePressedStyle
            ? style.pressedForegroundColor ?? style.foregroundColor
            : widget.foregroundColor ?? style.foregroundColor;
    final resolvedBackgroundColor = !_isEnabled
        ? widget.disabledBackgroundColor ??
            style.disabledBackgroundColor ??
            AppColors.neutral100
        : _usePressedStyle
            ? style.pressedBackgroundColor ?? style.backgroundColor
            : widget.backgroundColor ?? style.backgroundColor;
    final resolvedBorderColor = !_isEnabled
        ? widget.disabledBorderColor ?? style.disabledBorderColor
        : _usePressedStyle
            ? style.pressedBorderColor ?? style.borderColor
            : widget.borderColor ?? style.borderColor;
    final resolvedBorderRadius =
        widget.borderRadius ?? BorderRadius.circular(8);

    return Listener(
      onPointerDown: _isEnabled ? (_) => _setPressed(true) : null,
      onPointerUp: (_) => _setPressed(false),
      onPointerCancel: (_) => _setPressed(false),
      child: Material(
        color: resolvedBackgroundColor,
        borderRadius: resolvedBorderRadius,
        child: InkWell(
          onTap: _isEnabled ? widget.onPressed : null,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          customBorder: RoundedRectangleBorder(
            borderRadius: resolvedBorderRadius,
          ),
          child: Container(
            width: widget.width ??
                (widget.isIconOnly ? widget.height ?? style.height : null),
            height: widget.height ?? style.height,
            padding: widget.padding ?? style.padding,
            decoration: BoxDecoration(
              borderRadius: resolvedBorderRadius,
              border: resolvedBorderColor == null
                  ? null
                  : Border.all(color: resolvedBorderColor),
            ),
            alignment: Alignment.center,
            child: widget.isIconOnly
                ? _ButtonIcon(
                    icon: widget.icon,
                    assetPath: widget.iconAssetPath,
                    size: style.iconSize,
                    color: widget.iconColor ?? resolvedForegroundColor,
                  )
                : _ButtonContent(
                    label: widget.label,
                    icon: widget.icon,
                    iconAssetPath: widget.iconAssetPath,
                    showLeftIcon: widget.showLeftIcon,
                    showRightIcon: widget.showRightIcon,
                    iconSize: style.iconSize,
                    gap: style.gap,
                    iconColor: widget.iconColor ?? resolvedForegroundColor,
                    textStyle: (widget.textStyle ?? style.textStyle).copyWith(
                      color: resolvedForegroundColor,
                    ),
                    child: widget.child,
                  ),
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
            textAlign: TextAlign.center,
            child: child ?? AppText(label),
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
    required this.height,
    required this.padding,
    required this.gap,
    required this.iconSize,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.textStyle,
    this.borderColor,
    this.pressedBackgroundColor,
    this.pressedForegroundColor,
    this.pressedBorderColor,
    this.disabledBackgroundColor,
    this.disabledForegroundColor,
    this.disabledBorderColor,
  });

  final double height;
  final EdgeInsetsGeometry padding;
  final double gap;
  final double iconSize;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color? borderColor;
  final Color? pressedBackgroundColor;
  final Color? pressedForegroundColor;
  final Color? pressedBorderColor;
  final Color? disabledBackgroundColor;
  final Color? disabledForegroundColor;
  final Color? disabledBorderColor;
  final TextStyle textStyle;

  static _ButtonStyle from(
    SsossButtonSize size,
    SsossButtonType type,
    bool isIconOnly,
  ) {
    return _ButtonStyle(
      height: _height(size),
      padding: isIconOnly ? EdgeInsets.zero : _padding(size),
      gap: _gap(size),
      iconSize: _iconSize(size),
      backgroundColor: _backgroundColor(type),
      foregroundColor: _foregroundColor(type),
      borderColor: _borderColor(type),
      pressedBackgroundColor: _pressedBackgroundColor(type),
      pressedForegroundColor: _pressedForegroundColor(type),
      pressedBorderColor: _pressedBorderColor(type),
      disabledBackgroundColor: _disabledBackgroundColor(type),
      disabledForegroundColor: _disabledForegroundColor(type),
      disabledBorderColor: _disabledBorderColor(type),
      textStyle: _textStyle(size),
    );
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

  static Color _backgroundColor(SsossButtonType type) {
    switch (type) {
      case SsossButtonType.primary:
        return AppColors.primary400;
      case SsossButtonType.secondary:
        return AppColors.primary50;
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
        return AppColors.primary500;
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
        return AppColors.primary300;
      case SsossButtonType.outline:
        return AppColors.neutral200;
      case SsossButtonType.primary:
      case SsossButtonType.neutral:
      case SsossButtonType.link:
      case SsossButtonType.ghost:
        return null;
    }
  }

  static Color? _pressedBackgroundColor(SsossButtonType type) {
    switch (type) {
      case SsossButtonType.primary:
        return AppColors.primary500;
      case SsossButtonType.secondary:
        return AppColors.primary100;
      case SsossButtonType.outline:
        return AppColors.neutral100;
      case SsossButtonType.neutral:
        return AppColors.neutral300;
      case SsossButtonType.link:
      case SsossButtonType.ghost:
        return Colors.transparent;
    }
  }

  static Color? _pressedForegroundColor(SsossButtonType type) {
    switch (type) {
      case SsossButtonType.primary:
        return AppColors.white;
      case SsossButtonType.secondary:
        return AppColors.primary700;
      case SsossButtonType.outline:
        return AppColors.neutral800;
      case SsossButtonType.neutral:
        return AppColors.neutral700;
      case SsossButtonType.link:
        return AppColors.primary400;
      case SsossButtonType.ghost:
        return AppColors.neutral700;
    }
  }

  static Color? _pressedBorderColor(SsossButtonType type) {
    switch (type) {
      case SsossButtonType.secondary:
        return AppColors.primary500;
      case SsossButtonType.outline:
        return AppColors.neutral400;
      case SsossButtonType.primary:
      case SsossButtonType.neutral:
      case SsossButtonType.link:
      case SsossButtonType.ghost:
        return null;
    }
  }

  static Color? _disabledBackgroundColor(SsossButtonType type) {
    switch (type) {
      case SsossButtonType.primary:
        return AppColors.primary200;
      case SsossButtonType.secondary:
        return AppColors.primary50;
      case SsossButtonType.outline:
        return AppColors.white;
      case SsossButtonType.neutral:
        return AppColors.neutral50;
      case SsossButtonType.link:
      case SsossButtonType.ghost:
        return Colors.transparent;
    }
  }

  static Color? _disabledForegroundColor(SsossButtonType type) {
    switch (type) {
      case SsossButtonType.primary:
        return AppColors.primary50;
      case SsossButtonType.secondary:
        return AppColors.primary200;
      case SsossButtonType.outline:
        return AppColors.neutral300;
      case SsossButtonType.neutral:
        return AppColors.neutral400;
      case SsossButtonType.link:
        return AppColors.primary200;
      case SsossButtonType.ghost:
        return AppColors.neutral300;
    }
  }

  static Color? _disabledBorderColor(SsossButtonType type) {
    switch (type) {
      case SsossButtonType.secondary:
        return AppColors.primary100;
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
