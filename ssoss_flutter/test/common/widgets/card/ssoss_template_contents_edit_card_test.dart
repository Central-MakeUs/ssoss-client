import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ssoss_flutter/common/widgets/card/ssoss_template_contents_edit_card.dart';
import 'package:ssoss_flutter/common/widgets/card/template/ssoss_template_document.dart';

void main() {
  testWidgets('can edit any part of the document text', (tester) async {
    var document = SsossTemplateDocument.fromTemplate(
      '고정 문구\n가격: [가격]원\n뒤',
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SsossTemplateContentsEditCard(
            document: document,
            onDocumentChanged: (value) => document = value,
          ),
        ),
      ),
    );

    final editableState =
        tester.state<EditableTextState>(find.byType(EditableText));

    editableState.userUpdateTextEditingValue(
      const TextEditingValue(
        text: '수정된 고정 문구\n가격: 5000원\n뒤도 수정',
        selection: TextSelection.collapsed(offset: 20),
      ),
      SelectionChangedCause.keyboard,
    );
    await tester.pump();

    expect(document.plainText, '수정된 고정 문구\n가격: 5000원\n뒤도 수정');
  });

  testWidgets('can keep typing anywhere in the text', (tester) async {
    var document = SsossTemplateDocument.fromTemplate('가격: [가격]원')
        .copyWith(text: '가격: 5원');

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SsossTemplateContentsEditCard(
            document: document,
            onDocumentChanged: (value) => document = value,
          ),
        ),
      ),
    );

    final editableState =
        tester.state<EditableTextState>(find.byType(EditableText));

    editableState.userUpdateTextEditingValue(
      const TextEditingValue(
        text: '가격: 5원',
        selection: TextSelection.collapsed(offset: 5),
      ),
      SelectionChangedCause.tap,
    );
    await tester.pump();

    editableState.userUpdateTextEditingValue(
      const TextEditingValue(
        text: '가격: 50원',
        selection: TextSelection.collapsed(offset: 6),
      ),
      SelectionChangedCause.keyboard,
    );
    await tester.pump();

    expect(document.plainText, '가격: 50원');
  });

  testWidgets('can insert and delete newlines freely', (tester) async {
    var document = SsossTemplateDocument.fromTemplate(
      '앞\n가격: [가격]원\n\n뒤',
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SsossTemplateContentsEditCard(
            document: document,
            onDocumentChanged: (value) => document = value,
          ),
        ),
      ),
    );

    final editableState =
        tester.state<EditableTextState>(find.byType(EditableText));

    editableState.userUpdateTextEditingValue(
      const TextEditingValue(
        text: '앞가격: [가격]원뒤',
        selection: TextSelection.collapsed(offset: 2),
      ),
      SelectionChangedCause.keyboard,
    );
    await tester.pump();

    expect(document.plainText, '앞가격: [가격]원뒤');
  });

  testWidgets('tapping outside text field unfocuses', (tester) async {
    final document = SsossTemplateDocument.fromTemplate('가격: [가격]원');

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Column(
            children: [
              SsossTemplateContentsEditCard(document: document),
              const SizedBox(height: 40),
              const Text('outside'),
            ],
          ),
        ),
      ),
    );

    final editableState =
        tester.state<EditableTextState>(find.byType(EditableText));

    await tester.tap(find.byType(EditableText));
    await tester.pump();
    expect(editableState.widget.focusNode.hasFocus, isTrue);

    await tester.tap(find.text('outside'));
    await tester.pump();
    expect(editableState.widget.focusNode.hasFocus, isFalse);
  });

  testWidgets('reset restores active highlight after same text is retyped',
      (tester) async {
    late StateSetter setState;
    var document = SsossTemplateDocument.fromTemplate('[최초]');

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: StatefulBuilder(
            builder: (context, stateSetter) {
              setState = stateSetter;
              return SsossTemplateContentsEditCard(
                document: document,
                onDocumentChanged: (value) {
                  setState(() => document = value);
                },
              );
            },
          ),
        ),
      ),
    );

    final editableState =
        tester.state<EditableTextState>(find.byType(EditableText));

    editableState.userUpdateTextEditingValue(
      const TextEditingValue(
        text: '[최초',
        selection: TextSelection.collapsed(offset: 3),
      ),
      SelectionChangedCause.keyboard,
    );
    await tester.pump();

    editableState.userUpdateTextEditingValue(
      const TextEditingValue(
        text: '[최초]',
        selection: TextSelection.collapsed(offset: 4),
      ),
      SelectionChangedCause.keyboard,
    );
    await tester.pump();

    expect(document.activePlaceholderCounts, isEmpty);

    setState(() {
      document = document.reset();
    });
    await tester.pump();

    expect(document.plainText, '[최초]');
    expect(document.activePlaceholderCounts, {'[최초]': 1});
  });
}
