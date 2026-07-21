import 'package:flutter/material.dart';
import 'package:ssoss_flutter/common/widgets/text/app_text.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/constants/assets.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';

class SsossAccordion extends StatelessWidget {
  const SsossAccordion({
    required this.title,
    super.key,
    this.isOpen = false,
    this.showLeadingIcon = false,
    this.leading,
    this.onTap,
    this.titleColor,
    this.iconColor,
    this.leadingIconColor,
    this.backgroundColor,
    this.width,
  });

  final String title;
  final bool isOpen;
  final bool showLeadingIcon;
  final Widget? leading;
  final VoidCallback? onTap;
  final Color? titleColor;
  final Color? iconColor;
  final Color? leadingIconColor;
  final Color? backgroundColor;
  final double? width;

  static const double height = 47;
  static const double _trailingIconSize = 20;

  @override
  Widget build(BuildContext context) {
    final resolvedTitleColor = titleColor ?? AppColors.neutral800;
    final resolvedIconColor =
        iconColor ?? (isOpen ? AppColors.black : AppColors.neutral700);
    final titleTextStyle = showLeadingIcon || leading != null
        ? AppTextStyles.h8
        : AppTextStyles.h6;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
          width: width,
          height: height,
          child: Row(
            children: [
              if (showLeadingIcon || leading != null) ...[
                leading ?? _RefreshIcon(color: leadingIconColor),
                const SizedBox(width: 10),
              ],
              Expanded(
                child: AppText(
                  title,
                  style: titleTextStyle.copyWith(
                    color: resolvedTitleColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: _trailingIconSize,
                height: _trailingIconSize,
                child: Center(
                  child: SvgPicture.asset(
                    isOpen ? AppAssets.icChevronUp : AppAssets.icChevronDown,
                    width: _trailingIconSize,
                    height: _trailingIconSize,
                    colorFilter: ColorFilter.mode(
                      resolvedIconColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }
}

class _RefreshIcon extends StatelessWidget {
  const _RefreshIcon({
    required this.color,
  });

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 20,
      height: 20,
      child: Center(
        child: SvgPicture.asset(
          AppAssets.icRefresh,
          width: 15,
          height: 16,
          colorFilter: ColorFilter.mode(
            color ?? AppColors.black,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
