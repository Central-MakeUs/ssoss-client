import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:ssoss_flutter/common/widgets/input/ssoss_focused_input_scroller.dart';
import 'package:ssoss_flutter/common/widgets/input/ssoss_max_length_formatter.dart';
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
    this.maxLength,
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

  /// 최대 글자 수. null이거나 0 이하면 제한하지 않는다.
  /// 붙여넣기가 한도를 넘으면 잘라 넣고 경고 토스트를 띄운다.
  final int? maxLength;
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

  /// trim 길이가 [minLength] 이상 [maxLength] 이하인지 검사한다.
  /// [minLength]/[maxLength]가 0 이하면 해당 쪽은 검사하지 않는다.
  static bool isWithinLength(
    String text, {
    int minLength = 0,
    int maxLength = 0,
  }) {
    final length = text.trim().length;
    if (minLength > 0 && length < minLength) {
      return false;
    }
    if (maxLength > 0 && length > maxLength) {
      return false;
    }
    return true;
  }

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
  late final SsossMaxLengthFormatter _maxLengthFormatter;
  late final SsossFocusedInputScroller _focusedInputScroller;
  TextEditingController? _boundController;
  int _lastKnownLength = 0;
  bool _hasFocus = false;

  @override
  void initState() {
    super.initState();
    _ownsFocusNode = widget.focusNode == null;
    _focusNode = widget.focusNode ?? FocusNode();
    _hasFocus = _focusNode.hasFocus;
    _focusNode.addListener(_handleFocusChange);
    _maxLengthFormatter = SsossMaxLengthFormatter(
      widget.maxLength ?? 0,
      onTruncatedPaste: _onTruncatedPaste,
    );
    _focusedInputScroller = SsossFocusedInputScroller(
      isFocused: () => _focusNode.hasFocus,
    )..attach(context);
    _bindController(widget.controller);
  }

  @override
  void didUpdateWidget(covariant SsossTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.maxLength != widget.maxLength) {
      _maxLengthFormatter.maxLength = widget.maxLength ?? 0;
    }
    if (oldWidget.controller != widget.controller) {
      _bindController(widget.controller);
    }
  }

  @override
  void dispose() {
    _focusedInputScroller.detach();
    _boundController?.removeListener(_onControllerChanged);
    _focusNode.removeListener(_handleFocusChange);
    if (_ownsFocusNode) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  void _bindController(TextEditingController? controller) {
    _boundController?.removeListener(_onControllerChanged);
    _boundController = controller;
    _lastKnownLength = controller?.text.length ?? 0;
    _boundController?.addListener(_onControllerChanged);
  }

  void _onControllerChanged() {
    final maxLength = widget.maxLength ?? 0;
    final controller = _boundController;
    if (controller == null || maxLength <= 0) {
      _lastKnownLength = controller?.text.length ?? 0;
      return;
    }
    if (controller.text.length <= maxLength) {
      _lastKnownLength = controller.text.length;
      return;
    }

    final shouldNotify = isSsossLikelyTruncatedPasteByGrowth(
      oldLength: _lastKnownLength,
      newLength: controller.text.length,
      isComposing: controller.value.composing.isValid,
    );
    final truncated = controller.text.substring(0, maxLength);
    controller.value = TextEditingValue(
      text: truncated,
      selection: TextSelection.collapsed(offset: truncated.length),
    );
    if (shouldNotify) {
      showSsossMaxLengthPasteTruncatedToast(context);
    }
    _lastKnownLength = truncated.length;
  }

  void _handleFocusChange() {
    final hasFocus = _focusNode.hasFocus;
    if (_hasFocus != hasFocus) {
      setState(() {
        _hasFocus = hasFocus;
      });
    }
    if (hasFocus) {
      _focusedInputScroller.onFocusGained();
    }
  }

  void _unfocusIfNeeded() {
    if (_focusNode.hasFocus) {
      _focusNode.unfocus();
    }
  }

  void _onTruncatedPaste() {
    showSsossMaxLengthPasteTruncatedToast(context);
  }

  List<TextInputFormatter> get _inputFormatters {
    final maxLength = widget.maxLength ?? 0;
    return [
      if (maxLength > 0) _maxLengthFormatter,
      ...?widget.inputFormatters,
    ];
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
    final fillExplicitMultilineHeight =
        widget.multiline && widget.height != null;
    final expands = widget.expands || fillExplicitMultilineHeight;
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
      inputFormatters: _inputFormatters,
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmitted,
      onTapOutside: (_) => _unfocusIfNeeded(),
      scrollPadding: EdgeInsets.zero,
      minLines: expands ? null : (widget.multiline ? widget.minLines : null),
      maxLines: expands ? null : (widget.multiline ? widget.maxLines : 1),
      textAlignVertical:
          widget.multiline ? TextAlignVertical.top : TextAlignVertical.center,
      cursorColor: widget.hasError
          ? resolvedErrorColor
          : widget.focusedBorderColor ?? AppColors.primary400,
      style: textStyle.copyWith(
        color: resolvedTextColor,
      ),
      expands: expands,
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
      child: widget.multiline && widget.height == null
          ? ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: SsossTextField.defaultHeight,
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
