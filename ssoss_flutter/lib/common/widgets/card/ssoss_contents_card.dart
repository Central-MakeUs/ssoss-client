import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ssoss_flutter/common/widgets/card/ssoss_recommendation_card.dart';
import 'package:ssoss_flutter/common/widgets/tag/ssoss_tag.dart';
import 'package:ssoss_flutter/common/widgets/text/app_text.dart';
import 'package:ssoss_flutter/common/widgets/toast/ssoss_toast.dart';
import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/constants/assets.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';

class SsossContentsCard extends StatefulWidget {
  /// 본문 문자열 카드.
  const SsossContentsCard({
    required String this.content,
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
  }) : hashtags = null;

  /// 해시태그 칩 카드.
  const SsossContentsCard.hashtags({
    required List<String> this.hashtags,
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
  }) : content = null;

  final String? content;
  final List<String>? hashtags;
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

  bool get _isHashtags => hashtags != null;

  String get _copyText {
    if (content != null) {
      return content!;
    }
    return hashtags!.join(' ');
  }

  @override
  State<SsossContentsCard> createState() => _SsossContentsCardState();
}

class _SsossContentsCardState extends State<SsossContentsCard> {
  bool get _hasRecommendation => widget.recommendation != null;

  Future<void> _handleCopy() async {
    await Clipboard.setData(ClipboardData(text: widget._copyText));
    if (!mounted) {
      return;
    }
    showSsossToast(
      context,
      title: '클립보드에 복사되었습니다',
    );
    widget.onCopy?.call();
  }

  @override
  Widget build(BuildContext context) {
    final resolvedBorderColor = widget.borderColor ?? AppColors.neutral200;
    final resolvedRadius = widget.borderRadius ?? BorderRadius.circular(12);
    final resolvedTopPadding = widget.topPadding ??
        (widget._isHashtags
            ? const EdgeInsets.fromLTRB(12, 12, 12, 16)
            : const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 20,
              ));

    // ClipRRect로 테두리를 자르면 하단 둥근 보더가 잘려 보이므로,
    // 외곽 Container에 border + borderRadius를 두고 구분선만 내부에 둔다.
    return Container(
      width: widget.width,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? AppColors.white,
        borderRadius: resolvedRadius,
        border: Border.all(color: resolvedBorderColor),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: resolvedTopPadding,
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
                if (widget._isHashtags)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Wrap(
                      alignment: WrapAlignment.start,
                      spacing: 6,
                      runSpacing: 8,
                      children: [
                        for (final tag in widget.hashtags!)
                          SsossTag(
                            label: tag,
                            type: SsossTagType.gray,
                            showLeftIcon: false,
                            showRightIcon: false,
                          ),
                      ],
                    ),
                  )
                else
                  AppText(
                    widget.content!,
                    style: (widget.contentStyle ?? AppTextStyles.b4).copyWith(
                      color: widget.contentColor ?? AppColors.neutral700,
                    ),
                  ),
              ],
            ),
          ),
          ColoredBox(
            color: resolvedBorderColor,
            child: const SizedBox(height: 1, width: double.infinity),
          ),
          Padding(
            padding: widget.actionPadding ??
                const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _ContentsCardAction(
                  label: widget.copyLabel,
                  iconAsset: AppAssets.icCopy,
                  onTap: () => unawaited(_handleCopy()),
                  color: widget.actionColor ?? AppColors.neutral500,
                  textStyle: widget.actionTextStyle,
                ),
              ],
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
