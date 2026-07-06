import 'package:flutter/material.dart';

import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';

class SsossTab extends StatelessWidget {
  const SsossTab({
    required this.label,
    required this.isSelected,
    super.key,
    this.onTap,
    this.chipLabel,
    this.child,
    this.width = 80,
    this.height = 43,
    this.padding,
    this.gap = 6,
    this.selectedColor,
    this.unselectedColor,
    this.selectedIndicatorColor,
    this.unselectedIndicatorColor,
    this.selectedIndicatorHeight = 2,
    this.unselectedIndicatorHeight = 1,
    this.textStyle,
    this.chipBackgroundColor,
    this.chipForegroundColor,
    this.chipPadding,
    this.chipTextStyle,
  });

  final String label;
  final bool isSelected;
  final VoidCallback? onTap;
  final String? chipLabel;
  final Widget? child;
  final double? width;
  final double height;
  final EdgeInsetsGeometry? padding;
  final double gap;
  final Color? selectedColor;
  final Color? unselectedColor;
  final Color? selectedIndicatorColor;
  final Color? unselectedIndicatorColor;
  final double selectedIndicatorHeight;
  final double unselectedIndicatorHeight;
  final TextStyle? textStyle;
  final Color? chipBackgroundColor;
  final Color? chipForegroundColor;
  final EdgeInsetsGeometry? chipPadding;
  final TextStyle? chipTextStyle;

  bool get _hasChip => chipLabel != null && chipLabel!.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final resolvedTextColor = isSelected
        ? selectedColor ?? AppColors.neutral700
        : unselectedColor ?? AppColors.neutral500;
    final resolvedIndicatorColor = isSelected
        ? selectedIndicatorColor ?? AppColors.neutral800
        : unselectedIndicatorColor ?? AppColors.neutral200;
    final indicatorHeight =
        isSelected ? selectedIndicatorHeight : unselectedIndicatorHeight;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: width,
          height: height,
          padding: padding ??
              const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 10,
              ),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: resolvedIndicatorColor,
                width: indicatorHeight,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: width == null ? MainAxisSize.min : MainAxisSize.max,
            children: [
              Flexible(
                child: child ??
                    Text(
                      label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: (textStyle ?? AppTextStyles.h6).copyWith(
                        color: resolvedTextColor,
                        letterSpacing: -0.16,
                      ),
                    ),
              ),
              if (_hasChip) ...[
                SizedBox(width: gap),
                _SsossTabChip(
                  label: chipLabel!,
                  backgroundColor: chipBackgroundColor ?? AppColors.success50,
                  foregroundColor: chipForegroundColor ?? AppColors.success700,
                  padding: chipPadding,
                  textStyle: chipTextStyle,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _SsossTabChip extends StatelessWidget {
  const _SsossTabChip({
    required this.label,
    required this.backgroundColor,
    required this.foregroundColor,
    this.padding,
    this.textStyle,
  });

  final String label;
  final Color backgroundColor;
  final Color foregroundColor;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ??
          const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 4,
          ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        style: (textStyle ?? AppTextStyles.b5).copyWith(
          color: foregroundColor,
          letterSpacing: -0.14,
        ),
      ),
    );
  }
}
