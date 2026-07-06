import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';

enum SsossContentsEditCardState {
  normal,
  hover,
  filled,
  pressed,
  error,
}

class SsossContentsEditCard extends StatefulWidget {
  const SsossContentsEditCard({
    super.key,
    this.controller,
    this.focusNode,
    this.state,
    this.hintText = '입력해주세요',
    this.maxLength = 40,
    this.enabled = true,
    this.readOnly = false,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.onChanged,
    this.onSubmitted,
    this.width = 343.5,
    this.minHeight = 129,
    this.padding,
    this.borderRadius,
    this.backgroundColor,
    this.borderColor,
    this.focusedBorderColor,
    this.errorBorderColor,
    this.textColor,
    this.hintColor,
    this.errorTextColor,
    this.counterColor,
    this.counterMutedColor,
    this.textStyle,
    this.counterStyle,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final SsossContentsEditCardState? state;
  final String hintText;
  final int maxLength;
  final bool enabled;
  final bool readOnly;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final double? width;
  final double minHeight;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? errorBorderColor;
  final Color? textColor;
  final Color? hintColor;
  final Color? errorTextColor;
  final Color? counterColor;
  final Color? counterMutedColor;
  final TextStyle? textStyle;
  final TextStyle? counterStyle;

  @override
  State<SsossContentsEditCard> createState() => _SsossContentsEditCardState();
}

class _SsossContentsEditCardState extends State<SsossContentsEditCard> {
  late final TextEditingController _internalController;
  late final FocusNode _internalFocusNode;

  TextEditingController get _controller =>
      widget.controller ?? _internalController;

  FocusNode get _focusNode => widget.focusNode ?? _internalFocusNode;

  @override
  void initState() {
    super.initState();
    _internalController = TextEditingController();
    _internalFocusNode = FocusNode();
    _controller.addListener(_handleTextChanged);
    _focusNode.addListener(_handleFocusChanged);
  }

  @override
  void didUpdateWidget(covariant SsossContentsEditCard oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.controller != widget.controller) {
      (oldWidget.controller ?? _internalController)
          .removeListener(_handleTextChanged);
      _controller.addListener(_handleTextChanged);
    }

    if (oldWidget.focusNode != widget.focusNode) {
      (oldWidget.focusNode ?? _internalFocusNode)
          .removeListener(_handleFocusChanged);
      _focusNode.addListener(_handleFocusChanged);
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_handleTextChanged);
    _focusNode.removeListener(_handleFocusChanged);
    _internalController.dispose();
    _internalFocusNode.dispose();
    super.dispose();
  }

  void _handleTextChanged() {
    setState(() {});
  }

  void _handleFocusChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final value = _controller.text;
    final state = widget.state ?? _resolveState(value);
    final style = _ContentsEditCardStyle.from(
      state,
      borderColor: widget.borderColor,
      focusedBorderColor: widget.focusedBorderColor,
      errorBorderColor: widget.errorBorderColor,
      textColor: widget.textColor,
      hintColor: widget.hintColor,
      errorTextColor: widget.errorTextColor,
    );
    final currentLength = value.characters.length;

    return Container(
      width: widget.width,
      constraints: BoxConstraints(minHeight: widget.minHeight),
      padding: widget.padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? AppColors.white,
        borderRadius: widget.borderRadius ?? BorderRadius.circular(12),
        border: Border.all(color: style.borderColor),
        boxShadow: state == SsossContentsEditCardState.pressed
            ? const [
                BoxShadow(
                  color: Color(0x4DFF9E70),
                  blurRadius: 3,
                ),
              ]
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _controller,
            focusNode: _focusNode,
            enabled: widget.enabled,
            readOnly: widget.readOnly,
            keyboardType: widget.keyboardType ?? TextInputType.multiline,
            textInputAction: widget.textInputAction,
            inputFormatters: [
              LengthLimitingTextInputFormatter(widget.maxLength),
              ...?widget.inputFormatters,
            ],
            maxLines: null,
            minLines: 2,
            onChanged: widget.onChanged,
            onSubmitted: widget.onSubmitted,
            cursorColor: widget.focusedBorderColor ?? AppColors.primary400,
            style: (widget.textStyle ?? AppTextStyles.b4).copyWith(
              color: style.textColor,
              letterSpacing: -0.16,
            ),
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: (widget.textStyle ?? AppTextStyles.b4).copyWith(
                color: style.hintColor,
                letterSpacing: -0.16,
              ),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.zero,
              counterText: '',
            ),
          ),
          const SizedBox(height: 36),
          _CounterText(
            current: currentLength,
            max: widget.maxLength,
            isError: state == SsossContentsEditCardState.error,
            currentColor: widget.counterColor ?? style.counterColor,
            mutedColor: widget.counterMutedColor ?? AppColors.neutral300,
            textStyle: widget.counterStyle,
          ),
        ],
      ),
    );
  }

  SsossContentsEditCardState _resolveState(String value) {
    if (_focusNode.hasFocus) {
      return SsossContentsEditCardState.pressed;
    }

    if (value.isNotEmpty) {
      return SsossContentsEditCardState.filled;
    }

    return SsossContentsEditCardState.normal;
  }
}

