import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ssoss_flutter/common/widgets/card/content-edit/ssoss_contents_edit_document.dart';
import 'package:ssoss_flutter/common/widgets/card/ssoss_contents_edit_card.dart';

void main() {
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
