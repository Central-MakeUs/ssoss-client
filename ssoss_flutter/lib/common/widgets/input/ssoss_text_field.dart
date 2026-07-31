import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/constants/assets.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';

class SsossTextField extends StatefulWidget {
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
  static const List<BoxShadow> _focusedShadow = [
    BoxShadow(
      color: Color(0x4DFF9E70),
      blurRadius: 3,
    ),
  ];

  @override
  State<SsossTextField> createState() => _SsossTextFieldState();
}

class _SsossTextFieldState extends State<SsossTextField> {
  late final FocusNode _focusNode;
  late final bool _ownsFocusNode;
  bool _hasFocus = false;

  @override
  void initState() {
    super.initState();
    _ownsFocusNode = widget.focusNode == null;
    _focusNode = widget.focusNode ?? FocusNode();
    _hasFocus = _focusNode.hasFocus;
    _focusNode.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    if (_ownsFocusNode) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  void _handleFocusChange() {
    if (_hasFocus == _focusNode.hasFocus) {
      return;
    }
    setState(() {
      _hasFocus = _focusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    final resolvedTextColor = widget.textColor ?? AppColors.neutral800;
    final resolvedHintColor = widget.hintColor ?? AppColors.neutral400;
    final resolvedIconColor = widget.searchIconColor ?? AppColors.neutral700;
    final resolvedFillColor = widget.enabled
        ? widget.fillColor ?? AppColors.white
        : widget.disabledFillColor ?? AppColors.neutral50;
    final textStyle = AppTextStyles.b4;
    final resolvedHeight = widget.height ?? SsossTextField.defaultHeight;
    final resolvedErrorColor = widget.errorBorderColor ?? AppColors.error500;
    final resolvedBorderColor = widget.hasError
        ? resolvedErrorColor
        : widget.borderColor ?? AppColors.neutral200;
    final resolvedFocusedBorderColor = widget.hasError
        ? resolvedErrorColor
        : widget.focusedBorderColor ?? AppColors.primary200;
    final showFocusedShadow = _hasFocus && !widget.hasError && widget.enabled;

    final textField = TextField(
      controller: widget.controller,
      focusNode: _focusNode,
      enabled: widget.enabled,
      readOnly: widget.readOnly,
      obscureText: widget.multiline ? false : widget.obscureText,
      keyboardType: widget.keyboardType ??
          (widget.multiline ? TextInputType.multiline : null),
      textInputAction: widget.textInputAction ??
          (widget.multiline ? TextInputAction.newline : null),
      inputFormatters: widget.inputFormatters,
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmitted,
      onTapOutside: (_) {
        _focusNode.unfocus();
      },
      minLines: widget.multiline ? widget.minLines : null,
      maxLines: widget.multiline ? widget.maxLines : 1,
      textAlignVertical:
          widget.multiline ? TextAlignVertical.top : TextAlignVertical.center,
      cursorColor: widget.hasError
          ? resolvedErrorColor
          : widget.focusedBorderColor ?? AppColors.primary400,
      style: textStyle.copyWith(
        color: resolvedTextColor,
      ),
      expands: widget.expands,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: textStyle.copyWith(
          color: resolvedHintColor,
        ),
        filled: true,
        fillColor: resolvedFillColor,
        isDense: true,
        contentPadding: EdgeInsets.symmetric(
          horizontal:
              widget.showSearchIcon || widget.showLoadingIndicator ? 0 : 14,
          vertical: 10,
        ),
        prefixIcon: widget.showSearchIcon
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
        prefixIconConstraints: widget.showSearchIcon
            ? const BoxConstraints(
                minWidth: 48,
                minHeight: 24,
              )
            : null,
        suffixIcon: widget.showLoadingIndicator
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
        suffixIconConstraints: widget.showLoadingIndicator
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
        disabledBorder:
            _border(widget.disabledBorderColor ?? AppColors.neutral200),
      ),
    );

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SsossTextField._borderRadius),
        boxShadow: showFocusedShadow ? SsossTextField._focusedShadow : null,
      ),
      child: widget.multiline
          ? ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: resolvedHeight,
                minWidth: widget.width ?? 0,
                maxWidth: widget.width ?? double.infinity,
              ),
              child: textField,
            )
          : SizedBox(
              width: widget.width,
              height: resolvedHeight,
              child: textField,
            ),
    );
  }

  OutlineInputBorder _border(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(SsossTextField._borderRadius),
      borderSide: BorderSide(color: color),
    );
  }
}
