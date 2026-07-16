import 'package:flutter/painting.dart';

/// 템플릿 본문.
///
/// 본문 전체는 자유롭게 편집하고, 템플릿 원본 `[플레이스홀더]`만 주황으로 표시한다.
/// 괄호 안 텍스트를 바꾸면 원본과 달라지므로 이후에는 기본 색을 유지한다.
class SsossTemplateDocument {
  const SsossTemplateDocument({
    required this.text,
    this.originalPlaceholders = const {},
  });

  final String text;

  /// 파싱 시점의 `[...]` 원문. 이 값과 정확히 일치할 때만 주황 표시.
  final Set<String> originalPlaceholders;

  static final RegExp _placeholderPattern = RegExp(r'\[[^\]]*\]');

  factory SsossTemplateDocument.fromTemplate(String template) {
    final originalPlaceholders = {
      for (final match in _placeholderPattern.allMatches(template))
        match.group(0)!,
    };
    return SsossTemplateDocument(
      text: template,
      originalPlaceholders: originalPlaceholders,
    );
  }

  SsossTemplateDocument copyWith({
    String? text,
    Set<String>? originalPlaceholders,
  }) {
    return SsossTemplateDocument(
      text: text ?? this.text,
      originalPlaceholders:
          originalPlaceholders ?? this.originalPlaceholders,
    );
  }

  String get plainText => text;

  int get textLength => text.length;

  /// 본문 전체에서 템플릿 원본 `[...]`만 주황으로 칠한 스팬을 만든다.
  TextSpan buildTextSpan({
    required TextStyle baseStyle,
    required Color placeholderColor,
  }) {
    return TextSpan(
      style: baseStyle,
      children: buildStyledSpans(
        text: text,
        baseStyle: baseStyle,
        placeholderColor: placeholderColor,
        originalPlaceholders: originalPlaceholders,
      ),
    );
  }

  /// [text] 안에서 템플릿 원본 `[...]`만 주황으로 칠한다.
  static List<InlineSpan> buildStyledSpans({
    required String text,
    required TextStyle baseStyle,
    required Color placeholderColor,
    Set<String> originalPlaceholders = const {},
  }) {
    if (text.isEmpty) {
      return const [];
    }

    final spans = <InlineSpan>[];
    var cursor = 0;
    for (final match in _placeholderPattern.allMatches(text)) {
      if (match.start > cursor) {
        spans.add(
          TextSpan(
            text: text.substring(cursor, match.start),
            style: baseStyle,
          ),
        );
      }
      final token = match.group(0)!;
      final isOriginalPlaceholder = originalPlaceholders.contains(token);
      spans.add(
        TextSpan(
          text: token,
          style: isOriginalPlaceholder
              ? baseStyle.copyWith(color: placeholderColor)
              : baseStyle,
        ),
      );
      cursor = match.end;
    }
    if (cursor < text.length) {
      spans.add(
        TextSpan(
          text: text.substring(cursor),
          style: baseStyle,
        ),
      );
    }
    return spans;
  }
}
