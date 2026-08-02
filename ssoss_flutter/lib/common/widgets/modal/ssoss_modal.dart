import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ssoss_flutter/common/widgets/text/app_text.dart';

import 'package:ssoss_flutter/common/widgets/button/ssoss_button.dart';
import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/constants/assets.dart';
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
    this.content,
    this.onClose,
    this.primaryButtonLabel = 'Button',
    this.primaryButtonColor = AppColors.primary400,
    this.primaryButtonTextColor = AppColors.white,
    this.secondaryButtonLabel = 'Button',
    this.secondaryButtonColor = AppColors.neutral100,
    this.secondaryButtonTextColor = AppColors.black,
    this.onPrimaryPressed,
    this.onSecondaryPressed,
    this.showButtonIcons = true,
    this.showCloseButton = true,
    this.showSecondaryButton = true,
    this.isPrimaryLoading = false,
    this.isActionsDisabled = false,
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
    this.contentGap = 20,
    this.actionGap = 8,
    this.titleStyle,
    this.messageStyle,
  });

  final String title;
  final String? message;
  /// 타이틀·메시지와 액션 버튼 사이에 들어가는 커스텀 본문.
  final Widget? content;
  final VoidCallback? onClose;
  final String primaryButtonLabel;
  final Color primaryButtonColor;
  final Color primaryButtonTextColor;
  final String secondaryButtonLabel;
  final Color secondaryButtonColor;
  final Color secondaryButtonTextColor;
  final VoidCallback? onPrimaryPressed;
  final VoidCallback? onSecondaryPressed;
  final bool showButtonIcons;
  final bool showCloseButton;
  final bool showSecondaryButton;
  final bool isPrimaryLoading;
  final bool isActionsDisabled;
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
  final double contentGap;
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
          EdgeInsets.fromLTRB(
            16,
            showCloseButton ? 16 : 18,
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
            onClose: isActionsDisabled ? null : onClose,
            showCloseButton: showCloseButton,
            titleColor: titleColor ?? AppColors.neutral800,
            messageColor: messageColor ?? AppColors.neutral400,
            closeIconColor: closeIconColor ?? AppColors.neutral400,
            headerGap: headerGap,
            messageGap: messageGap,
            titleStyle: titleStyle,
            messageStyle: messageStyle,
          ),
          if (content != null) ...[
            SizedBox(height: contentGap),
            content!,
          ],
          SizedBox(height: gap),
          actions ?? _buildDefaultActions(),
        ],
      ),
    );
  }

  Widget _buildDefaultActions() {
    final actionsEnabled = !isActionsDisabled;

    final primaryButton = SsossButton(
      label: primaryButtonLabel,
      backgroundColor: primaryButtonColor,
      foregroundColor: primaryButtonTextColor,
      size: SsossButtonSize.medium,
      type: SsossButtonType.primary,
      width: double.infinity,
      enabled: actionsEnabled,
      isLoading: isPrimaryLoading,
      onPressed: actionsEnabled ? onPrimaryPressed : null,
      showLeftIcon: showButtonIcons,
      showRightIcon: showButtonIcons,
    );

    if (!showSecondaryButton) {
      return primaryButton;
    }

    return Row(
      children: [
        Expanded(
          child: SsossButton(
            label: secondaryButtonLabel,
            backgroundColor: secondaryButtonColor,
            foregroundColor: secondaryButtonTextColor,
            size: SsossButtonSize.medium,
            type: SsossButtonType.neutral,
            width: double.infinity,
            enabled: actionsEnabled,
            onPressed: actionsEnabled ? onSecondaryPressed : null,
            showLeftIcon: showButtonIcons,
            showRightIcon: showButtonIcons,
          ),
        ),
        SizedBox(width: actionGap),
        Expanded(child: primaryButton),
      ],
    );
  }
}

