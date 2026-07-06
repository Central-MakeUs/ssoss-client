import 'package:flutter/material.dart';

import 'package:ssoss_flutter/common/widgets/button/ssoss_button.dart';
import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';

class SsossModal extends StatelessWidget {
  const SsossModal({
    required this.title,
    super.key,
    this.message,
    this.onClose,
    this.primaryButtonLabel = 'Button',
    this.secondaryButtonLabel = 'Button',
    this.onPrimaryPressed,
    this.onSecondaryPressed,
    this.showButtonIcons = true,
    this.actions,
    this.width = 348,
    this.padding,
    this.borderRadius,
    this.backgroundColor,
    this.borderColor,
    this.titleColor,
    this.messageColor,
    this.closeIconColor,
    this.gap = 24,
    this.headerGap = 2,
    this.messageGap = 7,
    this.actionGap = 8,
    this.titleStyle,
    this.messageStyle,
  });

  final String title;
  final String? message;
  final VoidCallback? onClose;
  final String primaryButtonLabel;
  final String secondaryButtonLabel;
  final VoidCallback? onPrimaryPressed;
  final VoidCallback? onSecondaryPressed;
  final bool showButtonIcons;
  final Widget? actions;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? titleColor;
  final Color? messageColor;
  final Color? closeIconColor;
  final double gap;
  final double headerGap;
  final double messageGap;
  final double actionGap;
  final TextStyle? titleStyle;
  final TextStyle? messageStyle;

  bool get _hasMessage => message != null && message!.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final resolvedBorderRadius = borderRadius ?? BorderRadius.circular(12);

    return Container(
      width: width,
      padding: padding ??
          const EdgeInsets.fromLTRB(
            16,
            16,
            16,
            18,
          ),
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.white,
        borderRadius: resolvedBorderRadius,
        border: Border.all(color: borderColor ?? AppColors.neutral200),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _ModalHeader(
            title: title,
            message: message,
            hasMessage: _hasMessage,
            onClose: onClose,
            titleColor: titleColor ?? AppColors.neutral800,
            messageColor: messageColor ?? AppColors.neutral400,
            closeIconColor: closeIconColor ?? AppColors.neutral400,
            headerGap: headerGap,
            messageGap: messageGap,
            titleStyle: titleStyle,
            messageStyle: messageStyle,
          ),
          SizedBox(height: gap),
          actions ?? _buildDefaultActions(),
        ],
      ),
    );
  }

  Widget _buildDefaultActions() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SsossButton(
          label: secondaryButtonLabel,
          size: SsossButtonSize.medium,
          type: SsossButtonType.neutral,
          width: 154,
          onPressed: onSecondaryPressed,
          showLeftIcon: showButtonIcons,
          showRightIcon: showButtonIcons,
        ),
        SizedBox(width: actionGap),
        SsossButton(
          label: primaryButtonLabel,
          size: SsossButtonSize.medium,
          type: SsossButtonType.primary,
          width: 154,
          onPressed: onPrimaryPressed,
          showLeftIcon: showButtonIcons,
          showRightIcon: showButtonIcons,
        ),
      ],
    );
  }
}

class _ModalHeader extends StatelessWidget {
  const _ModalHeader({
    required this.title,
    required this.message,
    required this.hasMessage,
    required this.titleColor,
    required this.messageColor,
    required this.closeIconColor,
    required this.headerGap,
    required this.messageGap,
    this.onClose,
    this.titleStyle,
    this.messageStyle,
  });

  final String title;
  final String? message;
  final bool hasMessage;
  final VoidCallback? onClose;
  final Color titleColor;
  final Color messageColor;
  final Color closeIconColor;
  final double headerGap;
  final double messageGap;
  final TextStyle? titleStyle;
  final TextStyle? messageStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(
          width: double.infinity,
          height: 24,
          child: Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: onClose,
              borderRadius: BorderRadius.circular(12),
              child: Icon(
                Icons.close,
                size: 24,
                color: closeIconColor,
              ),
            ),
          ),
        ),
        SizedBox(height: headerGap),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: (titleStyle ?? AppTextStyles.h4).copyWith(
                color: titleColor,
                height: 1.4,
                letterSpacing: -0.2,
              ),
            ),
            if (hasMessage) ...[
              SizedBox(height: messageGap),
              Text(
                message!,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: (messageStyle ?? AppTextStyles.b4).copyWith(
                  color: messageColor,
                  height: 1.4,
                  letterSpacing: -0.16,
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }
}
