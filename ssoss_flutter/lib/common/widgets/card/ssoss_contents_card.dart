import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/constants/assets.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';

class SsossContentsCard extends StatelessWidget {
  const SsossContentsCard({
    required this.content,
    super.key,
    this.recommendation,
    this.onEdit,
    this.onCopy,
    this.editLabel = '수정하기',
    this.copyLabel = '복사하기',
    this.width = 343,
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
  final SsossContentsCardRecommendation? recommendation;
  final VoidCallback? onEdit;
  final VoidCallback? onCopy;
  final String editLabel;
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

  bool get _hasRecommendation => recommendation != null;

  @override
  Widget build(BuildContext context) {
    final resolvedBorderColor = borderColor ?? AppColors.neutral200;
    final resolvedRadius = borderRadius ?? BorderRadius.circular(12);

    return ClipRRect(
      borderRadius: resolvedRadius,
      child: Container(
        width: width,
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.white,
          borderRadius: resolvedRadius,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              padding: topPadding ??
                  const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 20,
                  ),
              decoration: BoxDecoration(
                color: backgroundColor ?? AppColors.white,
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
                    _RecommendationBox(recommendation: recommendation!),
                    const SizedBox(height: 24),
                  ],
                  Text(
                    content,
                    style: (contentStyle ?? AppTextStyles.b4).copyWith(
                      color: contentColor ?? AppColors.neutral700,
                      letterSpacing: -0.16,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: actionPadding ??
                  const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
              decoration: BoxDecoration(
                color: backgroundColor ?? AppColors.white,
                border: Border.all(color: resolvedBorderColor),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _ContentsCardAction(
                    label: editLabel,
                    iconAsset: AppAssets.icEdit2,
                    onTap: onEdit,
                    color: actionColor ?? AppColors.neutral500,
                    textStyle: actionTextStyle,
                  ),
                  const SizedBox(width: 8),
                  _ContentsCardAction(
                    label: copyLabel,
                    iconAsset: AppAssets.icCopy,
                    onTap: onCopy,
                    color: actionColor ?? AppColors.neutral500,
                    textStyle: actionTextStyle,
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

class SsossContentsCardRecommendation {
  const SsossContentsCardRecommendation({
    required this.label,
    required this.title,
    required this.description,
    this.backgroundColor,
    this.labelColor,
    this.titleColor,
    this.descriptionColor,
  });

  final String label;
  final String title;
  final String description;
  final Color? backgroundColor;
  final Color? labelColor;
  final Color? titleColor;
  final Color? descriptionColor;
}

class _RecommendationBox extends StatelessWidget {
  const _RecommendationBox({
    required this.recommendation,
  });

  final SsossContentsCardRecommendation recommendation;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),
      decoration: BoxDecoration(
        color: recommendation.backgroundColor ?? AppColors.secondary50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            recommendation.label,
            style: AppTextStyles.h9.copyWith(
              color: recommendation.labelColor ?? AppColors.secondary400,
              letterSpacing: -0.12,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            recommendation.title,
            style: AppTextStyles.h5.copyWith(
              color: recommendation.titleColor ?? AppColors.neutral500,
              letterSpacing: -0.18,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            recommendation.description,
            style: AppTextStyles.b5.copyWith(
              color: recommendation.descriptionColor ?? AppColors.neutral400,
              letterSpacing: -0.14,
            ),
          ),
        ],
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
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
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
            Text(
              label,
              style: (textStyle ?? AppTextStyles.h8).copyWith(
                color: color,
                letterSpacing: -0.14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
