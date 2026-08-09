import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ssoss_flutter/common/widgets/button/ssoss_button.dart';
import 'package:ssoss_flutter/common/widgets/input/ssoss_hashtag_input.dart';
import 'package:ssoss_flutter/common/widgets/toast/ssoss_toast.dart';

void main() {
  testWidgets('truncates hashtag paste beyond maxLength and shows warning toast',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SsossHashtagInput(
            hashtags: const [],
            onAdd: (_) {},
            onRemove: (_) {},
          ),
        ),
      ),
    );

    final tooLong = 'a' * (SsossHashtagLimits.maxLength + 10);
    await tester.enterText(find.byType(EditableText), tooLong);
    await tester.pump();

    final editable = tester.widget<EditableText>(find.byType(EditableText));
    expect(editable.controller.text.length, SsossHashtagLimits.maxLength);
    expect(find.byType(SsossToast), findsOneWidget);

    await tester.pump(const Duration(seconds: 2));
    await tester.pump(const Duration(milliseconds: 200));
  });

  testWidgets('respects custom maxLength for menu-like input', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SsossHashtagInput(
            hashtags: const [],
            maxLength: 10,
            showHashPrefix: false,
            onAdd: (_) {},
            onRemove: (_) {},
          ),
        ),
      ),
    );

    await tester.enterText(find.byType(EditableText), 'abcdefghijklmnop');
    await tester.pump();

    final editable = tester.widget<EditableText>(find.byType(EditableText));
    expect(editable.controller.text.length, 10);
    expect(find.byType(SsossToast), findsOneWidget);

    await tester.pump(const Duration(seconds: 2));
    await tester.pump(const Duration(milliseconds: 200));
  });

  testWidgets('shows error toast and skips onAdd for duplicate hashtag',
      (tester) async {
    final added = <String>[];

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SsossHashtagInput(
            hashtags: const ['디저트맛집'],
            onAdd: added.add,
            onRemove: (_) {},
          ),
        ),
      ),
    );

    await tester.enterText(find.byType(EditableText), '#디저트맛집');
    await tester.tap(find.byType(SsossButton));
    await tester.pump();

    expect(added, isEmpty);
    expect(find.byType(SsossToast), findsOneWidget);

    final toast = tester.widget<SsossToast>(find.byType(SsossToast));
    expect(toast.title, kSsossHashtagDuplicateMessage);
    expect(toast.type, SsossToastType.error);

    await tester.pump(const Duration(seconds: 2));
    await tester.pump(const Duration(milliseconds: 200));
  });
}
