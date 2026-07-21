import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/constants/assets.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';

class SsossTextField extends StatelessWidget {
  const SsossTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.hintText = '입력해주세요',
    this.showSearchIcon = false,
    this.enabled = true,
    this.readOnly = false,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.onChanged,
    this.onSubmitted,
    this.borderColor,
    this.focusedBorderColor,
    this.errorBorderColor,
    this.disabledBorderColor,
    this.fillColor,
    this.disabledFillColor,
    this.textColor,
    this.hintColor,
    this.searchIconColor,
    this.width,
    this.height,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String hintText;
  final bool showSearchIcon;
  final bool enabled;
  final bool readOnly;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? errorBorderColor;
  final Color? disabledBorderColor;
  final Color? fillColor;
  final Color? disabledFillColor;
  final Color? textColor;
  final Color? hintColor;
  final Color? searchIconColor;
  final double? width;
  final double? height;

  static const double defaultHeight = 40;
  static const double _borderRadius = 8;

  @override
  Widget build(BuildContext context) {
    final resolvedTextColor = textColor ?? AppColors.neutral800;
    final resolvedHintColor = hintColor ?? AppColors.neutral400;
    final resolvedIconColor = searchIconColor ?? AppColors.neutral700;
    final resolvedFillColor = enabled
        ? fillColor ?? AppColors.white
        : disabledFillColor ?? AppColors.neutral50;
    final textStyle = showSearchIcon ? AppTextStyles.b5 : AppTextStyles.b4;

    return SizedBox(
      width: width,
      height: height ?? defaultHeight,
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        enabled: enabled,
        readOnly: readOnly,
        obscureText: obscureText,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        inputFormatters: inputFormatters,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        cursorColor: focusedBorderColor ?? AppColors.primary400,
        style: textStyle.copyWith(
          color: resolvedTextColor,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: textStyle.copyWith(
            color: resolvedHintColor,
          ),
          filled: true,
          fillColor: resolvedFillColor,
          isDense: true,
          contentPadding: EdgeInsets.symmetric(
            horizontal: showSearchIcon ? 0 : 14,
            vertical: 10,
          ),
          prefixIcon: showSearchIcon
              ? Padding(
                  padding: const EdgeInsets.only(left: 14, right: 10),
                  child: SvgPicture.asset(
                    AppAssets.icSearch,
                    width: 24,
                    height: 24,
                    colorFilter: ColorFilter.mode(
                      resolvedIconColor,
                      BlendMode.srcIn,
                    ),
                  ),
                )
              : null,
          prefixIconConstraints: showSearchIcon
              ? const BoxConstraints(
                  minWidth: 48,
                  minHeight: 24,
                )
              : null,
          border: _border(borderColor ?? AppColors.neutral200),
          enabledBorder: _border(borderColor ?? AppColors.neutral200),
          focusedBorder: _border(focusedBorderColor ?? AppColors.neutral600),
          errorBorder: _border(errorBorderColor ?? AppColors.error500),
          focusedErrorBorder: _border(errorBorderColor ?? AppColors.error500),
          disabledBorder: _border(disabledBorderColor ?? AppColors.neutral200),
        ),
      ),
    );
  }

  OutlineInputBorder _border(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(_borderRadius),
      borderSide: BorderSide(color: color),
    );
  }
}
