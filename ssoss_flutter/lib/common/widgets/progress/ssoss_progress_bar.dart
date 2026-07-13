import 'package:flutter/material.dart';
import 'package:ssoss_flutter/common/widgets/text/app_text.dart';

import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';

class SsossProgressStep {
  const SsossProgressStep({
    required this.label,
    this.value,
  });

  final String label;
  final String? value;
}

class SsossProgressBar extends StatelessWidget {
  const SsossProgressBar({
    required this.steps,
    required this.currentIndex,
    super.key,
    this.gap = 8,
    this.itemGap = 12,
    this.lineHeight = 4,
    this.activeColor,
    this.inactiveColor,
    this.textStyle,
    this.width,
  });

  final List<SsossProgressStep> steps;
  final int currentIndex;
  final double gap;
  final double itemGap;
  final double lineHeight;
  final Color? activeColor;
  final Color? inactiveColor;
  final TextStyle? textStyle;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final expands = width != null;

    return SizedBox(
      width: width,
      child: Row(
        mainAxisSize: expands ? MainAxisSize.max : MainAxisSize.min,
        children: [
          for (var index = 0; index < steps.length; index++) ...[
            if (expands)
              Expanded(
                child: SsossProgressBarItem(
                  label: steps[index].label,
                  value: steps[index].value ?? _formatValue(index),
                  isActive: index == currentIndex,
                  gap: itemGap,
                  lineHeight: lineHeight,
                  activeColor: activeColor,
                  inactiveColor: inactiveColor,
                  textStyle: textStyle,
                  expandLine: true,
                ),
              )
            else
              IntrinsicWidth(
                child: SsossProgressBarItem(
                  label: steps[index].label,
                  value: steps[index].value ?? _formatValue(index),
                  isActive: index == currentIndex,
                  gap: itemGap,
                  lineHeight: lineHeight,
                  activeColor: activeColor,
                  inactiveColor: inactiveColor,
                  textStyle: textStyle,
                  expandLine: true,
                ),
              ),
            if (index != steps.length - 1) SizedBox(width: gap),
          ],
        ],
      ),
    );
  }

  String _formatValue(int index) {
    return (index + 1).toString().padLeft(2, '0');
  }
}

class SsossProgressBarItem extends StatelessWidget {
  const SsossProgressBarItem({
    required this.label,
    required this.value,
    super.key,
    this.isActive = false,
    this.gap = 12,
    this.lineHeight = 4,
    this.activeColor,
    this.inactiveColor,
    this.textStyle,
    this.expandLine = false,
  });

  final String label;
  final String value;
  final bool isActive;
  final double gap;
  final double lineHeight;
  final Color? activeColor;
  final Color? inactiveColor;
  final TextStyle? textStyle;
  final bool expandLine;

  @override
  Widget build(BuildContext context) {
    final foregroundColor = isActive
        ? activeColor ?? AppColors.primary400
        : inactiveColor ?? AppColors.neutral300;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: expandLine ? MainAxisSize.max : MainAxisSize.min,
          children: [
            AppText(
              value,
              overflow: TextOverflow.ellipsis,
              style: (textStyle ?? AppTextStyles.h8).copyWith(
                color: foregroundColor,
              ),
            ),
            const SizedBox(width: 4),
            if (expandLine)
              Expanded(
                child: AppText(
                  label,
                  overflow: TextOverflow.ellipsis,
                  style: (textStyle ?? AppTextStyles.h8).copyWith(
                    color: foregroundColor,
                  ),
                ),
              )
            else
              AppText(
                label,
                overflow: TextOverflow.ellipsis,
                style: (textStyle ?? AppTextStyles.h8).copyWith(
                  color: foregroundColor,
                ),
              ),
          ],
        ),
        SizedBox(height: gap),
        Container(
          width: expandLine ? double.infinity : null,
          height: lineHeight,
          color: foregroundColor,
        ),
      ],
    );
  }
}
