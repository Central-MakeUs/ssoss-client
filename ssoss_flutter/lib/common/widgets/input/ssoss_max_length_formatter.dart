import 'dart:async';

import 'package:characters/characters.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:ssoss_flutter/common/widgets/toast/ssoss_toast.dart';

/// 붙여넣기가 최대 글자 수를 넘어 잘렸을 때 쓰는 경고 문구.
const String kSsossMaxLengthPasteTruncatedMessage = '텍스트가 너무 길어 일부만 복사되었습니다.';

/// 한 번에 이 글자 수(UTF-16) 이상 늘어날 때만 붙여넣기 잘림으로 본다.
///
/// 키보드 연속 입력은 2~수 글자가 한 업데이트로 올 수 있어,
/// `> 1` 판별은 오탐이 난다.
const int kSsossMinPasteGrowthForNotice = 6;

void showSsossMaxLengthPasteTruncatedToast(BuildContext context) {
  if (!context.mounted) {
    return;
  }
  showSsossToast(
    context,
    title: kSsossMaxLengthPasteTruncatedMessage,
    type: SsossToastType.warning,
  );
}

/// 최대 길이 초과 입력이 붙여넣기 잘림으로 보일지 판별한다.
///
/// IME 조합·이모지·빠르게 입력하는 경우는 false.
bool isSsossLikelyTruncatedPaste({
  required TextEditingValue oldValue,
  required TextEditingValue newValue,
}) {
  if (oldValue.composing.isValid || newValue.composing.isValid) {
    return false;
  }

  final selection = oldValue.selection;
  final replaced =
      selection.isValid ? (selection.end - selection.start).abs() : 0;
  final insertedLength = newValue.text.length - oldValue.text.length + replaced;
  if (insertedLength < kSsossMinPasteGrowthForNotice) {
    return false;
  }

  if (selection.isValid && selection.isCollapsed) {
    final start = selection.baseOffset.clamp(0, newValue.text.length);
    final end = (start + insertedLength).clamp(0, newValue.text.length);
    if (end > start) {
      final inserted = newValue.text.substring(start, end);
      if (inserted.characters.length <= 1) {
        return false;
      }
    }
  }

  return true;
}

/// 컨트롤러 등에서 길이만 알 때 쓰는 붙여넣기 잘림 판별.
bool isSsossLikelyTruncatedPasteByGrowth({
  required int oldLength,
  required int newLength,
  bool isComposing = false,
}) {
  if (isComposing) {
    return false;
  }
  return newLength - oldLength >= kSsossMinPasteGrowthForNotice;
}

/// [String.length](UTF-16) 기준으로 최대 글자 수를 제한한다.
///
/// [maxLength]가 0 이하면 제한하지 않는다.
/// 이미 한도를 넘는 초기 값은 삭제는 허용하고, 늘어나는 입력만 막는다.
/// 붙여넣기로 한도를 넘으면 잘라 넣고 [onTruncatedPaste]를 호출한다.
class SsossMaxLengthFormatter extends TextInputFormatter {
  SsossMaxLengthFormatter(
    this.maxLength, {
    this.onTruncatedPaste,
  });

  int maxLength;
  final VoidCallback? onTruncatedPaste;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (maxLength <= 0 || newValue.text.length <= maxLength) {
      return newValue;
    }
    if (newValue.text.length < oldValue.text.length) {
      return newValue;
    }

    if (isSsossLikelyTruncatedPaste(
      oldValue: oldValue,
      newValue: newValue,
    )) {
      _notifyTruncatedPaste();
    }

    if (oldValue.text.length >= maxLength) {
      return oldValue.copyWith(composing: TextRange.empty);
    }

    final truncated = newValue.text.substring(0, maxLength);
    return TextEditingValue(
      text: truncated,
      selection: TextSelection.collapsed(offset: truncated.length),
    );
  }

  void _notifyTruncatedPaste() {
    final callback = onTruncatedPaste;
    if (callback == null) {
      return;
    }
    scheduleMicrotask(callback);
  }
}
