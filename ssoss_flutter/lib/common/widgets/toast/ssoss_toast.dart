import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/constants/assets.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';

enum SsossToastType {
  success,
  info,
  warning,
  error,
}

class SsossToast extends StatelessWidget {
  const SsossToast({
    required this.title,
    super.key,
    this.type = SsossToastType.success,
    this.caption,
    this.width,
    this.maxWidth = 320,
    this.showIcon = true,
    this.icon,
    this.backgroundColor,
    this.borderColor,
    this.titleColor,
    this.captionColor,
    this.padding,
    this.borderRadius,
    this.gap = 9,
    this.contentGap = 4,
    this.titleStyle,
    this.captionStyle,
  });

  final String title;
  final SsossToastType type;
  final String? caption;
  final double? width;
  final double maxWidth;
  final bool showIcon;
  final Widget? icon;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? titleColor;
  final Color? captionColor;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;
  final double gap;
  final double contentGap;
  final TextStyle? titleStyle;
  final TextStyle? captionStyle;

  bool get _hasCaption => caption != null && caption!.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final style = _ToastStyle.from(type);
    final resolvedBorderRadius = borderRadius ?? BorderRadius.circular(8);
    final resolvedTitleColor = titleColor ?? style.titleColor;
    final resolvedCaptionColor = captionColor ?? AppColors.neutral500;

    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: Container(
        width: width,
        padding: padding ?? const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: backgroundColor ?? style.backgroundColor,
          borderRadius: resolvedBorderRadius,
          border: Border.all(color: borderColor ?? style.borderColor),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (showIcon) ...[
              SizedBox.square(
                dimension: 20,
                child: Center(
                  child: icon ??
                      SvgPicture.asset(
                        style.iconAsset,
                        width: 20,
                        height: 20,
                      ),
                ),
              ),
              SizedBox(width: gap),
            ],
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: (titleStyle ?? AppTextStyles.h8).copyWith(
                      color: resolvedTitleColor,
                      decoration: TextDecoration.none,
                      decorationColor: Colors.transparent,
                    ),
                  ),
                  if (_hasCaption) ...[
                    SizedBox(height: contentGap),
                    Text(
                      caption!,
                      style: (captionStyle ?? AppTextStyles.b6).copyWith(
                        color: resolvedCaptionColor,
                        decoration: TextDecoration.none,
                        decorationColor: Colors.transparent,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void showSsossToast(
  BuildContext context, {
  required String title,
  SsossToastType type = SsossToastType.success,
  String? caption,
  Duration duration = const Duration(seconds: 2),
  Alignment alignment = Alignment.bottomCenter,
  EdgeInsetsGeometry margin = const EdgeInsets.only(bottom: 88),
  double maxWidth = 320,
}) {
  final overlay = Overlay.of(context, rootOverlay: true);
  late final OverlayEntry entry;

  entry = OverlayEntry(
    builder: (context) {
      return _SsossToastOverlay(
        duration: duration,
        alignment: alignment,
        margin: margin,
        slideFromBottom: alignment.y >= 0,
        onDismissed: () => entry.remove(),
        child: SsossToast(
          title: title,
          type: type,
          caption: caption,
          maxWidth: maxWidth,
        ),
      );
    },
  );

  overlay.insert(entry);
}

class _SsossToastOverlay extends StatefulWidget {
  const _SsossToastOverlay({
    required this.child,
    required this.duration,
    required this.alignment,
    required this.margin,
    required this.slideFromBottom,
    required this.onDismissed,
  });

  final Widget child;
  final Duration duration;
  final Alignment alignment;
  final EdgeInsetsGeometry margin;
  final bool slideFromBottom;
  final VoidCallback onDismissed;

  @override
  State<_SsossToastOverlay> createState() => _SsossToastOverlayState();
}

class _SsossToastOverlayState extends State<_SsossToastOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacity;
  late final Animation<Offset> _offset;
  var _isDismissing = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 180),
      reverseDuration: const Duration(milliseconds: 160),
    );
    _opacity = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
      reverseCurve: Curves.easeIn,
    );
    _offset = Tween<Offset>(
      begin: Offset(0, widget.slideFromBottom ? 0.12 : -0.12),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    unawaited(_controller.forward());
    unawaited(Future<void>.delayed(widget.duration, _dismiss));
  }

  Future<void> _dismiss() async {
    if (!mounted || _isDismissing) {
      return;
    }

    _isDismissing = true;
    await _controller.reverse();

    if (mounted) {
      widget.onDismissed();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: IgnorePointer(
        child: SafeArea(
          child: Align(
            alignment: widget.alignment,
            child: Padding(
              padding: widget.margin,
              child: DefaultTextStyle(
                style: DefaultTextStyle.of(context).style.copyWith(
                      decoration: TextDecoration.none,
                      decorationColor: Colors.transparent,
                    ),
                child: FadeTransition(
                  opacity: _opacity,
                  child: SlideTransition(
                    position: _offset,
                    child: Material(
                      type: MaterialType.transparency,
                      child: widget.child,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ToastStyle {
  const _ToastStyle({
    required this.iconAsset,
    required this.backgroundColor,
    required this.borderColor,
    required this.titleColor,
  });

  final String iconAsset;
  final Color backgroundColor;
  final Color borderColor;
  final Color titleColor;

  static _ToastStyle from(SsossToastType type) {
    switch (type) {
      case SsossToastType.success:
        return const _ToastStyle(
          iconAsset: AppAssets.icToastSuccess,
          backgroundColor: AppColors.success50,
          borderColor: AppColors.success500,
          titleColor: AppColors.success700,
        );
      case SsossToastType.info:
        return const _ToastStyle(
          iconAsset: AppAssets.icToastInfo,
          backgroundColor: AppColors.info50,
          borderColor: AppColors.info500,
          titleColor: AppColors.info700,
        );
      case SsossToastType.warning:
        return const _ToastStyle(
          iconAsset: AppAssets.icToastWarning,
          backgroundColor: AppColors.warning50,
          borderColor: AppColors.warning500,
          titleColor: AppColors.warning700,
        );
      case SsossToastType.error:
        return const _ToastStyle(
          iconAsset: AppAssets.icToastError,
          backgroundColor: AppColors.error50,
          borderColor: AppColors.error500,
          titleColor: AppColors.error700,
        );
    }
  }
}
