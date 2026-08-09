import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ssoss_flutter/common/widgets/card/content-edit/ssoss_contents_edit_document.dart';
import 'package:ssoss_flutter/common/widgets/card/ssoss_contents_edit_card.dart';

void main() {
  testWidgets('unfocuses when tapping outside the editor', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ListView(
            children: [
              SsossContentsEditCard(
                document: SsossContentsEditDocument.single(text: '본문'),
              ),
              const SizedBox(height: 80),
              const Text('outside'),
            ],
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byType(AppFlowyEditor));
    await tester.pumpAndSettle();

    final editorFocus =
        tester.widget<AppFlowyEditor>(find.byType(AppFlowyEditor)).focusNode;
    expect(editorFocus?.hasFocus, isTrue);

    await tester.tap(find.text('outside'));
    await tester.pumpAndSettle();

    expect(editorFocus?.hasFocus, isFalse);
    expect(
      tester
          .widget<AppFlowyEditor>(find.byType(AppFlowyEditor))
          .editorState
          .selection,
      isNull,
    );
  });

  testWidgets('keeps focus when keyboard is dismissed', (tester) async {
    tester.view.physicalSize = const Size(400, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SsossContentsEditCard(
            document: SsossContentsEditDocument.single(text: '본문'),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byType(AppFlowyEditor));
    await tester.pumpAndSettle();

    tester.view.viewInsets = const FakeViewPadding(bottom: 360);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));

    tester.view.viewInsets = FakeViewPadding.zero;
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));

    final editorFocus =
        tester.widget<AppFlowyEditor>(find.byType(AppFlowyEditor)).focusNode;
    expect(editorFocus?.hasFocus, isTrue);
  });

  testWidgets('selection handle dismiss does not resnap scroll to caret',
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
            cacheExtent: 2000,
            children: [
              const SizedBox(height: 640),
              SsossContentsEditCard(
                document: SsossContentsEditDocument.single(text: '본문 텍스트입니다'),
              ),
              const SizedBox(height: 400),
            ],
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byType(AppFlowyEditor));
    await tester.pumpAndSettle();

    final editorState =
        tester.widget<AppFlowyEditor>(find.byType(AppFlowyEditor)).editorState;

    tester.view.viewInsets = const FakeViewPadding(bottom: 360);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    final settledOffset = scrollController.offset;

    await editorState.updateSelectionWithReason(
      Selection.collapsed(Position(path: [0], offset: 1)),
      reason: SelectionUpdateReason.uiEvent,
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(scrollController.offset, settledOffset);
  });

  testWidgets('reset document restores original content for the card',
      (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: _ResetHarness(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('doc:원본 본문'), findsOneWidget);

    await tester.tap(find.text('편집 반영'));
    await tester.pumpAndSettle();
    expect(find.text('doc:수정된 본문'), findsOneWidget);

    await tester.tap(find.text('초기화'));
    await tester.pumpAndSettle();
    expect(find.text('doc:원본 본문'), findsOneWidget);
    expect(find.byType(SsossContentsEditCard), findsOneWidget);
  });
}

class _ResetHarness extends StatefulWidget {
  const _ResetHarness();

  @override
  State<_ResetHarness> createState() => _ResetHarnessState();
}

class _ResetHarnessState extends State<_ResetHarness> {
  late SsossContentsEditDocument _document =
      SsossContentsEditDocument.single(text: '원본 본문');

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('doc:${_document.plainText}'),
        SsossContentsEditCard(
          document: _document,
          onDocumentChanged: (value) {
            setState(() => _document = value);
          },
        ),
        TextButton(
          onPressed: () {
            setState(() {
              _document = _document.copyWith(
                blocks: [
                  const SsossContentsEditTextBlock(
                    id: 'text-0',
                    text: '수정된 본문',
                  ),
                ],
              );
            });
          },
          child: const Text('편집 반영'),
        ),
        TextButton(
          onPressed: () {
            setState(() => _document = _document.reset());
          },
          child: const Text('초기화'),
        ),
      ],
    );
  }
}