Future<SsossModalResult?> showSsossModal(
  BuildContext context, {
  required String title,
  String? message,
  Widget? content,
  String primaryButtonLabel = 'Button',
  Color primaryButtonColor = AppColors.primary400,
  Color primaryButtonTextColor = AppColors.white,
  String secondaryButtonLabel = 'Button',
  Color secondaryButtonColor = AppColors.neutral100,
  Color secondaryButtonTextColor = AppColors.black,
  VoidCallback? onPrimaryPressed,
  VoidCallback? onSecondaryPressed,
  Future<void> Function()? onPrimaryPressedAsync,
  VoidCallback? onClose,
  bool showButtonIcons = true,
  bool showCloseButton = true,
  bool showSecondaryButton = true,
  bool dismissOnPrimaryPressed = true,
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
  double contentGap = 20,
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

      Widget buildModal({
        required Color primaryButtonColor,
        required Color secondaryButtonColor,
        required Color primaryButtonTextColor,
        required Color secondaryButtonTextColor,
        required bool isPrimaryLoading,
        required bool isActionsDisabled,
        required VoidCallback? onPrimaryTap,
        required VoidCallback? onSecondaryTap,
        required VoidCallback? onCloseTap,
      }) {
        return SsossModal(
          title: title,
          message: message,
          content: content,
          primaryButtonLabel: primaryButtonLabel,
          primaryButtonColor: primaryButtonColor,
          primaryButtonTextColor: primaryButtonTextColor,
          secondaryButtonLabel: secondaryButtonLabel,
          secondaryButtonColor: secondaryButtonColor,
          secondaryButtonTextColor: secondaryButtonTextColor,
          showButtonIcons: showButtonIcons,
          showCloseButton: showCloseButton,
          showSecondaryButton: showSecondaryButton,
          isPrimaryLoading: isPrimaryLoading,
          isActionsDisabled: isActionsDisabled,
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
          contentGap: contentGap,
          actionGap: actionGap,
          titleStyle: titleStyle,
          messageStyle: messageStyle,
          onClose: onCloseTap,
          onPrimaryPressed: onPrimaryTap,
          onSecondaryPressed: onSecondaryTap,
        );
      }

      Widget modal;

      if (onPrimaryPressedAsync != null) {
        var isPrimaryLoading = false;
        var isActionsDisabled = false;

        modal = StatefulBuilder(
          builder: (context, setState) {
            Future<void> handlePrimaryPressed() async {
              setState(() {
                isPrimaryLoading = true;
                isActionsDisabled = true;
              });

              try {
                await onPrimaryPressedAsync();
                if (!dialogContext.mounted) {
                  return;
                }
                dismiss(SsossModalResult.primary);
                onPrimaryPressed?.call();
              } catch (_) {
                if (!dialogContext.mounted) {
                  return;
                }
                setState(() {
                  isPrimaryLoading = false;
                  isActionsDisabled = false;
                });
                rethrow;
              }
            }

            return buildModal(
              primaryButtonColor: primaryButtonColor,
              secondaryButtonColor: secondaryButtonColor,
              primaryButtonTextColor: primaryButtonTextColor,
              secondaryButtonTextColor: secondaryButtonTextColor,
              isPrimaryLoading: isPrimaryLoading,
              isActionsDisabled: isActionsDisabled,
              onPrimaryTap: isActionsDisabled ? null : handlePrimaryPressed,
              onSecondaryTap: isActionsDisabled
                  ? null
                  : () {
                      dismiss(SsossModalResult.secondary);
                      onSecondaryPressed?.call();
                    },
              onCloseTap: isActionsDisabled
                  ? null
                  : () {
                      dismiss();
                      onClose?.call();
                    },
            );
          },
        );
      } else {
        modal = buildModal(
          primaryButtonColor: primaryButtonColor,
          secondaryButtonColor: secondaryButtonColor,
          primaryButtonTextColor: primaryButtonTextColor,
          secondaryButtonTextColor: secondaryButtonTextColor,
          isPrimaryLoading: false,
          isActionsDisabled: false,
          onPrimaryTap: () {
            if (dismissOnPrimaryPressed) {
              dismiss(SsossModalResult.primary);
            }
            onPrimaryPressed?.call();
          },
          onSecondaryTap: () {
            dismiss(SsossModalResult.secondary);
            onSecondaryPressed?.call();
          },
          onCloseTap: () {
            dismiss();
            onClose?.call();
          },
        );
      }

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
    required this.showCloseButton,
    this.onClose,
    this.titleStyle,
    this.messageStyle,
  });

  final String title;
  final String? message;
  final bool hasMessage;
  final VoidCallback? onClose;
  final bool showCloseButton;
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
        if (showCloseButton)
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: onClose,
              behavior: HitTestBehavior.opaque,
              child: SvgPicture.asset(
                AppAssets.icClose,
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(
                  closeIconColor,
                  BlendMode.srcIn,
                ),
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
