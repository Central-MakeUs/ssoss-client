import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ssoss_flutter/common/widgets/card/ssoss_contents_card_block.dart';
import 'package:ssoss_flutter/common/widgets/card/ssoss_recommendation_card.dart';
import 'package:ssoss_flutter/common/widgets/tag/ssoss_tag.dart';
import 'package:ssoss_flutter/common/widgets/text/app_text.dart';
import 'package:ssoss_flutter/common/widgets/toast/ssoss_toast.dart';
import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/constants/assets.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';

class SsossContentsCard extends StatefulWidget {
  const SsossContentsCard({
    required this.blocks,
    super.key,
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

  final List<SsossContentsCardBlock> blocks;
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

  bool get _isHashtagsOnly =>
      blocks.length == 1 && blocks.first is SsossContentsCardHashtagsBlock;

  String get _copyText {
    final buffer = StringBuffer();
    var insertNewlineBeforeNextText = false;

    for (final block in blocks) {
      switch (block) {
        case SsossContentsCardTextBlock(:final text):
          if (insertNewlineBeforeNextText && buffer.isNotEmpty) {
            buffer.write('\n');
          }
          insertNewlineBeforeNextText = false;
          buffer.write(text);
        case SsossContentsCardRecommendationBlock():
          if (buffer.isNotEmpty) {
            insertNewlineBeforeNextText = true;
          }
        case SsossContentsCardHashtagsBlock(:final hashtags):
          insertNewlineBeforeNextText = false;
          if (buffer.isNotEmpty) {
            buffer.write(' ');
          }
          buffer.write(
            hashtags.map(_formatHashtag).join(' '),
          );
      }
    }
    return buffer.toString();
  }

  static String _formatHashtag(String tag) {
    final trimmed = tag.trim();
    if (trimmed.isEmpty) {
      return trimmed;
    }
    return trimmed.startsWith('#') ? trimmed : '#$trimmed';
  }

  @override
  State<SsossContentsCard> createState() => _SsossContentsCardState();
}

class _SsossContentsCardState extends State<SsossContentsCard> {
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
        (widget._isHashtagsOnly
            ? const EdgeInsets.fromLTRB(12, 12, 12, 16)
            : const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 20,
              ));

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
                for (var i = 0; i < widget.blocks.length; i++) ...[
                  if (i > 0) const SizedBox(height: 24),
                  _buildBlock(widget.blocks[i]),
                ],
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

  Widget _buildBlock(SsossContentsCardBlock block) {
    return switch (block) {
      SsossContentsCardTextBlock(:final text) => AppText(
          text,
          style: (widget.contentStyle ?? AppTextStyles.b4).copyWith(
            color: widget.contentColor ?? AppColors.neutral700,
          ),
        ),
      SsossContentsCardRecommendationBlock(:final item) =>
        SsossRecommendationCard(item: item),
      SsossContentsCardHashtagsBlock(:final hashtags) => Align(
          alignment: Alignment.centerLeft,
          child: Wrap(
            alignment: WrapAlignment.start,
            spacing: 6,
            runSpacing: 8,
            children: [
              for (final tag in hashtags)
                SsossTag(
                  label: tag,
                  type: SsossTagType.gray,
                  showLeftIcon: false,
                  showRightIcon: false,
                ),
            ],
          ),
        ),
    };
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
