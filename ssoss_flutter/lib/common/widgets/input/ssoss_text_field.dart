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
    this.showLoadingIndicator = false,
    this.hasError = false,
    this.enabled = true,
    this.readOnly = false,
    this.obscureText = false,
    this.multiline = false,
    this.expands = false,
    this.minLines = 1,
    this.maxLines,
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
  final bool showLoadingIndicator;
  final bool hasError;
  final bool enabled;
  final bool readOnly;
  final bool obscureText;
  final bool multiline;
  final bool expands;
  final int? minLines;
  final int? maxLines;
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

  static const double defaultHeight = 44;
  static const double _borderRadius = 8;

  @override
  Widget build(BuildContext context) {
    final resolvedTextColor = textColor ?? AppColors.neutral800;
    final resolvedHintColor = hintColor ?? AppColors.neutral400;
    final resolvedIconColor = searchIconColor ?? AppColors.neutral700;
    final resolvedFillColor = enabled
        ? fillColor ?? AppColors.white
        : disabledFillColor ?? AppColors.neutral50;
    final textStyle = AppTextStyles.b4;
    final resolvedHeight = height ?? defaultHeight;
    final resolvedErrorColor = errorBorderColor ?? AppColors.error500;
    final resolvedBorderColor =
        hasError ? resolvedErrorColor : borderColor ?? AppColors.neutral200;
    final resolvedFocusedBorderColor = hasError
        ? resolvedErrorColor
        : focusedBorderColor ?? AppColors.neutral600;

    final textField = TextField(
      controller: controller,
      focusNode: focusNode,
      enabled: enabled,
      readOnly: readOnly,
      obscureText: multiline ? false : obscureText,
      keyboardType:
          keyboardType ?? (multiline ? TextInputType.multiline : null),
      textInputAction:
          textInputAction ?? (multiline ? TextInputAction.newline : null),
      inputFormatters: inputFormatters,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      onTapOutside: (_) {
        (focusNode ?? FocusManager.instance.primaryFocus)?.unfocus();
      },
      minLines: multiline ? minLines : null,
      maxLines: multiline ? maxLines : 1,
      textAlignVertical:
          multiline ? TextAlignVertical.top : TextAlignVertical.center,
      cursorColor: hasError
          ? resolvedErrorColor
          : focusedBorderColor ?? AppColors.primary400,
      style: textStyle.copyWith(
        color: resolvedTextColor,
      ),
      expands: expands,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: textStyle.copyWith(
          color: resolvedHintColor,
        ),
        filled: true,
        fillColor: resolvedFillColor,
        isDense: true,
        contentPadding: EdgeInsets.symmetric(
          horizontal: showSearchIcon || showLoadingIndicator ? 0 : 14,
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
        suffixIcon: showLoadingIndicator
            ? const Padding(
                padding: EdgeInsets.only(right: 14),
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.primary400,
                  ),
                ),
              )
            : null,
        suffixIconConstraints: showLoadingIndicator
            ? const BoxConstraints(
                minWidth: 34,
                minHeight: 20,
              )
            : null,
        border: _border(resolvedBorderColor),
        enabledBorder: _border(resolvedBorderColor),
        focusedBorder: _border(resolvedFocusedBorderColor),
        errorBorder: _border(resolvedErrorColor),
        focusedErrorBorder: _border(resolvedErrorColor),
        disabledBorder: _border(disabledBorderColor ?? AppColors.neutral200),
      ),
    );

    if (multiline) {
      return ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: resolvedHeight,
          minWidth: width ?? 0,
          maxWidth: width ?? double.infinity,
        ),
        child: textField,
      );
    }

    return SizedBox(
      width: width,
      height: resolvedHeight,
      child: textField,
    );
  }

  OutlineInputBorder _border(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(_borderRadius),
      borderSide: BorderSide(color: color),
    );
  }
}
