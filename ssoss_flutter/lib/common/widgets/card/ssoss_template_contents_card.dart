import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ssoss_flutter/common/widgets/card/ssoss_expandable_card_body.dart';
import 'package:ssoss_flutter/common/widgets/card/template/ssoss_template_document.dart';
import 'package:ssoss_flutter/common/widgets/text/app_text.dart';
import 'package:ssoss_flutter/common/widgets/toast/ssoss_toast.dart';
import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/constants/assets.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';

/// 템플릿 전용 콘텐츠 표시 카드.
///
/// 본문은 검정, 템플릿 원본 `[...]`만 주황으로 표시한다.
class SsossTemplateContentsCard extends StatelessWidget {
  const SsossTemplateContentsCard({
    required this.document,
    super.key,
    this.onCopy,
    this.copyLabel = '복사하기',
    this.width,
    this.backgroundColor,
    this.borderColor,
    this.contentColor,
    this.emptySlotColor,
    this.actionColor,
    this.topPadding,
    this.actionPadding,
    this.borderRadius,
    this.contentStyle,
    this.actionTextStyle,
  });

  final SsossTemplateDocument document;
  final VoidCallback? onCopy;
  final String copyLabel;
  final double? width;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? contentColor;
  final Color? emptySlotColor;
  final Color? actionColor;
  final EdgeInsetsGeometry? topPadding;
  final EdgeInsetsGeometry? actionPadding;
  final BorderRadiusGeometry? borderRadius;
  final TextStyle? contentStyle;
  final TextStyle? actionTextStyle;

  Future<void> _handleCopy(BuildContext context) async {
    await Clipboard.setData(ClipboardData(text: document.plainText));
    if (!context.mounted) {
      return;
    }
    showSsossToast(
      context,
      title: '클립보드에 복사되었습니다',
    );
    onCopy?.call();
  }

  @override
  Widget build(BuildContext context) {
    final resolvedBorderColor = borderColor ?? AppColors.neutral200;
    final resolvedRadius = borderRadius ?? BorderRadius.circular(12);
    final baseStyle = (contentStyle ?? AppTextStyles.b4).copyWith(
      color: contentColor ?? AppColors.black,
    );
    final slotEmptyColor = emptySlotColor ?? AppColors.primary300;

    // ClipRRect로 테두리를 자르면 하단 둥근 보더가 잘려 보이므로,
    // 외곽 Container에 border + borderRadius를 두고 구분선만 내부에 둔다.
    return Container(
      width: width,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.white,
        borderRadius: resolvedRadius,
        border: Border.all(color: resolvedBorderColor),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: topPadding ??
                const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 20,
                ),
            child: SsossExpandableCardBody(
              child: SizedBox(
                width: double.infinity,
                child: Text.rich(
                  document.buildTextSpan(
                    baseStyle: baseStyle,
                    placeholderColor: slotEmptyColor,
                  ),
                ),
              ),
            ),
          ),
          ColoredBox(
            color: resolvedBorderColor,
            child: const SizedBox(height: 1, width: double.infinity),
          ),
          Padding(
            padding: actionPadding ??
                const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _TemplateContentsCardAction(
                  label: copyLabel,
                  iconAsset: AppAssets.icCopy,
                  onTap: () => unawaited(_handleCopy(context)),
                  color: actionColor ?? AppColors.neutral500,
                  textStyle: actionTextStyle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TemplateContentsCardAction extends StatelessWidget {
  const _TemplateContentsCardAction({
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
