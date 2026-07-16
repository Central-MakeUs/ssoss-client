import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ssoss_flutter/common/widgets/card/template/ssoss_template_document.dart';
import 'package:ssoss_flutter/common/widgets/text/app_text.dart';
import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';

enum SsossTemplateContentsEditCardState {
  normal,
  hover,
  filled,
  pressed,
  error,
}

/// 템플릿 전용 콘텐츠 편집 카드.
///
/// 본문 전체는 자유롭게 편집한다.
/// 템플릿 원본 `[...]`만 주황으로 표시하고, 내용을 바꾸면 기본 색을 유지한다.
class SsossTemplateContentsEditCard extends StatefulWidget {
  const SsossTemplateContentsEditCard({
    required this.document,
    super.key,
    this.onDocumentChanged,
    this.onChanged,
    this.state,
    this.maxLength = 5000,
    this.enabled = true,
    this.readOnly = false,
    this.width,
    this.minHeight = 129,
    this.padding,
    this.borderRadius,
    this.backgroundColor,
    this.borderColor,
    this.focusedBorderColor,
    this.errorBorderColor,
    this.contentColor,
    this.emptySlotColor,
    this.errorTextColor,
    this.counterColor,
    this.counterMutedColor,
    this.textStyle,
    this.counterStyle,
  });

  final SsossTemplateDocument document;
  final ValueChanged<SsossTemplateDocument>? onDocumentChanged;
  final ValueChanged<String>? onChanged;
  final SsossTemplateContentsEditCardState? state;
  final int maxLength;
  final bool enabled;
  final bool readOnly;
  final double? width;
  final double minHeight;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? errorBorderColor;
  final Color? contentColor;
  final Color? emptySlotColor;
  final Color? errorTextColor;
  final Color? counterColor;
  final Color? counterMutedColor;
  final TextStyle? textStyle;
  final TextStyle? counterStyle;

  @override
  State<SsossTemplateContentsEditCard> createState() =>
      _SsossTemplateContentsEditCardState();
}

class _SsossTemplateContentsEditCardState
    extends State<SsossTemplateContentsEditCard> {
  late final FocusNode _focusNode;
  late final _TemplateTextEditingController _controller;
  late final ValueNotifier<int> _lengthNotifier;
  late SsossTemplateDocument _document;
  SsossTemplateDocument? _lastEmittedDocument;
  bool _isApplyingDocument = false;

  @override
  void initState() {
    super.initState();
    _document = widget.document;
    _lengthNotifier = ValueNotifier<int>(_document.textLength);
    _focusNode = FocusNode()..addListener(_onFocusChanged);
    _controller = _TemplateTextEditingController(
      document: _document,
      contentColor: widget.contentColor ?? AppColors.black,
      emptySlotColor: widget.emptySlotColor ?? AppColors.primary300,
      text: _document.plainText,
    )..addListener(_onControllerChanged);
  }

  @override
  void didUpdateWidget(covariant SsossTemplateContentsEditCard oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.document != widget.document &&
        widget.document != _lastEmittedDocument &&
        oldWidget.document.plainText != widget.document.plainText) {
      _syncFromDocument(widget.document);
    }

    if (oldWidget.contentColor != widget.contentColor ||
        oldWidget.emptySlotColor != widget.emptySlotColor) {
      _controller.contentColor = widget.contentColor ?? AppColors.black;
      _controller.emptySlotColor =
          widget.emptySlotColor ?? AppColors.primary300;
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onControllerChanged);
    _focusNode.removeListener(_onFocusChanged);
    _focusNode.dispose();
    _controller.dispose();
    _lengthNotifier.dispose();
    super.dispose();
  }

  void _onFocusChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  void _onControllerChanged() {
    if (_isApplyingDocument) {
      return;
    }
    if (_controller.value.composing.isValid) {
      return;
    }

    final next = _document.copyWith(text: _controller.text);
    if (next.plainText == _document.plainText) {
      _lengthNotifier.value = next.textLength;
      return;
    }

    _document = next;
    _controller.document = next;
    _lastEmittedDocument = next;
    _lengthNotifier.value = next.textLength;
    widget.onDocumentChanged?.call(next);
    widget.onChanged?.call(next.plainText);
  }

  void _syncFromDocument(SsossTemplateDocument document) {
    _isApplyingDocument = true;
    _document = document;
    _controller.document = document;
    _lengthNotifier.value = document.textLength;
    _controller.value = TextEditingValue(
      text: document.plainText,
      selection: _controller.selection,
    );
    _isApplyingDocument = false;
  }

  bool get _hasFocus => _focusNode.hasFocus;

  SsossTemplateContentsEditCardState _resolveState() {
    if (widget.state != null) {
      return widget.state!;
    }
    if (_hasFocus) {
      return SsossTemplateContentsEditCardState.pressed;
    }
    if (_document.plainText.isNotEmpty) {
      return SsossTemplateContentsEditCardState.filled;
    }
    return SsossTemplateContentsEditCardState.normal;
  }

  _TemplateEditCardStyle _resolveStyle() {
    return _TemplateEditCardStyle.from(
      _resolveState(),
      borderColor: widget.borderColor,
      focusedBorderColor: widget.focusedBorderColor,
      errorBorderColor: widget.errorBorderColor,
      textColor: widget.contentColor,
      errorTextColor: widget.errorTextColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    final style = _resolveStyle();
    final textStyle = (widget.textStyle ?? AppTextStyles.b4).copyWith(
      color: style.textColor,
    );
    final canEdit = widget.enabled && !widget.readOnly;

    return Container(
      width: widget.width,
      constraints: BoxConstraints(minHeight: widget.minHeight),
      padding: widget.padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? AppColors.white,
        borderRadius: widget.borderRadius ?? BorderRadius.circular(12),
        border: Border.all(color: style.borderColor),
        boxShadow: _resolveState() == SsossTemplateContentsEditCardState.pressed
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
            readOnly: !canEdit,
            maxLines: null,
            style: textStyle,
            cursorColor: widget.focusedBorderColor ?? AppColors.primary400,
            keyboardType: TextInputType.multiline,
            inputFormatters: canEdit
                ? [LengthLimitingTextInputFormatter(widget.maxLength)]
                : const [],
            selectionWidthStyle: ui.BoxWidthStyle.tight,
            selectionHeightStyle: ui.BoxHeightStyle.tight,
            onTapOutside: (_) => _focusNode.unfocus(),
            decoration: const InputDecoration(
              isDense: true,
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
            ),
          ),
          const SizedBox(height: 36),
          ValueListenableBuilder<int>(
            valueListenable: _lengthNotifier,
            builder: (context, textLength, _) {
              return _TemplateCounterText(
                current: textLength,
                max: widget.maxLength,
                isError: _resolveState() ==
                        SsossTemplateContentsEditCardState.error ||
                    textLength > widget.maxLength,
                currentColor: widget.counterColor ?? style.counterColor,
                mutedColor: widget.counterMutedColor ?? AppColors.neutral300,
                textStyle: widget.counterStyle,
              );
            },
          ),
        ],
      ),
    );
  }
}

