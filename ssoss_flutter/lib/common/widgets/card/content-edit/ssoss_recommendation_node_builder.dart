import 'dart:async';

import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ssoss_flutter/common/widgets/card/ssoss_recommendation_card.dart';
import 'package:ssoss_flutter/common/widgets/card/content-edit/ssoss_recommendation_node.dart';

/// AppFlowy 에디터에 삽입되는 추천 카드(커스텀 블록) 빌더.
///
/// [BlockComponentBuilder]를 구현해 텍스트 문단 사이에
/// [SsossRecommendationCard] UI를 렌더링한다.
class SsossRecommendationNodeBuilder extends BlockComponentBuilder {
  SsossRecommendationNodeBuilder({
    /// 본문 한 줄 높이. 카드 상·하 여백으로 사용해 텍스트 줄 간격과 맞춘다.
    required this.blockSpacing,
    this.onRecommendationDelete,
    this.onRecommendationDeleted,
    this.deleteConfig = const SsossRecommendationCardDeleteConfig(),
  });

  final double blockSpacing;
  final SsossRecommendationDeleteCallback? onRecommendationDelete;
  final void Function(SsossRecommendationCardItem item)?
      onRecommendationDeleted;
  final SsossRecommendationCardDeleteConfig deleteConfig;

  @override
  BlockComponentWidget build(BlockComponentContext blockComponentContext) {
    final node = blockComponentContext.node;
    return SsossRecommendationBlockComponentWidget(
      key: node.key,
      node: node,
      blockSpacing: blockSpacing,
      onRecommendationDelete: onRecommendationDelete,
      onRecommendationDeleted: onRecommendationDeleted,
      deleteConfig: deleteConfig,
    );
  }

  @override
  BlockComponentValidate get validate => (node) {
        return node.type == SsossRecommendationNodeKeys.type &&
            ssossRecommendationItemFromNode(node) != null;
      };
}

class SsossRecommendationBlockComponentWidget
    extends BlockComponentStatefulWidget {
  const SsossRecommendationBlockComponentWidget({
    super.key,
    required super.node,
    required this.blockSpacing,
    super.configuration = const BlockComponentConfiguration(),
    required this.deleteConfig,
    this.onRecommendationDelete,
    this.onRecommendationDeleted,
  });

  final double blockSpacing;
  final SsossRecommendationDeleteCallback? onRecommendationDelete;
  final void Function(SsossRecommendationCardItem item)?
      onRecommendationDeleted;
  final SsossRecommendationCardDeleteConfig deleteConfig;

  @override
  State<SsossRecommendationBlockComponentWidget> createState() =>
      _SsossRecommendationBlockComponentWidgetState();
}

class _SsossRecommendationBlockComponentWidgetState
    extends State<SsossRecommendationBlockComponentWidget>
    with SelectableMixin, BlockComponentConfigurable {
  /// 선택 영역·히트 테스트 계산에 사용하는 카드 본문 키.
  final _contentKey = GlobalKey();

  @override
  BlockComponentConfiguration get configuration => widget.configuration;

  @override
  Node get node => widget.node;

  RenderBox? get _renderBox {
    final renderObject = context.findRenderObject();
    return renderObject is RenderBox ? renderObject : null;
  }

  SsossRecommendationCardItem? get _item =>
      ssossRecommendationItemFromNode(widget.node);

  /// 카드 UI에서 삭제 확인 후 에디터 문서 트리에서 노드를 제거한다.
  void _removeNodeFromEditor(EditorState editorState) {
    final transaction = editorState.transaction..deleteNode(widget.node);
    unawaited(editorState.apply(transaction));
  }

  @override
  Widget build(BuildContext context) {
    final item = _item;
    if (item == null) {
      return const SizedBox.shrink();
    }

    final editorState = context.read<EditorState>();

    // blockSpacing으로 텍스트 문단과 동일한 줄 높이만큼 상·하 여백을 둔다.
    final child = Padding(
      key: _contentKey,
      padding: EdgeInsets.symmetric(vertical: widget.blockSpacing),
      child: SsossRecommendationCard(
        item: item,
        onDelete: widget.onRecommendationDelete,
        onDeleted: () {
          _removeNodeFromEditor(editorState);
          widget.onRecommendationDeleted?.call(item);
        },
        deleteConfig: widget.deleteConfig,
      ),
    );

    // 커스텀 블록도 에디터 선택·커서 오버레이에 참여하도록 래핑한다.
    return BlockSelectionContainer(
      node: node,
      delegate: this,
      listenable: editorState.selectionNotifier,
      remoteSelection: editorState.remoteSelections,
      blockColor: editorState.editorStyle.selectionColor,
      cursorColor: editorState.editorStyle.cursorColor,
      selectionColor: editorState.editorStyle.selectionColor,
      supportTypes: const [
        BlockSelectionType.block,
        BlockSelectionType.cursor,
        BlockSelectionType.selection,
      ],
      child: child,
    );
  }

  // --- SelectableMixin: 비텍스트 블록의 선택·커서 영역을 카드 크기에 맞춘다. ---

  @override
  Position start() => Position(path: widget.node.path, offset: 0);

  @override
  Position end() => Position(path: widget.node.path, offset: 1);

  @override
  Position getPositionInOffset(Offset start) => end();

  @override
  bool get shouldCursorBlink => false;

  @override
  CursorStyle get cursorStyle => CursorStyle.cover;

  @override
  Rect getBlockRect({
    bool shiftWithBaseOffset = false,
  }) {
    final rects = getRectsInSelection(Selection.invalid());
    return rects.isEmpty ? Rect.zero : rects.first;
  }

  @override
  Rect? getCursorRectInPosition(
    Position position, {
    bool shiftWithBaseOffset = false,
  }) {
    if (_renderBox == null) {
      return null;
    }
    return getRectsInSelection(
      Selection.collapsed(position),
      shiftWithBaseOffset: shiftWithBaseOffset,
    ).firstOrNull;
  }

  @override
  List<Rect> getRectsInSelection(
    Selection selection, {
    bool shiftWithBaseOffset = false,
  }) {
    if (_renderBox == null) {
      return const [];
    }
    final parentBox = context.findRenderObject();
    final contentBox = _contentKey.currentContext?.findRenderObject();
    if (parentBox is RenderBox && contentBox is RenderBox) {
      return [
        (shiftWithBaseOffset
                ? contentBox.localToGlobal(Offset.zero, ancestor: parentBox)
                : Offset.zero) &
            contentBox.size,
      ];
    }
    return [Offset.zero & _renderBox!.size];
  }

  @override
  Selection getSelectionInRange(Offset start, Offset end) => Selection.single(
        path: widget.node.path,
        startOffset: 0,
        endOffset: 1,
      );

  @override
  Offset localToGlobal(
    Offset offset, {
    bool shiftWithBaseOffset = false,
  }) =>
      _renderBox?.localToGlobal(offset) ?? offset;

  @override
  TextDirection textDirection() => TextDirection.ltr;
}
