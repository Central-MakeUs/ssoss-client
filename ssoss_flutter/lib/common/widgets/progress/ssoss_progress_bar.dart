import 'package:flutter/material.dart';

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
    this.width,
    this.itemWidth = 109,
    this.gap = 8,
    this.itemGap = 12,
    this.lineHeight = 4,
    this.activeColor,
    this.inactiveColor,
    this.textStyle,
  });

  final List<SsossProgressStep> steps;
  final int currentIndex;
  final double? width;
  final double itemWidth;
  final double gap;
  final double itemGap;
  final double lineHeight;
  final Color? activeColor;
  final Color? inactiveColor;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Row(
        mainAxisSize: width == null ? MainAxisSize.min : MainAxisSize.max,
        children: [
          for (var index = 0; index < steps.length; index++) ...[
            SsossProgressBarItem(
              label: steps[index].label,
              value: steps[index].value ?? _formatValue(index),
              isActive: index == currentIndex,
              width: itemWidth,
              gap: itemGap,
              lineHeight: lineHeight,
              activeColor: activeColor,
              inactiveColor: inactiveColor,
              textStyle: textStyle,
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
    this.width = 109,
    this.gap = 12,
    this.lineHeight = 4,
    this.activeColor,
    this.inactiveColor,
    this.textStyle,
  });

  final String label;
  final String value;
  final bool isActive;
  final double width;
  final double gap;
  final double lineHeight;
  final Color? activeColor;
  final Color? inactiveColor;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final foregroundColor = isActive
        ? activeColor ?? AppColors.primary400
        : inactiveColor ?? AppColors.neutral300;

    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: (textStyle ?? AppTextStyles.h8).copyWith(
                  color: foregroundColor,
                  letterSpacing: -0.14,
                ),
              ),
              const SizedBox(width: 4),
              Flexible(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: (textStyle ?? AppTextStyles.h8).copyWith(
                    color: foregroundColor,
                    letterSpacing: -0.14,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: gap),
          Container(
            width: double.infinity,
            height: lineHeight,
            color: foregroundColor,
          ),
        ],
      ),
    );
  }
}
