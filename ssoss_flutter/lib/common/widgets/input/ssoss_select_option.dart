import 'package:flutter/material.dart';
import 'package:ssoss_flutter/common/widgets/text/app_text.dart';

import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';

enum SsossSelectOptionState {
  normal,
  selected,
  hover,
  pressed,
}

class SsossSelectOption extends StatelessWidget {
  const SsossSelectOption({
    required this.value,
    super.key,
    this.state = SsossSelectOptionState.normal,
    this.onTap,
    this.backgroundColor,
    this.textColor,
    this.selectedBackgroundColor,
    this.hoverBackgroundColor,
    this.pressedBackgroundColor,
    this.selectedTextColor,
    this.width,
  });

  final String value;
  final SsossSelectOptionState state;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? selectedBackgroundColor;
  final Color? hoverBackgroundColor;
  final Color? pressedBackgroundColor;
  final Color? selectedTextColor;
  final double? width;

  static const double height = 36;
  static const double _borderRadius = 4;

  @override
  Widget build(BuildContext context) {
    final resolvedBackgroundColor = _backgroundColor;
    final resolvedTextColor = _isActive
        ? selectedTextColor ?? AppColors.neutral800
        : textColor ?? AppColors.neutral500;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(_borderRadius),
      child: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: resolvedBackgroundColor,
          borderRadius: BorderRadius.circular(_borderRadius),
        ),
        alignment: Alignment.centerLeft,
        child: AppText(
          value,
          style: AppTextStyles.b5.copyWith(
            color: resolvedTextColor,
          ),
        ),
      ),
    );
  }

  bool get _isActive {
    return state == SsossSelectOptionState.selected ||
        state == SsossSelectOptionState.hover ||
        state == SsossSelectOptionState.pressed;
  }

  Color get _backgroundColor {
    switch (state) {
      case SsossSelectOptionState.normal:
        return backgroundColor ?? AppColors.white;
      case SsossSelectOptionState.selected:
        return selectedBackgroundColor ?? AppColors.primary50;
      case SsossSelectOptionState.hover:
        return hoverBackgroundColor ?? AppColors.neutral100;
      case SsossSelectOptionState.pressed:
        return pressedBackgroundColor ?? AppColors.neutral400;
    }
  }
}
