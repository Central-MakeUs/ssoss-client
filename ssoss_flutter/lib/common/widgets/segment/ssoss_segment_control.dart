import 'package:flutter/material.dart';
import 'package:ssoss_flutter/common/widgets/text/app_text.dart';

import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';

class SsossSegmentControl extends StatelessWidget {
  const SsossSegmentControl({
    required this.labels,
    required this.selectedIndex,
    super.key,
    this.onChanged,
    this.width,
    this.height = 40,
    this.padding = const EdgeInsets.all(4),
    this.gap = 4,
    this.backgroundColor,
    this.selectedBackgroundColor,
    this.selectedColor,
    this.unselectedColor,
    this.borderRadius,
    this.itemBorderRadius,
    this.textStyle,
  });

  final List<String> labels;
  final int selectedIndex;
  final ValueChanged<int>? onChanged;
  final double? width;
  final double height;
  final EdgeInsetsGeometry padding;
  final double gap;
  final Color? backgroundColor;
  final Color? selectedBackgroundColor;
  final Color? selectedColor;
  final Color? unselectedColor;
  final BorderRadiusGeometry? borderRadius;
  final BorderRadiusGeometry? itemBorderRadius;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final expands = width != null;

    return Container(
      width: width,
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.neutral100,
        borderRadius: borderRadius ?? BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: expands ? MainAxisSize.max : MainAxisSize.min,
        children: [
          for (var index = 0; index < labels.length; index++) ...[
            if (expands)
              Expanded(
                child: _SsossSegmentItem(
                  label: labels[index],
                  isSelected: index == selectedIndex,
                  onTap: onChanged == null ? null : () => onChanged!(index),
                  selectedBackgroundColor:
                      selectedBackgroundColor ?? AppColors.white,
                  selectedColor: selectedColor ?? AppColors.neutral800,
                  unselectedColor: unselectedColor ?? AppColors.neutral500,
                  borderRadius: itemBorderRadius ?? BorderRadius.circular(6),
                  textStyle: textStyle,
                ),
              )
            else
              _SsossSegmentItem(
                label: labels[index],
                isSelected: index == selectedIndex,
                onTap: onChanged == null ? null : () => onChanged!(index),
                selectedBackgroundColor:
                    selectedBackgroundColor ?? AppColors.white,
                selectedColor: selectedColor ?? AppColors.neutral800,
                unselectedColor: unselectedColor ?? AppColors.neutral500,
                borderRadius: itemBorderRadius ?? BorderRadius.circular(6),
                textStyle: textStyle,
              ),
            if (index != labels.length - 1) SizedBox(width: gap),
          ],
        ],
      ),
    );
  }
}

class _SsossSegmentItem extends StatelessWidget {
  const _SsossSegmentItem({
    required this.label,
    required this.isSelected,
    required this.selectedBackgroundColor,
    required this.selectedColor,
    required this.unselectedColor,
    required this.borderRadius,
    this.onTap,
    this.textStyle,
  });

  final String label;
  final bool isSelected;
  final Color selectedBackgroundColor;
  final Color selectedColor;
  final Color unselectedColor;
  final BorderRadiusGeometry borderRadius;
  final VoidCallback? onTap;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final foregroundColor = isSelected ? selectedColor : unselectedColor;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
          height: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? selectedBackgroundColor : Colors.transparent,
            borderRadius: borderRadius,
          ),
          child: AppText(
            label,
            textAlign: TextAlign.center,
            style: (textStyle ?? AppTextStyles.h8).copyWith(
              color: foregroundColor,
            ),
          ),
        ),
    );
  }
}
