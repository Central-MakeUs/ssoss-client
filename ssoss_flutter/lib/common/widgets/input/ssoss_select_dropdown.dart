import 'package:flutter/material.dart';

import 'package:ssoss_flutter/common/widgets/input/ssoss_select_field.dart';
import 'package:ssoss_flutter/common/widgets/input/ssoss_select_option.dart';
import 'package:ssoss_flutter/core/colors/app_colors.dart';

class SsossSelectDropdown extends StatelessWidget {
  const SsossSelectDropdown({
    required this.options,
    super.key,
    this.value,
    this.placeholder = 'Value',
    this.isOpen = true,
    this.enabled = true,
    this.selectedIndex,
    this.highlightedIndex,
    this.onFieldTap,
    this.onOptionSelected,
    this.fieldBorderColor,
    this.fieldFillColor,
    this.fieldValueColor,
    this.fieldPlaceholderColor,
    this.fieldIconColor,
    this.optionBorderColor,
    this.optionBackgroundColor,
    this.optionTextColor,
    this.selectedOptionBackgroundColor,
    this.hoverOptionBackgroundColor,
    this.pressedOptionBackgroundColor,
    this.selectedOptionTextColor,
  });

  final List<String> options;
  final String? value;
  final String placeholder;
  final bool isOpen;
  final bool enabled;
  final int? selectedIndex;
  final int? highlightedIndex;
  final VoidCallback? onFieldTap;
  final ValueChanged<int>? onOptionSelected;
  final Color? fieldBorderColor;
  final Color? fieldFillColor;
  final Color? fieldValueColor;
  final Color? fieldPlaceholderColor;
  final Color? fieldIconColor;
  final Color? optionBorderColor;
  final Color? optionBackgroundColor;
  final Color? optionTextColor;
  final Color? selectedOptionBackgroundColor;
  final Color? hoverOptionBackgroundColor;
  final Color? pressedOptionBackgroundColor;
  final Color? selectedOptionTextColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SsossSelectField(
          value: value,
          placeholder: placeholder,
          isOpen: isOpen,
          enabled: enabled,
          onTap: onFieldTap,
          borderColor: fieldBorderColor,
          fillColor: fieldFillColor,
          valueColor: fieldValueColor,
          placeholderColor: fieldPlaceholderColor,
          iconColor: fieldIconColor,
        ),
        if (isOpen) ...[
          const SizedBox(height: 6),
          Container(
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
              children: _buildOptions(),
            ),
          ),
        ],
      ],
    );
  }

  List<Widget> _buildOptions() {
    return List<Widget>.generate(options.length, (index) {
      return Padding(
        padding: EdgeInsets.only(top: index == 0 ? 0 : 8),
        child: SsossSelectOption(
          value: options[index],
          state: _optionState(index),
          onTap: onOptionSelected == null
              ? null
              : () => onOptionSelected?.call(index),
          backgroundColor: optionBackgroundColor,
          textColor: optionTextColor,
          selectedBackgroundColor: selectedOptionBackgroundColor,
          hoverBackgroundColor: hoverOptionBackgroundColor,
          pressedBackgroundColor: pressedOptionBackgroundColor,
          selectedTextColor: selectedOptionTextColor,
        ),
      );
    });
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
