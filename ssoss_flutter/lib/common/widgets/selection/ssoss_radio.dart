import 'package:flutter/material.dart';
import 'package:ssoss_flutter/common/widgets/text/app_text.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/constants/assets.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';

class SsossRadio extends StatelessWidget {
  const SsossRadio({
    required this.isChecked,
    super.key,
    this.isDisabled = false,
    this.label,
    this.onTap,
    this.iconSize = 20,
    this.gap = 8,
    this.labelColor,
    this.disabledLabelColor,
    this.textStyle,
  });

  final bool isChecked;
  final bool isDisabled;
  final String? label;
  final VoidCallback? onTap;
  final double iconSize;
  final double gap;
  final Color? labelColor;
  final Color? disabledLabelColor;
  final TextStyle? textStyle;

  bool get _hasLabel => label != null && label!.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final resolvedLabelColor = isDisabled
        ? disabledLabelColor ?? AppColors.neutral400
        : labelColor ?? AppColors.neutral800;

    return Semantics(
      button: true,
      checked: isChecked,
      enabled: !isDisabled,
      label: label,
      child: GestureDetector(
        onTap: isDisabled ? null : onTap,
        behavior: HitTestBehavior.opaque,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              _assetPath,
              width: iconSize,
              height: iconSize,
            ),
            if (_hasLabel) ...[
              SizedBox(width: gap),
              AppText(
                label!,
                style: (textStyle ?? AppTextStyles.b5).copyWith(
                  color: resolvedLabelColor,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String get _assetPath {
    if (isChecked && isDisabled) {
      return AppAssets.icRadioCheckedDisabled;
    }

    if (isChecked) {
      return AppAssets.icRadioChecked;
    }

    if (isDisabled) {
      return AppAssets.icRadioUncheckedDisabled;
    }

    return AppAssets.icRadioUnchecked;
  }
}
