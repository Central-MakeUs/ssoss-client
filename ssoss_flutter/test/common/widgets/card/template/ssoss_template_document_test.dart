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

  test('fromTemplate keeps full text and original placeholders', () {
    final doc = SsossTemplateDocument.fromTemplate(template);

    expect(doc.plainText, template);
    expect(
      doc.originalPlaceholders,
      {
        '[가격]',
        '[메뉴 설명을 입력해주세요]',
        '[전화 번호]',
      },
    );
  });

  test('copyWith updates text while keeping placeholders', () {
    final doc = SsossTemplateDocument.fromTemplate('가격: [가격]원');
    final updated = doc.copyWith(text: '가격: 5500원');

    expect(updated.plainText, '가격: 5500원');
    expect(updated.originalPlaceholders, {'[가격]'});
  });

  test('only original placeholders stay orange after inner text is cleared',
      () {
    final doc = SsossTemplateDocument.fromTemplate('가격: [가격]원');
    expect(doc.originalPlaceholders, {'[가격]'});

    const baseStyle = TextStyle(color: Color(0xFF000000));
    const placeholderColor = Color(0xFFFF9E70);

    List<Color?> colorsOf(String text) {
      final spans = SsossTemplateDocument.buildStyledSpans(
        text: text,
        baseStyle: baseStyle,
        placeholderColor: placeholderColor,
        originalPlaceholders: doc.originalPlaceholders,
      );
      return spans
          .whereType<TextSpan>()
          .map((span) => span.style?.color)
          .toList();
    }

    expect(colorsOf('가격: [가격]원'), [
      const Color(0xFF000000),
      placeholderColor,
      const Color(0xFF000000),
    ]);

    expect(colorsOf('가격: []원'), [
      const Color(0xFF000000),
      const Color(0xFF000000),
      const Color(0xFF000000),
    ]);
    expect(colorsOf('가격: [5]원'), [
      const Color(0xFF000000),
      const Color(0xFF000000),
      const Color(0xFF000000),
    ]);
  });
}
