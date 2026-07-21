import 'package:flutter/material.dart';

import 'package:ssoss_flutter/core/colors/app_colors.dart';

class SsossToggle extends StatelessWidget {
  const SsossToggle({
    required this.isChecked,
    super.key,
    this.isDisabled = false,
    this.onChanged,
    this.thumbSize = 18,
    this.padding = const EdgeInsets.all(2),
    this.activeColor,
    this.inactiveColor,
    this.disabledActiveColor,
    this.disabledInactiveColor,
    this.thumbColor,
    this.borderRadius,
    this.duration = const Duration(milliseconds: 160),
    this.curve = Curves.easeOut,
  });

  final bool isChecked;
  final bool isDisabled;
  final ValueChanged<bool>? onChanged;
  final double thumbSize;
  final EdgeInsetsGeometry padding;
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? disabledActiveColor;
  final Color? disabledInactiveColor;
  final Color? thumbColor;
  final BorderRadiusGeometry? borderRadius;
  final Duration duration;
  final Curve curve;

  bool get _isInteractive => !isDisabled && onChanged != null;

  static const double _trackWidth = 44;
  static const double _trackHeight = 22;

  @override
  Widget build(BuildContext context) {
    final resolvedTrackColor = _resolveTrackColor();
    final resolvedBorderRadius = borderRadius ?? BorderRadius.circular(16);

    return Semantics(
      button: true,
      checked: isChecked,
      enabled: !isDisabled,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _isInteractive ? () => onChanged!(!isChecked) : null,
        child: AnimatedContainer(
          width: _trackWidth,
          height: _trackHeight,
          padding: padding,
          duration: duration,
          curve: curve,
          decoration: BoxDecoration(
            color: resolvedTrackColor,
            borderRadius: resolvedBorderRadius,
          ),
          child: AnimatedAlign(
            alignment: isChecked ? Alignment.centerRight : Alignment.centerLeft,
            duration: duration,
            curve: curve,
            child: Container(
              width: thumbSize,
              height: thumbSize,
              decoration: BoxDecoration(
                color: thumbColor ?? AppColors.white,
                borderRadius: BorderRadius.circular(77),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x1A000000),
                    blurRadius: 2,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color _resolveTrackColor() {
    if (isDisabled) {
      return isChecked
          ? disabledActiveColor ?? AppColors.primary200
          : disabledInactiveColor ?? AppColors.neutral100;
    }

    return isChecked
        ? activeColor ?? AppColors.primary400
        : inactiveColor ?? AppColors.neutral300;
  }
}
