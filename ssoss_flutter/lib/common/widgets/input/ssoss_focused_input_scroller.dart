import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// 포커스된 입력의 캐럿이 키보드·하단 CTA에 가리지 않도록
/// 조상 스크롤 영역에 확보하는 하단 여백.
const double kSsossFocusedInputScrollPaddingBottom = 96;

/// 포커스된 입력의 캐럿이 키보드·하단 CTA에 가리지 않도록
/// 조상 스크롤 영역에 확보하는 여백.
const EdgeInsets kSsossFocusedInputScrollPadding = EdgeInsets.fromLTRB(
  20,
  48,
  20,
  kSsossFocusedInputScrollPaddingBottom,
);

/// [context]가 가리키는 입력(또는 [globalRect])이 화면에 보이도록 스크롤한다.
void ensureSsossFocusedInputVisible(
  BuildContext context, {
  Rect? globalRect,
  EdgeInsets padding = kSsossFocusedInputScrollPadding,
  Duration duration = const Duration(milliseconds: 180),
}) {
  final renderObject = context.findRenderObject();
  if (renderObject is! RenderBox ||
      !renderObject.attached ||
      !renderObject.hasSize) {
    return;
  }

  final targetLocal = globalRect != null
      ? _globalRectToLocal(renderObject, globalRect)
      : _caretRectIn(renderObject) ?? (Offset.zero & renderObject.size);

  renderObject.showOnScreen(
    rect: padding.inflateRect(targetLocal),
    duration: duration,
    curve: Curves.easeOut,
  );
}

/// 포커스·키보드 inset 변화에 맞춰 [ensureSsossFocusedInputVisible]을 호출한다.
///
/// 키보드가 올라와 있을 때만 커서를 따라가며, 내려간 뒤에는 스크롤을 되돌리지 않는다.
/// 키보드를 내려도 포커스는 유지하고, 포커스 해제는 입력 바깥 탭에서 처리한다.
final class SsossFocusedInputScroller with WidgetsBindingObserver {
  SsossFocusedInputScroller({
    required this.isFocused,
    this.globalRectOf,
  });

  final bool Function() isFocused;
  final Rect? Function(BuildContext context)? globalRectOf;

  BuildContext? _context;
  double _lastBottomInset = 0;
  bool _observing = false;

  void attach(BuildContext context) {
    _context = context;
    if (_observing) {
      return;
    }
    WidgetsBinding.instance.addObserver(this);
    _observing = true;
  }

  void detach() {
    if (_observing) {
      WidgetsBinding.instance.removeObserver(this);
      _observing = false;
    }
    _context = null;
  }

  void onFocusGained() => _schedule(force: true);

  @override
  void didChangeMetrics() => _schedule(force: false);

  void _schedule({required bool force}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final context = _context;
      if (context == null || !context.mounted) {
        return;
      }

      final inset = View.of(context).viewInsets.bottom;
      final grew = inset > _lastBottomInset;
      _lastBottomInset = inset;

      if (!isFocused() || inset <= 0) {
        return;
      }
      if (!force && !grew) {
        return;
      }

      ensureSsossFocusedInputVisible(
        context,
        globalRect: globalRectOf?.call(context),
      );
    });
  }
}

Rect _globalRectToLocal(RenderBox host, Rect globalRect) {
  return Rect.fromPoints(
    host.globalToLocal(globalRect.topLeft),
    host.globalToLocal(globalRect.bottomRight),
  );
}

Rect? _caretRectIn(RenderBox host) {
  final editable = _findRenderEditable(host);
  if (editable == null) {
    return null;
  }
  final selection = editable.selection;
  if (selection == null || !selection.isValid) {
    return null;
  }

  final caret = editable.getLocalRectForCaret(selection.extent);
  return Rect.fromPoints(
    editable.localToGlobal(caret.topLeft, ancestor: host),
    editable.localToGlobal(caret.bottomRight, ancestor: host),
  );
}

RenderEditable? _findRenderEditable(RenderObject root) {
  RenderEditable? found;
  void visit(RenderObject object) {
    if (found != null) {
      return;
    }
    if (object is RenderEditable) {
      found = object;
      return;
    }
    object.visitChildren(visit);
  }

  visit(root);
  return found;
}
