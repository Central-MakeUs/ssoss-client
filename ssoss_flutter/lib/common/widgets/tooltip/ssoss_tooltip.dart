import 'package:flutter/material.dart';
import 'package:ssoss_flutter/common/widgets/text/app_text.dart';

import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';

enum SsossTooltipDirection {
  up,
  down,
  left,
  right,
}

class SsossTooltip extends StatelessWidget {
  const SsossTooltip({
    required this.message,
    super.key,
    this.direction = SsossTooltipDirection.up,
    this.backgroundColor = AppColors.white,
    this.textColor = AppColors.neutral800,
    this.padding,
    this.borderRadius,
    this.tailSize = const Size(14, 8),
    this.textStyle,
    this.boxShadow,
  });

  final String message;
  final SsossTooltipDirection direction;
  final Color backgroundColor;
  final Color textColor;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;
  final Size tailSize;
  final TextStyle? textStyle;
  final List<BoxShadow>? boxShadow;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: _stackAlignment,
      children: [
        Container(
          padding: padding ??
              const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: borderRadius ?? BorderRadius.circular(12),
            border: Border.all(color: backgroundColor),
            boxShadow: boxShadow ??
                const [
                  BoxShadow(
                    color: Color(0x1F171717),
                    blurRadius: 5,
                  ),
                ],
          ),
          child: AppText(
            message,
            style: (textStyle ?? AppTextStyles.b5).copyWith(
              color: textColor,
            ),
          ),
        ),
        Positioned(
          left: _tailLeft,
          right: _tailRight,
          top: _tailTop,
          bottom: _tailBottom,
          child: CustomPaint(
            size: _resolvedTailSize,
            painter: _TooltipTailPainter(
              color: backgroundColor,
              direction: direction,
            ),
          ),
        ),
      ],
    );
  }

  Alignment get _stackAlignment {
    switch (direction) {
      case SsossTooltipDirection.up:
        return Alignment.bottomCenter;
      case SsossTooltipDirection.down:
        return Alignment.topCenter;
      case SsossTooltipDirection.left:
        return Alignment.centerRight;
      case SsossTooltipDirection.right:
        return Alignment.centerLeft;
    }
  }

  Size get _resolvedTailSize {
    switch (direction) {
      case SsossTooltipDirection.up:
      case SsossTooltipDirection.down:
        return tailSize;
      case SsossTooltipDirection.left:
      case SsossTooltipDirection.right:
        return Size(tailSize.height, tailSize.width);
    }
  }

  double? get _tailLeft {
    switch (direction) {
      case SsossTooltipDirection.right:
        return -tailSize.height + 1;
      case SsossTooltipDirection.up:
      case SsossTooltipDirection.down:
      case SsossTooltipDirection.left:
        return null;
    }
  }

  double? get _tailRight {
    switch (direction) {
      case SsossTooltipDirection.left:
        return -tailSize.height + 1;
      case SsossTooltipDirection.up:
      case SsossTooltipDirection.down:
      case SsossTooltipDirection.right:
        return null;
    }
  }

  double? get _tailTop {
    switch (direction) {
      case SsossTooltipDirection.down:
        return -tailSize.height + 1;
      case SsossTooltipDirection.up:
      case SsossTooltipDirection.left:
      case SsossTooltipDirection.right:
        return null;
    }
  }

  double? get _tailBottom {
    switch (direction) {
      case SsossTooltipDirection.up:
        return -tailSize.height + 1;
      case SsossTooltipDirection.down:
      case SsossTooltipDirection.left:
      case SsossTooltipDirection.right:
        return null;
    }
  }
}

class _TooltipTailPainter extends CustomPainter {
  const _TooltipTailPainter({
    required this.color,
    required this.direction,
  });

  final Color color;
  final SsossTooltipDirection direction;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    final path = Path();

    switch (direction) {
      case SsossTooltipDirection.up:
        path
          ..moveTo(0, 0)
          ..lineTo(size.width / 2, size.height)
          ..lineTo(size.width, 0);
      case SsossTooltipDirection.down:
        path
          ..moveTo(0, size.height)
          ..lineTo(size.width / 2, 0)
          ..lineTo(size.width, size.height);
      case SsossTooltipDirection.left:
        path
          ..moveTo(0, 0)
          ..lineTo(size.width, size.height / 2)
          ..lineTo(0, size.height);
      case SsossTooltipDirection.right:
        path
          ..moveTo(size.width, 0)
          ..lineTo(0, size.height / 2)
          ..lineTo(size.width, size.height);
    }

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _TooltipTailPainter oldDelegate) {
    return color != oldDelegate.color || direction != oldDelegate.direction;
  }
}
