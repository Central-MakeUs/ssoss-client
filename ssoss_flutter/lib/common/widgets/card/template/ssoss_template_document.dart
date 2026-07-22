import 'package:flutter/painting.dart';

/// 템플릿 본문.
///
/// 본문 전체는 자유롭게 편집하고, 템플릿 원본 `[플레이스홀더]`만 주황으로 표시한다.
/// 원본 토큰이 한 번 깨지면(개수 감소) 이후 동일 문자열을 다시 만들어도 강조하지 않는다.
/// [reset]으로만 원본 강조를 복구한다.
class SsossTemplateDocument {
  const SsossTemplateDocument({
    required this.text,
    required this.originalTemplate,
    this.activePlaceholderCounts = const {},
  });

  final String text;

  /// 초기화용 원본 템플릿 문자열.
  final String originalTemplate;

  /// 아직 강조 가능한 원본 토큰별 잔여 개수. 편집 시 절대 증가하지 않는다.
  final Map<String, int> activePlaceholderCounts;

  static final RegExp _placeholderPattern = RegExp(r'\[[^\]]*\]');

  factory SsossTemplateDocument.fromTemplate(String template) {
    return SsossTemplateDocument(
      text: template,
      originalTemplate: template,
      activePlaceholderCounts: _countPlaceholders(template),
    );
  }

  /// 원본 템플릿 텍스트·강조를 모두 복구한다.
  SsossTemplateDocument reset() =>
      SsossTemplateDocument.fromTemplate(originalTemplate);

  SsossTemplateDocument copyWith({
    String? text,
    String? originalTemplate,
    Map<String, int>? activePlaceholderCounts,
  }) {
    final nextText = text ?? this.text;
    final nextActive = activePlaceholderCounts ??
        (text != null
            ? _shrinkActivePlaceholders(nextText)
            : this.activePlaceholderCounts);

    return SsossTemplateDocument(
      text: nextText,
      originalTemplate: originalTemplate ?? this.originalTemplate,
      activePlaceholderCounts: nextActive,
    );
  }

  String get plainText => text;

  int get textLength => text.length;

  Map<String, int> _shrinkActivePlaceholders(String nextText) {
    if (activePlaceholderCounts.isEmpty) {
      return const {};
    }

    final presentCounts = _countPlaceholders(nextText);
    final shrunk = <String, int>{};
    for (final entry in activePlaceholderCounts.entries) {
      final remaining = entry.value;
      if (remaining <= 0) {
        continue;
      }
      final present = presentCounts[entry.key] ?? 0;
      final next = remaining < present ? remaining : present;
      if (next > 0) {
        shrunk[entry.key] = next;
      }
    }
    return Map.unmodifiable(shrunk);
  }

  static Map<String, int> _countPlaceholders(String text) {
    final counts = <String, int>{};
    for (final match in _placeholderPattern.allMatches(text)) {
      final token = match.group(0)!;
      counts[token] = (counts[token] ?? 0) + 1;
    }
    return Map.unmodifiable(counts);
  }

  /// 본문 전체에서 활성 원본 `[...]`만 주황으로 칠한 스팬을 만든다.
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
        activePlaceholderCounts: activePlaceholderCounts,
      ),
    );
  }

  /// [text] 안에서 활성 원본 `[...]`만 주황으로 칠한다.
  ///
  /// 왼쪽부터 스캔하며 토큰별 remaining 개수만큼만 강조한다.
  static List<InlineSpan> buildStyledSpans({
    required String text,
    required TextStyle baseStyle,
    required Color placeholderColor,
    Map<String, int> activePlaceholderCounts = const {},
  }) {
    if (text.isEmpty) {
      return const [];
    }

    final remaining = Map<String, int>.from(activePlaceholderCounts);
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
      final left = remaining[token] ?? 0;
      final shouldHighlight = left > 0;
      if (shouldHighlight) {
        remaining[token] = left - 1;
      }
      spans.add(
        TextSpan(
          text: token,
          style: shouldHighlight
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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! SsossTemplateDocument) {
      return false;
    }
    return text == other.text &&
        originalTemplate == other.originalTemplate &&
        _mapEquals(activePlaceholderCounts, other.activePlaceholderCounts);
  }

  @override
  int get hashCode => Object.hash(
        text,
        originalTemplate,
        Object.hashAll(
          activePlaceholderCounts.entries.map((e) => Object.hash(e.key, e.value)),
        ),
      );

  static bool _mapEquals(Map<String, int> a, Map<String, int> b) {
    if (identical(a, b)) {
      return true;
    }
    if (a.length != b.length) {
      return false;
    }
    for (final entry in a.entries) {
      if (b[entry.key] != entry.value) {
        return false;
      }
    }
    return true;
  }
}