class _CounterText extends StatelessWidget {
  const _CounterText({
    required this.current,
    required this.max,
    required this.isError,
    required this.currentColor,
    required this.mutedColor,
    this.textStyle,
  });

  final int current;
  final int max;
  final bool isError;
  final Color currentColor;
  final Color mutedColor;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final baseStyle = textStyle ?? AppTextStyles.b6;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '$current',
          style: baseStyle.copyWith(
            color: isError ? AppColors.error500 : currentColor,
            letterSpacing: -0.12,
          ),
        ),
        Text(
          ' / ',
          style: baseStyle.copyWith(
            color: mutedColor,
            letterSpacing: -0.12,
          ),
        ),
        Text(
          '$max',
          style: baseStyle.copyWith(
            color: mutedColor,
            letterSpacing: -0.12,
          ),
        ),
      ],
    );
  }
}

class _ContentsEditCardStyle {
  const _ContentsEditCardStyle({
    required this.borderColor,
    required this.textColor,
    required this.hintColor,
    required this.counterColor,
  });

  final Color borderColor;
  final Color textColor;
  final Color hintColor;
  final Color counterColor;

  static _ContentsEditCardStyle from(
    SsossContentsEditCardState state, {
    Color? borderColor,
    Color? focusedBorderColor,
    Color? errorBorderColor,
    Color? textColor,
    Color? hintColor,
    Color? errorTextColor,
  }) {
    switch (state) {
      case SsossContentsEditCardState.normal:
        return _ContentsEditCardStyle(
          borderColor: borderColor ?? AppColors.neutral200,
          textColor: textColor ?? AppColors.neutral700,
          hintColor: hintColor ?? AppColors.neutral400,
          counterColor: AppColors.neutral700,
        );
      case SsossContentsEditCardState.hover:
        return _ContentsEditCardStyle(
          borderColor: focusedBorderColor ?? AppColors.neutral600,
          textColor: textColor ?? AppColors.neutral700,
          hintColor: hintColor ?? AppColors.neutral400,
          counterColor: AppColors.neutral700,
        );
      case SsossContentsEditCardState.filled:
        return _ContentsEditCardStyle(
          borderColor: borderColor ?? AppColors.neutral200,
          textColor: textColor ?? AppColors.neutral700,
          hintColor: hintColor ?? AppColors.neutral400,
          counterColor: AppColors.neutral700,
        );
      case SsossContentsEditCardState.pressed:
        return _ContentsEditCardStyle(
          borderColor: focusedBorderColor ?? AppColors.primary200,
          textColor: textColor ?? AppColors.neutral700,
          hintColor: hintColor ?? AppColors.neutral400,
          counterColor: AppColors.neutral700,
        );
      case SsossContentsEditCardState.error:
        return _ContentsEditCardStyle(
          borderColor: errorBorderColor ?? AppColors.error500,
          textColor: errorTextColor ?? AppColors.error500,
          hintColor: errorTextColor ?? AppColors.error500,
          counterColor: AppColors.error500,
        );
    }
  }
}
