import 'package:flutter/material.dart';
import 'package:ssoss_flutter/common/widgets/card/ssoss_recommendation_card.dart';
import 'package:ssoss_flutter/common/widgets/text/app_text.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/constants/assets.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';

class SsossContentsCard extends StatefulWidget {
  const SsossContentsCard({
    required this.content,
    super.key,
    this.recommendation,
    this.onCopy,
    this.copyLabel = '복사하기',
    this.width,
    this.backgroundColor,
    this.borderColor,
    this.contentColor,
    this.actionColor,
    this.topPadding,
    this.actionPadding,
    this.borderRadius,
    this.contentStyle,
    this.actionTextStyle,
  });

  final String content;
  final SsossRecommendationCardItem? recommendation;
  final VoidCallback? onCopy;
  final String copyLabel;
  final double? width;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? contentColor;
  final Color? actionColor;
  final EdgeInsetsGeometry? topPadding;
  final EdgeInsetsGeometry? actionPadding;
  final BorderRadiusGeometry? borderRadius;
  final TextStyle? contentStyle;
  final TextStyle? actionTextStyle;

  @override
  State<SsossContentsCard> createState() => _SsossContentsCardState();
}

class _SsossContentsCardState extends State<SsossContentsCard> {
  bool get _hasRecommendation => widget.recommendation != null;

  @override
  Widget build(BuildContext context) {
    final resolvedBorderColor = widget.borderColor ?? AppColors.neutral200;
    final resolvedRadius = widget.borderRadius ?? BorderRadius.circular(12);

    return ClipRRect(
      borderRadius: resolvedRadius,
      child: Container(
        width: widget.width,
        decoration: BoxDecoration(
          color: widget.backgroundColor ?? AppColors.white,
          borderRadius: resolvedRadius,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: widget.topPadding ??
                  const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 20,
                  ),
              decoration: BoxDecoration(
                color: widget.backgroundColor ?? AppColors.white,
                border: Border(
                  top: BorderSide(color: resolvedBorderColor),
                  left: BorderSide(color: resolvedBorderColor),
                  right: BorderSide(color: resolvedBorderColor),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (_hasRecommendation) ...[
                    SsossRecommendationCard(
                      item: widget.recommendation!,
                    ),
                    const SizedBox(height: 24),
                  ],
                  AppText(
                    widget.content,
                    style: (widget.contentStyle ?? AppTextStyles.b4).copyWith(
                      color: widget.contentColor ?? AppColors.neutral700,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: widget.actionPadding ??
                  const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
              decoration: BoxDecoration(
                color: widget.backgroundColor ?? AppColors.white,
                border: Border.all(color: resolvedBorderColor),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _ContentsCardAction(
                    label: widget.copyLabel,
                    iconAsset: AppAssets.icCopy,
                    onTap: widget.onCopy,
                    color: widget.actionColor ?? AppColors.neutral500,
                    textStyle: widget.actionTextStyle,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ContentsCardAction extends StatelessWidget {
  const _ContentsCardAction({
    required this.label,
    required this.iconAsset,
    required this.color,
    this.onTap,
    this.textStyle,
  });

  final String label;
  final String iconAsset;
  final Color color;
  final VoidCallback? onTap;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 32,
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 6,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              iconAsset,
              width: 18,
              height: 18,
              colorFilter: ColorFilter.mode(
                color,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 4),
            AppText(
              label,
              style: (textStyle ?? AppTextStyles.h8).copyWith(
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
