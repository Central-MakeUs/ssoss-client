import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ssoss_flutter/common/widgets/input/ssoss_text_field.dart';
import 'package:ssoss_flutter/common/widgets/toast/ssoss_toast.dart';

void main() {
  testWidgets('truncates paste beyond maxLength and shows warning toast',
      (tester) async {
    final controller = TextEditingController(text: '12345');

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SsossTextField(
            controller: controller,
            maxLength: 5,
          ),
        ),
      ),
    );

    await tester.enterText(find.byType(EditableText), '123456789');
    await tester.pump();

    expect(controller.text, '12345');
    expect(find.byType(SsossToast), findsOneWidget);

    await tester.pump(const Duration(seconds: 2));
    await tester.pump(const Duration(milliseconds: 200));
  });

  testWidgets('multiline field honors explicit height', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SsossTextField(
            multiline: true,
            height: 68,
          ),
        ),
      ),
    );

    expect(tester.getSize(find.byType(SsossTextField)).height, 68);
  });

  test('isWithinLength accepts 2 to 20 trimmed characters', () {
    expect(
      SsossTextField.isWithinLength('가', minLength: 2, maxLength: 20),
      isFalse,
    );
    expect(
      SsossTextField.isWithinLength('가게', minLength: 2, maxLength: 20),
      isTrue,
    );
    expect(
      SsossTextField.isWithinLength(' 가게 ', minLength: 2, maxLength: 20),
      isTrue,
    );
  });
}
