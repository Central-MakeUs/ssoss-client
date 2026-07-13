import 'package:flutter/material.dart';
import 'package:ssoss_flutter/common/widgets/text/app_text.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/constants/assets.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';

class SsossSelectField extends StatelessWidget {
  const SsossSelectField({
    super.key,
    this.value,
    this.placeholder = 'Value',
    this.isOpen = false,
    this.enabled = true,
    this.onTap,
    this.borderColor,
    this.fillColor,
    this.disabledBorderColor,
    this.disabledFillColor,
    this.valueColor,
    this.placeholderColor,
    this.iconColor,
    this.width,
  });

  final String? value;
  final String placeholder;
  final bool isOpen;
  final bool enabled;
  final VoidCallback? onTap;
  final Color? borderColor;
  final Color? fillColor;
  final Color? disabledBorderColor;
  final Color? disabledFillColor;
  final Color? valueColor;
  final Color? placeholderColor;
  final Color? iconColor;
  final double? width;

  static const double height = 40;
  static const double _borderRadius = 8;

  bool get _hasValue => value != null && value!.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final resolvedBorderColor = enabled
        ? borderColor ?? AppColors.neutral200
        : disabledBorderColor ?? AppColors.neutral200;
    final resolvedFillColor = enabled
        ? fillColor ?? AppColors.white
        : disabledFillColor ?? AppColors.neutral50;
    final resolvedTextColor = _hasValue
        ? valueColor ?? AppColors.neutral800
        : placeholderColor ?? AppColors.neutral500;
    final resolvedIconColor = iconColor ??
        (enabled
            ? isOpen
                ? AppColors.black
                : AppColors.neutral700
            : AppColors.neutral400);

    return Semantics(
      button: true,
      enabled: enabled,
      value: _hasValue ? value : null,
      child: InkWell(
        onTap: enabled ? onTap : null,
        borderRadius: BorderRadius.circular(_borderRadius),
        child: Container(
          width: width,
          height: height,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: resolvedFillColor,
            borderRadius: BorderRadius.circular(_borderRadius),
            border: Border.all(color: resolvedBorderColor),
          ),
          child: Row(
            children: [
              Expanded(
                child: AppText(
                  _hasValue ? value! : placeholder,
                  style: AppTextStyles.b5.copyWith(
                    color: resolvedTextColor,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              SvgPicture.asset(
                isOpen ? AppAssets.icChevronUp : AppAssets.icChevronDown,
                width: 20,
                height: 20,
                colorFilter: ColorFilter.mode(
                  resolvedIconColor,
                  BlendMode.srcIn,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
