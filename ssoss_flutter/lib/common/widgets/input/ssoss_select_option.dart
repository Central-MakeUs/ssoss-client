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

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
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

/// 선택 드롭다운 / 주소 검색 공통 옵션 패널.
class SsossSelectOptionsPanel extends StatelessWidget {
  const SsossSelectOptionsPanel({
    required this.options,
    super.key,
    this.selectedIndex,
    this.highlightedIndex,
    this.width,
    this.onOptionSelected,
    this.optionBorderColor,
    this.optionBackgroundColor,
    this.optionTextColor,
    this.selectedOptionBackgroundColor,
    this.hoverOptionBackgroundColor,
    this.pressedOptionBackgroundColor,
    this.selectedOptionTextColor,
  });

  final List<String> options;
  final int? selectedIndex;
  final int? highlightedIndex;
  final double? width;
  final ValueChanged<int>? onOptionSelected;
  final Color? optionBorderColor;
  final Color? optionBackgroundColor;
  final Color? optionTextColor;
  final Color? selectedOptionBackgroundColor;
  final Color? hoverOptionBackgroundColor;
  final Color? pressedOptionBackgroundColor;
  final Color? selectedOptionTextColor;

  static const double gap = 6;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: optionBorderColor ?? AppColors.neutral200,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var index = 0; index < options.length; index++)
            Padding(
              padding: EdgeInsets.only(top: index == 0 ? 0 : 8),
              child: Listener(
                behavior: HitTestBehavior.opaque,
                onPointerDown: onOptionSelected == null
                    ? null
                    : (_) => onOptionSelected!(index),
                child: SsossSelectOption(
                  value: options[index],
                  state: _optionState(index),
                  width: width,
                  backgroundColor: optionBackgroundColor,
                  textColor: optionTextColor,
                  selectedBackgroundColor: selectedOptionBackgroundColor,
                  hoverBackgroundColor: hoverOptionBackgroundColor,
                  pressedBackgroundColor: pressedOptionBackgroundColor,
                  selectedTextColor: selectedOptionTextColor,
                ),
              ),
            ),
        ],
      ),
    );
  }

  SsossSelectOptionState _optionState(int index) {
    if (index == selectedIndex) {
      return SsossSelectOptionState.selected;
    }

    if (index == highlightedIndex) {
      return SsossSelectOptionState.hover;
    }

    return SsossSelectOptionState.normal;
  }
}
