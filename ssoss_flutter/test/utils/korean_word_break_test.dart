import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ssoss_flutter/common/widgets/text/app_text.dart';
import 'package:ssoss_flutter/utils/korean_word_break.dart';

void main() {
  test('koreanWordBreak keeps emoji as well-formed UTF-16', () {
    const source = '크림브륄레 커피 설명💰';
    final broken = source.koreanWordBreak;

    expect(() => broken.runes.toList(), returnsNormally);
    expect(broken.contains('💰'), isTrue);
    // surrogate pair 사이에 ZWJ가 끼면 깨진 UTF-16이 된다
    expect(broken.isWellFormedUtf16, isTrue);
  });

  testWidgets('AppText renders emoji without UTF-16 error', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: AppText('크림브륄레 커피 설명💰'),
        ),
      ),
    );

    expect(tester.takeException(), isNull);
    expect(find.textContaining('💰', findRichText: true), findsOneWidget);
  });
}

extension on String {
  bool get isWellFormedUtf16 {
    final units = codeUnits;
    for (var i = 0; i < units.length; i++) {
      final unit = units[i];
      if (unit >= 0xD800 && unit <= 0xDBFF) {
        if (i + 1 >= units.length) {
          return false;
        }
        final next = units[i + 1];
        if (next < 0xDC00 || next > 0xDFFF) {
          return false;
        }
        i++;
        continue;
      }
      if (unit >= 0xDC00 && unit <= 0xDFFF) {
        return false;
      }
    }
    return true;
  }
}
