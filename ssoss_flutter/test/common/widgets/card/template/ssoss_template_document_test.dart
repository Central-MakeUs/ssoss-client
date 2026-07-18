import 'package:flutter/painting.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ssoss_flutter/common/widgets/card/template/ssoss_template_document.dart';

void main() {
  const template = '''보니스 커피에 새 메뉴가 출시되었습니다!

✨ 신메뉴: 크림브륄레 커피
💰 가격: [가격]원

[메뉴 설명을 입력해주세요]

신선한 재료로 정성껏 만들었습니다. 많은 사랑 부탁드립니다 🙏

📍 서울 마포구 동교로16길 21
⏰ 영업시간: 수, 목, 금, 토, 일 오전 9:00 ~ 오후 8:00
📞 [전화 번호]''';

  const baseStyle = TextStyle(color: Color(0xFF000000));
  const placeholderColor = Color(0xFFFF9E70);

  List<Color?> colorsOf(
    SsossTemplateDocument doc, {
    String? text,
  }) {
    final spans = SsossTemplateDocument.buildStyledSpans(
      text: text ?? doc.text,
      baseStyle: baseStyle,
      placeholderColor: placeholderColor,
      activePlaceholderCounts: doc.activePlaceholderCounts,
    );
    return spans
        .whereType<TextSpan>()
        .map((span) => span.style?.color)
        .toList();
  }

  test('fromTemplate keeps full text and active placeholder counts', () {
    final doc = SsossTemplateDocument.fromTemplate(template);

    expect(doc.plainText, template);
    expect(doc.originalTemplate, template);
    expect(doc.activePlaceholderCounts, {
      '[가격]': 1,
      '[메뉴 설명을 입력해주세요]': 1,
      '[전화 번호]': 1,
    });
  });

  test('copyWith updates text and shrinks active placeholders', () {
    final doc = SsossTemplateDocument.fromTemplate('가격: [가격]원');
    final updated = doc.copyWith(text: '가격: 5500원');

    expect(updated.plainText, '가격: 5500원');
    expect(updated.originalTemplate, '가격: [가격]원');
    expect(updated.activePlaceholderCounts, isEmpty);
  });

  test('only active original placeholders stay orange', () {
    final doc = SsossTemplateDocument.fromTemplate('가격: [가격]원');

    expect(colorsOf(doc), [
      const Color(0xFF000000),
      placeholderColor,
      const Color(0xFF000000),
    ]);

    final cleared = doc.copyWith(text: '가격: []원');
    expect(colorsOf(cleared), [
      const Color(0xFF000000),
      const Color(0xFF000000),
      const Color(0xFF000000),
    ]);

    final replaced = doc.copyWith(text: '가격: [5]원');
    expect(colorsOf(replaced), [
      const Color(0xFF000000),
      const Color(0xFF000000),
      const Color(0xFF000000),
    ]);
  });

  test('breaking bracket permanently disables highlight even after restore', () {
    var doc = SsossTemplateDocument.fromTemplate('[최초]');

    expect(colorsOf(doc), [placeholderColor]);

    doc = doc.copyWith(text: '[최초');
    expect(doc.activePlaceholderCounts, isEmpty);

    doc = doc.copyWith(text: '[최초]');
    expect(doc.activePlaceholderCounts, isEmpty);
    expect(colorsOf(doc), [const Color(0xFF000000)]);
  });

  test('retyping same text after clearing does not restore highlight', () {
    var doc = SsossTemplateDocument.fromTemplate('가격: [가격]원');

    doc = doc.copyWith(text: '');
    expect(doc.activePlaceholderCounts, isEmpty);

    doc = doc.copyWith(text: '가격: [가격]원');
    expect(doc.activePlaceholderCounts, isEmpty);
    expect(colorsOf(doc), [
      const Color(0xFF000000),
      const Color(0xFF000000),
      const Color(0xFF000000),
    ]);
  });

  test('user-created brackets are never highlighted', () {
    var doc = SsossTemplateDocument.fromTemplate('가격: [가격]원');

    doc = doc.copyWith(text: '가격: [가격]원\n[직접입력]');
    expect(colorsOf(doc), [
      const Color(0xFF000000),
      placeholderColor,
      const Color(0xFF000000),
      const Color(0xFF000000),
    ]);
  });

  test('reset restores original text and highlight', () {
    var doc = SsossTemplateDocument.fromTemplate('[최초]');

    doc = doc.copyWith(text: '[최초');
    doc = doc.copyWith(text: '[최초]');
    expect(colorsOf(doc), [const Color(0xFF000000)]);

    doc = doc.reset();
    expect(doc.plainText, '[최초]');
    expect(doc.activePlaceholderCounts, {'[최초]': 1});
    expect(colorsOf(doc), [placeholderColor]);
  });

  test('duplicate tokens: breaking one keeps the other highlighted', () {
    var doc = SsossTemplateDocument.fromTemplate('[가격] and [가격]');
    expect(doc.activePlaceholderCounts, {'[가격]': 2});
    expect(colorsOf(doc), [
      placeholderColor,
      const Color(0xFF000000),
      placeholderColor,
    ]);

    doc = doc.copyWith(text: '[가격] and [가격');
    expect(doc.activePlaceholderCounts, {'[가격]': 1});
    expect(colorsOf(doc), [
      placeholderColor,
      const Color(0xFF000000),
    ]);

    doc = doc.copyWith(text: '[가격] and [가격]');
    expect(doc.activePlaceholderCounts, {'[가격]': 1});
    expect(colorsOf(doc), [
      placeholderColor,
      const Color(0xFF000000),
      const Color(0xFF000000),
    ]);
  });
}
