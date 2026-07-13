import 'package:flutter/material.dart';
import 'package:ssoss_flutter/common/widgets/text/app_text.dart';

import 'package:ssoss_flutter/common/widgets/button/ssoss_button.dart';
import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';

enum SsossModalResult {
  primary,
  secondary,
}

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
    this.width,
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
      children: [
        Expanded(
          child: SsossButton(
            label: secondaryButtonLabel,
            size: SsossButtonSize.medium,
            type: SsossButtonType.neutral,
            width: double.infinity,
            onPressed: onSecondaryPressed,
            showLeftIcon: showButtonIcons,
            showRightIcon: showButtonIcons,
          ),
        ),
        SizedBox(width: actionGap),
        Expanded(
          child: SsossButton(
            label: primaryButtonLabel,
            size: SsossButtonSize.medium,
            type: SsossButtonType.primary,
            width: double.infinity,
            onPressed: onPrimaryPressed,
            showLeftIcon: showButtonIcons,
            showRightIcon: showButtonIcons,
          ),
        ),
      ],
    );
  }
}

Future<SsossModalResult?> showSsossModal(
  BuildContext context, {
  required String title,
  String? message,
  String primaryButtonLabel = 'Button',
  String secondaryButtonLabel = 'Button',
  VoidCallback? onPrimaryPressed,
  VoidCallback? onSecondaryPressed,
  VoidCallback? onClose,
  bool showButtonIcons = true,
  Widget? actions,
  double? width = double.infinity,
  double? maxWidth,
  EdgeInsetsGeometry? padding,
  BorderRadiusGeometry? borderRadius,
  Color? backgroundColor,
  Color? borderColor,
  Color? titleColor,
  Color? messageColor,
  Color? closeIconColor,
  double gap = 24,
  double headerGap = 2,
  double messageGap = 7,
  double actionGap = 8,
  TextStyle? titleStyle,
  TextStyle? messageStyle,
  bool barrierDismissible = false,
  Color barrierColor = const Color(0x80000000),
  EdgeInsets insetPadding = const EdgeInsets.symmetric(horizontal: 16),
  bool useRootNavigator = true,
}) {
  return showDialog<SsossModalResult>(
    context: context,
    barrierDismissible: barrierDismissible,
    barrierColor: barrierColor,
    useRootNavigator: useRootNavigator,
    builder: (dialogContext) {
      void dismiss([SsossModalResult? result]) {
        Navigator.of(dialogContext).pop(result);
      }

      Widget modal = SsossModal(
        title: title,
        message: message,
        primaryButtonLabel: primaryButtonLabel,
        secondaryButtonLabel: secondaryButtonLabel,
        showButtonIcons: showButtonIcons,
        actions: actions,
        width: width,
        padding: padding,
        borderRadius: borderRadius,
        backgroundColor: backgroundColor,
        borderColor: borderColor,
        titleColor: titleColor,
        messageColor: messageColor,
        closeIconColor: closeIconColor,
        gap: gap,
        headerGap: headerGap,
        messageGap: messageGap,
        actionGap: actionGap,
        titleStyle: titleStyle,
        messageStyle: messageStyle,
        onClose: () {
          dismiss();
          onClose?.call();
        },
        onPrimaryPressed: () {
          dismiss(SsossModalResult.primary);
          onPrimaryPressed?.call();
        },
        onSecondaryPressed: () {
          dismiss(SsossModalResult.secondary);
          onSecondaryPressed?.call();
        },
      );

      if (maxWidth != null) {
        modal = ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: modal,
        );
      }

      return Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        insetPadding: insetPadding,
        child: modal,
      );
    },
  );
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
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Align(
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
        SizedBox(height: headerGap),
        AppText(
          title,
          textAlign: TextAlign.center,
          style: (titleStyle ?? AppTextStyles.h4).copyWith(
            color: titleColor,
            height: 1.4,
          ),
        ),
        if (hasMessage) ...[
          SizedBox(height: messageGap),
          AppText(
            message!,
            textAlign: TextAlign.center,
            style: (messageStyle ?? AppTextStyles.b4).copyWith(
              color: messageColor,
              height: 1.4,
            ),
          ),
        ],
      ],
    );
  }
}