class _TemplateTextEditingController extends TextEditingController {
  _TemplateTextEditingController({
    required this.document,
    required this.contentColor,
    required this.emptySlotColor,
    required String text,
  }) : super(text: text);

  SsossTemplateDocument document;
  Color contentColor;
  Color emptySlotColor;

  @override
  TextSpan buildTextSpan({
    required BuildContext context,
    required bool withComposing,
    TextStyle? style,
  }) {
    final baseStyle =
        (style ?? const TextStyle()).copyWith(color: contentColor);
    // 컨트롤러 텍스트 기준으로 하이라이트 (document와 동기화 전에도 맞춤)
    return TextSpan(
      style: baseStyle,
      children: SsossTemplateDocument.buildStyledSpans(
        text: value.text,
        baseStyle: baseStyle,
        placeholderColor: emptySlotColor,
        originalPlaceholders: document.originalPlaceholders,
      ),
    );
  }
}

class _TemplateCounterText extends StatelessWidget {
  const _TemplateCounterText({
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
        AppText(
          '$current',
          style: baseStyle.copyWith(
            color: isError ? AppColors.error500 : currentColor,
          ),
        ),
        AppText(
          ' / ',
          style: baseStyle.copyWith(
            color: mutedColor,
          ),
        ),
        AppText(
          '$max',
          style: baseStyle.copyWith(
            color: mutedColor,
          ),
        ),
      ],
    );
  }
}

class _TemplateEditCardStyle {
  const _TemplateEditCardStyle({
    required this.borderColor,
    required this.textColor,
    required this.counterColor,
  });

  final Color borderColor;
  final Color textColor;
  final Color counterColor;

  static _TemplateEditCardStyle from(
    SsossTemplateContentsEditCardState state, {
    Color? borderColor,
    Color? focusedBorderColor,
    Color? errorBorderColor,
    Color? textColor,
    Color? errorTextColor,
  }) {
    switch (state) {
      case SsossTemplateContentsEditCardState.normal:
        return _TemplateEditCardStyle(
          borderColor: borderColor ?? AppColors.neutral200,
          textColor: textColor ?? AppColors.black,
          counterColor: AppColors.black,
        );
      case SsossTemplateContentsEditCardState.hover:
        return _TemplateEditCardStyle(
          borderColor: focusedBorderColor ?? AppColors.neutral600,
          textColor: textColor ?? AppColors.black,
          counterColor: AppColors.black,
        );
      case SsossTemplateContentsEditCardState.filled:
        return _TemplateEditCardStyle(
          borderColor: borderColor ?? AppColors.neutral200,
          textColor: textColor ?? AppColors.black,
          counterColor: AppColors.black,
        );
      case SsossTemplateContentsEditCardState.pressed:
        return _TemplateEditCardStyle(
          borderColor: focusedBorderColor ?? AppColors.primary200,
          textColor: textColor ?? AppColors.black,
          counterColor: AppColors.black,
        );
      case SsossTemplateContentsEditCardState.error:
        return _TemplateEditCardStyle(
          borderColor: errorBorderColor ?? AppColors.error500,
          textColor: errorTextColor ?? AppColors.error500,
          counterColor: AppColors.error500,
        );
    }
  }
}
