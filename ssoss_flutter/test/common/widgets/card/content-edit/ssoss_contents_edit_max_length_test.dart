import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ssoss_flutter/common/widgets/card/content-edit/ssoss_contents_edit_document.dart';
import 'package:ssoss_flutter/common/widgets/card/content-edit/ssoss_contents_edit_document_mapper.dart';
import 'package:ssoss_flutter/common/widgets/card/content-edit/ssoss_contents_edit_max_length.dart';

void main() {
  EditorState editorWithText(String text) {
    final editorState = EditorState(
      document: SsossContentsEditDocumentMapper.toAppFlowyDocument(
        SsossContentsEditDocument.single(text: text),
      ),
    );
    final lastLine = text.split('\n').last;
    editorState.selection = Selection.collapsed(
      Position(
        path: [text.split('\n').length - 1],
        offset: lastLine.length,
      ),
    );
    return editorState;
  }

  group('SsossContentsEditMaxLengthInterceptor', () {
    test('blocks insert that would exceed maxLength', () async {
      final editorState = editorWithText('12345');
      final interceptor = SsossContentsEditMaxLengthInterceptor(
        maxLength: () => 5,
      );

      final blocked = await interceptor.interceptInsert(
        const TextEditingDeltaInsertion(
          oldText: '12345',
          textInserted: '6',
          insertionOffset: 5,
          selection: TextSelection.collapsed(offset: 6),
          composing: TextRange.empty,
        ),
        editorState,
        const [],
      );

      expect(blocked, isTrue);
    });

    test('allows insert within maxLength', () async {
      final editorState = editorWithText('123');
      final interceptor = SsossContentsEditMaxLengthInterceptor(
        maxLength: () => 5,
      );

      final blocked = await interceptor.interceptInsert(
        const TextEditingDeltaInsertion(
          oldText: '123',
          textInserted: '4',
          insertionOffset: 3,
          selection: TextSelection.collapsed(offset: 4),
          composing: TextRange.empty,
        ),
        editorState,
        const [],
      );

      expect(blocked, isFalse);
    });

    test('routes multi-character overflow to onPasteOverflow', () async {
      final editorState = editorWithText('123');
      String? overflowText;
      final interceptor = SsossContentsEditMaxLengthInterceptor(
        maxLength: () => 5,
        onPasteOverflow: (text) async => overflowText = text,
      );

      final blocked = await interceptor.interceptInsert(
        const TextEditingDeltaInsertion(
          oldText: '123',
          textInserted: '456789',
          insertionOffset: 3,
          selection: TextSelection.collapsed(offset: 9),
          composing: TextRange.empty,
        ),
        editorState,
        const [],
      );

      expect(blocked, isTrue);
      expect(overflowText, '456789');
    });

    test('blocks newline insert at maxLength', () async {
      final editorState = editorWithText('12345');
      final interceptor = SsossContentsEditMaxLengthInterceptor(
        maxLength: () => 5,
      );

      final blocked = await interceptor.interceptInsert(
        const TextEditingDeltaInsertion(
          oldText: '12345',
          textInserted: '\n',
          insertionOffset: 5,
          selection: TextSelection.collapsed(offset: 6),
          composing: TextRange.empty,
        ),
        editorState,
        const [],
      );

      expect(blocked, isTrue);
    });

    test('allows replace that does not increase length past max', () async {
      final editorState = editorWithText('12345');
      editorState.selection = Selection.single(
        path: [0],
        startOffset: 4,
        endOffset: 5,
      );
      final interceptor = SsossContentsEditMaxLengthInterceptor(
        maxLength: () => 5,
      );

      final blocked = await interceptor.interceptReplace(
        const TextEditingDeltaReplacement(
          oldText: '12345',
          replacementText: '9',
          replacedRange: TextRange(start: 4, end: 5),
          selection: TextSelection.collapsed(offset: 5),
          composing: TextRange.empty,
        ),
        editorState,
        const [],
      );

      expect(blocked, isFalse);
    });
  });

  group('SsossContentsEditMaxLength.clipToRemaining', () {
    test('clips pasted text to remaining capacity', () {
      final editorState = editorWithText('123');
      expect(
        SsossContentsEditMaxLength.clipToRemaining(
          '45678',
          editorState: editorState,
          maxLength: 5,
        ),
        '45',
      );
    });

    test('returns empty string when already at maxLength', () {
      final editorState = editorWithText('12345');
      expect(
        SsossContentsEditMaxLength.clipToRemaining(
          '6',
          editorState: editorState,
          maxLength: 5,
        ),
        isEmpty,
      );
    });
  });
}
