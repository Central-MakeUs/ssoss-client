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

const _buttonTextHeightBehavior = TextHeightBehavior(
  applyHeightToFirstAscent: false,
  applyHeightToLastDescent: false,
);

class SsossButton extends StatefulWidget {
  const SsossButton({
    required this.label,
    super.key,
    this.size = SsossButtonSize.large,
    this.type = SsossButtonType.primary,
    this.onPressed,
    this.enabled = true,
    this.isLoading = false,
    this.loadingIndicatorColor,
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
  final bool isLoading;
  final Color? loadingIndicatorColor;
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

  /// `enabled`만으로 시각적 활성 상태를 결정한다. `onPressed`가 없어도 기본 스타일을 유지한다.
  bool get _isVisuallyEnabled => widget.enabled;

  /// 탭·프레스 피드백은 콜백이 있을 때만 동작한다.
  bool get _isInteractive =>
      widget.enabled && !widget.isLoading && widget.onPressed != null;

  bool get _usePressedStyle =>
      _isPressed &&
      _isInteractive &&
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
    final resolvedForegroundColor = !_isVisuallyEnabled
        ? widget.disabledForegroundColor ??
            style.disabledForegroundColor ??
            AppColors.neutral400
        : _usePressedStyle
            ? style.pressedForegroundColor ?? style.foregroundColor
            : widget.foregroundColor ?? style.foregroundColor;
    final resolvedBackgroundColor = !_isVisuallyEnabled
        ? widget.disabledBackgroundColor ??
            style.disabledBackgroundColor ??
            AppColors.neutral100
        : _usePressedStyle
            ? style.pressedBackgroundColor ?? style.backgroundColor
            : widget.backgroundColor ?? style.backgroundColor;
    final resolvedBorderColor = !_isVisuallyEnabled
        ? widget.disabledBorderColor ?? style.disabledBorderColor
        : _usePressedStyle
            ? style.pressedBorderColor ?? style.borderColor
            : widget.borderColor ?? style.borderColor;
    final resolvedBorderRadius =
        widget.borderRadius ?? BorderRadius.circular(8);
    final resolvedHeight = widget.height ?? style.height;
    final resolvedPadding = widget.padding ?? style.padding;
    final resolvedWidth = widget.width;

    final button = Listener(
      onPointerDown: _isInteractive ? (_) => _setPressed(true) : null,
      onPointerUp: (_) => _setPressed(false),
      onPointerCancel: (_) => _setPressed(false),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _isInteractive ? widget.onPressed : null,
          splashFactory: NoSplash.splashFactory,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          overlayColor: const WidgetStatePropertyAll(Colors.transparent),
          customBorder: RoundedRectangleBorder(
            borderRadius: resolvedBorderRadius,
          ),
          child: Ink(
            width: resolvedWidth == double.infinity
                ? double.infinity
                : (widget.isIconOnly ? resolvedHeight : resolvedWidth),
            height: widget.isIconOnly ? resolvedHeight : null,
            decoration: BoxDecoration(
              color: resolvedBackgroundColor,
              borderRadius: resolvedBorderRadius,
              border: resolvedBorderColor == null
                  ? null
                  : Border.all(color: resolvedBorderColor),
            ),
            child: SizedBox(
              height: widget.isIconOnly ? null : resolvedHeight,
              child: Padding(
                padding: widget.isIconOnly ? EdgeInsets.zero : resolvedPadding,
                child: Center(
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
                          isLoading: widget.isLoading,
                          showLeftIcon:
                              widget.isLoading ? false : widget.showLeftIcon,
                          showRightIcon: widget.showRightIcon,
                          iconSize: style.iconSize,
                          gap: style.gap,
                          iconColor:
                              widget.iconColor ?? resolvedForegroundColor,
                          loadingIndicatorColor: widget.loadingIndicatorColor ??
                              resolvedForegroundColor,
                          textStyle:
                              (widget.textStyle ?? style.textStyle).copyWith(
                            color: resolvedForegroundColor,
                          ),
                          child: widget.child,
                        ),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    if (resolvedWidth != null || widget.isIconOnly) {
      return button;
    }

    return IntrinsicWidth(child: button);
  }
}

class _ButtonContent extends StatelessWidget {
  const _ButtonContent({
    required this.label,
    required this.isLoading,
    required this.showLeftIcon,
    required this.showRightIcon,
    required this.iconSize,
    required this.gap,
    required this.iconColor,
    required this.loadingIndicatorColor,
    required this.textStyle,
    this.icon,
    this.iconAssetPath,
    this.child,
  });

  final String label;
  final bool isLoading;
  final Widget? icon;
  final String? iconAssetPath;
  final bool showLeftIcon;
  final bool showRightIcon;
  final double iconSize;
  final double gap;
  final Color iconColor;
  final Color loadingIndicatorColor;
  final TextStyle textStyle;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final labelWidget = DefaultTextStyle(
      style: textStyle,
      textAlign: TextAlign.center,
      textHeightBehavior: _buttonTextHeightBehavior,
      child: child ??
          AppText(
            label,
            textHeightBehavior: _buttonTextHeightBehavior,
          ),
    );

    if (!isLoading && !showLeftIcon && !showRightIcon) {
      return labelWidget;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isLoading) ...[
          SizedBox(
            width: iconSize,
            height: iconSize,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: loadingIndicatorColor,
            ),
          ),
          SizedBox(width: gap),
        ] else if (showLeftIcon) ...[
          _ButtonIcon(
            icon: icon,
            assetPath: iconAssetPath,
            size: iconSize,
            color: iconColor,
          ),
          SizedBox(width: gap),
        ],
        labelWidget,
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
      padding: isIconOnly ? EdgeInsets.zero : _padding(size, type),
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

  static EdgeInsetsGeometry _padding(
    SsossButtonSize size,
    SsossButtonType type,
  ) {
    if (type == SsossButtonType.link || type == SsossButtonType.ghost) {
      switch (size) {
        case SsossButtonSize.large:
          return const EdgeInsets.symmetric(horizontal: 16, vertical: 15);
        case SsossButtonSize.medium:
          return const EdgeInsets.symmetric(horizontal: 12, vertical: 10);
        case SsossButtonSize.small:
          return const EdgeInsets.symmetric(horizontal: 8, vertical: 10);
      }
    }

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
