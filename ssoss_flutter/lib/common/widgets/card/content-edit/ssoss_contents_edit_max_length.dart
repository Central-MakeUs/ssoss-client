import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:flutter/services.dart';
import 'package:ssoss_flutter/common/widgets/card/content-edit/ssoss_contents_edit_document_mapper.dart';

/// AppFlowy 입력(IME insert/replace)이 최대 글자 수를 넘지 못하게 막는다.
///
/// 한 글자 입력은 차단만 하고, 여러 글자(붙여넣기)는 [onPasteOverflow]로 넘긴다.
class SsossContentsEditMaxLengthInterceptor
    extends AppFlowyKeyboardServiceInterceptor {
  SsossContentsEditMaxLengthInterceptor({
    required this.maxLength,
    this.onPasteOverflow,
  });

  final int Function() maxLength;
  final Future<void> Function(String text)? onPasteOverflow;

  @override
  Future<bool> interceptInsert(
    TextEditingDeltaInsertion insertion,
    EditorState editorState,
    List<CharacterShortcutEvent> characterShortcutEvents,
  ) async {
    final exceeds = SsossContentsEditMaxLength.wouldExceed(
      editorState: editorState,
      maxLength: maxLength(),
      incomingLength: insertion.textInserted.length,
    );
    if (!exceeds) {
      return false;
    }
    await _handleOverflow(insertion.textInserted);
    return true;
  }

  @override
  Future<bool> interceptReplace(
    TextEditingDeltaReplacement replacement,
    EditorState editorState,
    List<CharacterShortcutEvent> characterShortcutEvents,
  ) async {
    final replacedInDelta =
        replacement.replacedRange.end - replacement.replacedRange.start;
    final selection = editorState.selection?.normalized;
    final replacedLength = selection == null || selection.isSingle
        ? replacedInDelta
        : SsossContentsEditMaxLength.selectedPlainTextLength(editorState);

    final exceeds = SsossContentsEditMaxLength.wouldExceed(
      editorState: editorState,
      maxLength: maxLength(),
      incomingLength: replacement.replacementText.length,
      replacedLength: replacedLength,
    );
    if (!exceeds) {
      return false;
    }
    await _handleOverflow(replacement.replacementText);
    return true;
  }

  Future<void> _handleOverflow(String incoming) async {
    if (incoming.length <= 1) {
      return;
    }
    await onPasteOverflow?.call(incoming);
  }
}

/// 콘텐츠 편집 카드의 글자 수 한도 계산.
class SsossContentsEditMaxLength {
  const SsossContentsEditMaxLength._();

  static int selectedPlainTextLength(EditorState editorState) {
    final selection = editorState.selection?.normalized;
    if (selection == null || selection.isCollapsed) {
      return 0;
    }

    final texts = editorState.getTextInSelection(selection);
    if (texts.isEmpty) {
      return 0;
    }

    var length = 0;
    for (var i = 0; i < texts.length; i++) {
      if (i > 0) {
        length += 1;
      }
      length += texts[i].length;
    }
    return length;
  }

  static int remainingInsertLength({
    required EditorState editorState,
    required int maxLength,
    int? replacedLength,
  }) {
    if (maxLength <= 0) {
      return 0x7fffffff;
    }
    final current =
        SsossContentsEditDocumentMapper.plainTextLength(editorState.document);
    final selected = replacedLength ?? selectedPlainTextLength(editorState);
    return maxLength - (current - selected);
  }

  static bool wouldExceed({
    required EditorState editorState,
    required int maxLength,
    required int incomingLength,
    int? replacedLength,
  }) {
    if (maxLength <= 0) {
      return false;
    }
    final remaining = remainingInsertLength(
      editorState: editorState,
      maxLength: maxLength,
      replacedLength: replacedLength,
    );
    return incomingLength > remaining;
  }

  static String clipToRemaining(
    String text, {
    required EditorState editorState,
    required int maxLength,
  }) {
    final remaining = remainingInsertLength(
      editorState: editorState,
      maxLength: maxLength,
    );
    if (remaining <= 0) {
      return '';
    }
    if (text.length <= remaining) {
      return text;
    }
    return text.substring(0, remaining);
  }
}
