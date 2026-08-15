import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ssoss_flutter/common/widgets/input/ssoss_focused_input_scroller.dart';
import 'package:ssoss_flutter/common/widgets/input/ssoss_text_field.dart';

void main() {
  testWidgets('scrolls focused text field above simulated keyboard inset',
      (tester) async {
    tester.view.physicalSize = const Size(400, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    final scrollController = ScrollController();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ListView(
            controller: scrollController,
            children: const [
              SizedBox(height: 640),
              SsossTextField(hintText: 'target'),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );

    expect(scrollController.offset, 0);

    await tester.tap(find.byType(SsossTextField));
    await tester.pump();

    tester.view.viewInsets = const FakeViewPadding(bottom: 360);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));

    expect(scrollController.offset, greaterThan(0));
  });

  testWidgets('does not resnap to caret after keyboard is dismissed',
      (tester) async {
    tester.view.physicalSize = const Size(400, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    final scrollController = ScrollController();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ListView(
            controller: scrollController,
            children: const [
              SizedBox(height: 640),
              SsossTextField(hintText: 'target'),
              SizedBox(height: 400),
            ],
          ),
        ),
      ),
    );

    await tester.tap(find.byType(SsossTextField));
    await tester.pump();

    tester.view.viewInsets = const FakeViewPadding(bottom: 360);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));
    expect(scrollController.offset, greaterThan(0));

    tester.view.viewInsets = FakeViewPadding.zero;
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));

    expect(
      tester.widget<EditableText>(find.byType(EditableText)).focusNode.hasFocus,
      isTrue,
    );

    scrollController.jumpTo(0);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));

    expect(scrollController.offset, 0);
  });

  testWidgets('unfocuses text field when tapping outside', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Column(
            children: [
              SsossTextField(hintText: 'target'),
              SizedBox(height: 40),
              Text('outside'),
            ],
          ),
        ),
      ),
    );

    await tester.tap(find.byType(SsossTextField));
    await tester.pump();
    expect(
      tester.widget<EditableText>(find.byType(EditableText)).focusNode.hasFocus,
      isTrue,
    );

    await tester.tap(find.text('outside'));
    await tester.pump();
    expect(
      tester.widget<EditableText>(find.byType(EditableText)).focusNode.hasFocus,
      isFalse,
    );
  });

  testWidgets('ensureSsossFocusedInputVisible scrolls target into viewport',
      (tester) async {
    tester.view.physicalSize = const Size(400, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    final scrollController = ScrollController();
    final targetKey = GlobalKey();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ListView(
            controller: scrollController,
            children: [
              const SizedBox(height: 900),
              ColoredBox(
                key: targetKey,
                color: const Color(0xFF000000),
                child: const SizedBox(height: 40, width: double.infinity),
              ),
              const SizedBox(height: 200),
            ],
          ),
        ),
      ),
    );

    expect(scrollController.offset, 0);

    ensureSsossFocusedInputVisible(targetKey.currentContext!);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));

    expect(scrollController.offset, greaterThan(0));
  });
}
