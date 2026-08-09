import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:ssoss_flutter/common/widgets/toast/ssoss_toast.dart';

/// 붙여넣기가 최대 글자 수를 넘어 잘렸을 때 쓰는 경고 문구.
const String kSsossMaxLengthPasteTruncatedMessage =
    '텍스트가 너무 길어 일부만 복사되었습니다.';

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

    final attemptedGrowth = newValue.text.length - oldValue.text.length;
    if (attemptedGrowth > 1) {
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
