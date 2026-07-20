import 'dart:async';

import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:flutter/material.dart';
import 'package:ssoss_flutter/common/widgets/card/content-edit/ssoss_contents_edit_document.dart';
import 'package:ssoss_flutter/common/widgets/card/content-edit/ssoss_contents_edit_document_mapper.dart';
import 'package:ssoss_flutter/common/widgets/card/ssoss_recommendation_card.dart';
import 'package:ssoss_flutter/common/widgets/card/content-edit/ssoss_recommendation_node.dart';
import 'package:ssoss_flutter/common/widgets/card/content-edit/ssoss_recommendation_node_builder.dart';
import 'package:ssoss_flutter/common/widgets/text/app_text.dart';

import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';

enum SsossContentsEditCardState {
  normal,
  hover,
  filled,
  pressed,
  error,
}

typedef SsossRecommendationDeletedCallback = void Function(
  SsossRecommendationCardItem item,
);

/// 콘텐츠 편집 카드.
///
/// AppFlowy Editor 위에 텍스트 문단과 추천 카드(커스텀 블록)를
/// 교차 배치해 편집한다. 도메인 모델은 [SsossContentsEditDocument]를 사용한다.
///
/// 초기화는 부모가 [SsossContentsEditDocument.reset] 결과를 [document]로
/// 다시 넘기면 된다. 카드는 외부 문서 교체를 감지해 에디터를 재생성한다.
class SsossContentsEditCard extends StatefulWidget {
  const SsossContentsEditCard({
    required this.document,
    super.key,
    this.onDocumentChanged,
    this.onChanged,
    this.onRecommendationDelete,
    this.onRecommendationDeleted,
    this.recommendationDeleteConfig,
    this.state,
    this.hintText = '입력해주세요',
    this.maxLength = 40,
    this.enabled = true,
    this.readOnly = false,
    this.width,
    this.minHeight = 129,
    this.padding,
    this.borderRadius,
    this.backgroundColor,
    this.borderColor,
    this.focusedBorderColor,
    this.errorBorderColor,
    this.contentColor,
    this.hintColor,
    this.errorTextColor,
    this.counterColor,
    this.counterMutedColor,
    this.textStyle,
    this.counterStyle,
  });

  final SsossContentsEditDocument document;
  final ValueChanged<SsossContentsEditDocument>? onDocumentChanged;
  final ValueChanged<String>? onChanged;
  final SsossRecommendationDeleteCallback? onRecommendationDelete;
  final SsossRecommendationDeletedCallback? onRecommendationDeleted;
  final SsossRecommendationCardDeleteConfig? recommendationDeleteConfig;
  final SsossContentsEditCardState? state;
  final String hintText;
  final int maxLength;
  final bool enabled;
  final bool readOnly;
  final double? width;
  final double minHeight;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? errorBorderColor;
  final Color? contentColor;
  final Color? hintColor;
  final Color? errorTextColor;
  final Color? counterColor;
  final Color? counterMutedColor;
  final TextStyle? textStyle;
  final TextStyle? counterStyle;

  @override
  State<SsossContentsEditCard> createState() => _SsossContentsEditCardState();
}

class _SsossContentsEditCardState extends State<SsossContentsEditCard> {
  /// 삭제 확인 모달 표시에 사용하는 에디터 컨테이너 키.
  final GlobalKey _editorKey = GlobalKey();

  /// AppFlowyEditor 포커스. 카드 테두리 상태(pressed) 갱신에도 사용한다.
  final FocusNode _editorFocusNode = FocusNode();

  /// AppFlowy 편집 상태. 문서 트리·선택·트랜잭션을 관리한다.
  late EditorState _editorState;

  /// shrinkWrap 레이아웃에서 스크롤/높이 계산을 담당한다.
  late EditorScrollController _editorScrollController;
  late EditorStyle _editorStyle;

  /// 편집 트랜잭션마다 도메인 문서를 상위로 전달하기 위한 구독.
  StreamSubscription<EditorTransactionValue>? _transactionSubscription;

  /// 마지막으로 emit한 문서. 외부 prop과 편집 결과를 구분할 때 사용한다.
  SsossContentsEditDocument? _lastEmittedDocument;

  /// 추천 카드 삭제 확인 중 중복 모달·중복 삭제를 막는다.
  bool _isDeletingRecommendation = false;

  @override
  void initState() {
    super.initState();
    _bindEditorState(_createEditorState(widget.document));
    _editorStyle = _buildEditorStyle();
    _editorFocusNode.addListener(_onEditorFocusChanged);
    _editorState.selectionNotifier.addListener(_onEditorSelectionChanged);
    _transactionSubscription =
        _editorState.transactionStream.listen((_) => _handleTransaction());
  }

  @override
  void didUpdateWidget(covariant SsossContentsEditCard oldWidget) {
    super.didUpdateWidget(oldWidget);

    // 외부에서 문서를 교체한 경우에만 에디터를 재생성한다.
    // 편집 중 emit한 문서와 동일한 참조면 재생성하지 않는다.
    // reset()으로 원본을 다시 넘긴 경우도 여기로 들어와 복구된다.
    if (oldWidget.document != widget.document &&
        widget.document != _lastEmittedDocument) {
      _replaceEditorState(widget.document);
    }

    if (oldWidget.contentColor != widget.contentColor ||
        oldWidget.hintColor != widget.hintColor ||
        oldWidget.focusedBorderColor != widget.focusedBorderColor ||
        oldWidget.hintText != widget.hintText) {
      _editorStyle = _buildEditorStyle();
    }
  }

  /// 에디터 상태를 [document] 기준으로 교체한다. (외부 sync / 초기화 복구)
  void _replaceEditorState(SsossContentsEditDocument document) {
    _transactionSubscription?.cancel();
    _editorState.selectionNotifier.removeListener(_onEditorSelectionChanged);
    _editorScrollController.dispose();
    _bindEditorState(_createEditorState(document));
    _editorState.selectionNotifier.addListener(_onEditorSelectionChanged);
    _transactionSubscription =
        _editorState.transactionStream.listen((_) => _handleTransaction());
    _lastEmittedDocument = document;
  }

  @override
  void dispose() {
    _transactionSubscription?.cancel();
    _editorFocusNode.removeListener(_onEditorFocusChanged);
    _editorFocusNode.dispose();
    _editorState.selectionNotifier.removeListener(_onEditorSelectionChanged);
    _editorScrollController.dispose();
    super.dispose();
  }

  void _bindEditorState(EditorState editorState) {
    _editorState = editorState;
    _editorScrollController = EditorScrollController(
      editorState: editorState,
      shrinkWrap: true,
    );
  }

  void _onEditorFocusChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  void _onEditorSelectionChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  /// 도메인 문서를 AppFlowy [EditorState]로 변환해 초기화한다.
  EditorState _createEditorState(SsossContentsEditDocument document) {
    return EditorState(
      document: SsossContentsEditDocumentMapper.toAppFlowyDocument(document),
    )..editable = widget.enabled && !widget.readOnly;
  }

  TextStyle _resolveEditorTextStyle() {
    return (widget.textStyle ?? AppTextStyles.b4).copyWith(
      color: widget.contentColor ?? AppColors.neutral700,
    );
  }

  double _resolveLineHeight(TextStyle textStyle) {
    return textStyle.height ?? AppTextStyles.b4.height ?? 1.5;
  }

  /// 본문 텍스트 한 줄의 실제 높이(px). 추천 카드 상·하 여백에 사용한다.
  double _resolveLineExtent(TextStyle textStyle) {
    final fontSize = textStyle.fontSize ?? AppTextStyles.b4.fontSize ?? 16;
    return fontSize * _resolveLineHeight(textStyle);
  }

  EditorStyle _buildEditorStyle() {
    final textStyle = _resolveEditorTextStyle();
    final lineHeight = _resolveLineHeight(textStyle);

    return EditorStyle.mobile(
      padding: EdgeInsets.zero,
      cursorColor: widget.focusedBorderColor ?? AppColors.primary400,
      selectionColor: AppColors.primary200.withValues(alpha: 0.45),
      textStyleConfiguration: TextStyleConfiguration(
        text: textStyle,
        lineHeight: lineHeight,
        applyHeightToFirstAscent: true,
        applyHeightToLastDescent: true,
      ),
      maxWidth: double.infinity,
    );
  }

  /// AppFlowy 문서 변경을 도메인 모델로 역변환해 콜백·UI를 갱신한다.
  ///
  /// 편집 결과에는 최초 전달 원본([SsossContentsEditDocument.originalBlocks])을
  /// 유지해, 이후 [SsossContentsEditDocument.reset]이 가능하도록 한다.
  void _emitDocumentChange() {
    final document = SsossContentsEditDocumentMapper.fromAppFlowyDocument(
      _editorState.document,
    ).copyWith(originalBlocks: widget.document.originalBlocks);
    _lastEmittedDocument = document;
    widget.onDocumentChanged?.call(document);
    widget.onChanged?.call(document.plainText);
    if (mounted) {
      setState(() {});
    }
  }

  /// 텍스트 문단·추천 카드 블록 빌더를 등록한다.
  ///
  /// 표준 paragraph 빌더는 placeholder·스타일을 덮어쓰고,
  /// [SsossRecommendationNodeKeys.type]은 커스텀 추천 카드 빌더로 교체한다.
  Map<String, BlockComponentBuilder> _buildBlockComponentBuilders() {
    final textStyle = _resolveEditorTextStyle();
    final lineHeight = _resolveLineHeight(textStyle);
    final hintColor = widget.hintColor ?? AppColors.neutral400;

    return {
      ...standardBlockComponentBuilderMap,
      ParagraphBlockKeys.type: ParagraphBlockComponentBuilder(
        configuration: standardBlockComponentConfiguration.copyWith(
          padding: (_) => EdgeInsets.zero,
          placeholderText: (_) => widget.hintText,
          textStyle: (_, {textSpan}) => textStyle.copyWith(height: lineHeight),
          placeholderTextStyle: (_, {textSpan}) => textStyle.copyWith(
            color: hintColor,
            height: lineHeight,
          ),
        ),
        showPlaceholder: _shouldShowParagraphPlaceholder,
      ),
      SsossRecommendationNodeKeys.type: SsossRecommendationNodeBuilder(
        blockSpacing: _resolveLineExtent(textStyle),
        onRecommendationDelete: widget.onRecommendationDelete,
        onRecommendationDeleted: widget.onRecommendationDeleted,
        deleteConfig: widget.recommendationDeleteConfig ??
            const SsossRecommendationCardDeleteConfig(),
      ),
    };
  }

  /// placeholder는 첫 번째 문단이 비어 있고 포커스된 경우에만 노출한다.
  bool _shouldShowParagraphPlaceholder(EditorState editorState, Node node) {
    final selection = editorState.selection;
    if (selection == null ||
        !selection.isSingle ||
        !selection.start.path.equals(node.path)) {
      return false;
    }

    final firstParagraph = editorState.document.root.children
        .where((child) => child.type == ParagraphBlockKeys.type)
        .firstOrNull;
    if (firstParagraph == null || !firstParagraph.path.equals(node.path)) {
      return false;
    }

    return node.delta?.toPlainText().isEmpty ?? true;
  }

  void _handleTransaction() {
    _emitDocumentChange();
  }

  int get _textLength =>
      SsossContentsEditDocumentMapper.plainTextLength(_editorState.document);

  bool get _hasFocus => _editorFocusNode.hasFocus;

  SsossContentsEditCardState _resolveState() {
    if (widget.state != null) {
      return widget.state!;
    }
    if (_hasFocus) {
      return SsossContentsEditCardState.pressed;
    }
    if (_textLength > 0) {
      return SsossContentsEditCardState.filled;
    }
    return SsossContentsEditCardState.normal;
  }

  _ContentsEditCardStyle _resolveStyle() {
    return _ContentsEditCardStyle.from(
      _resolveState(),
      borderColor: widget.borderColor,
      focusedBorderColor: widget.focusedBorderColor,
      errorBorderColor: widget.errorBorderColor,
      textColor: widget.contentColor,
      hintColor: widget.hintColor,
      errorTextColor: widget.errorTextColor,
    );
  }

  /// Backspace로 추천 카드 삭제를 시도할 대상 노드를 찾는다.
  ///
  /// 조건:
  /// - 추천 카드 블록이 직접 선택됐거나
  /// - 커서가 추천 카드 바로 뒤 문단의 맨 앞(offset 0)에 있을 때
  Node? _findRecommendationNodeForBackspace(EditorState editorState) {
    final selection = editorState.selection;
    if (selection == null) {
      return null;
    }

    final selectedNodes = editorState.getSelectedNodes();
    for (final node in selectedNodes) {
      if (node.type == SsossRecommendationNodeKeys.type) {
        return node;
      }
    }

    if (!selection.isCollapsed) {
      return null;
    }

    final currentNode = editorState.document.nodeAtPath(selection.start.path);
    if (currentNode == null ||
        currentNode.type != ParagraphBlockKeys.type ||
        selection.start.offset != 0) {
      return null;
    }

    // 추천 카드 바로 뒤 문단 맨 앞에서 Backspace를 누른 경우.
    final previous = currentNode.previous;
    if (previous?.type == SsossRecommendationNodeKeys.type) {
      return previous;
    }

    return null;
  }

  /// 추천 카드를 삭제하고 앞·뒤 텍스트 문단을 하나로 합친다.
  ///
  /// 구조가 [텍스트][추천 카드][텍스트]일 때 카드와 뒤 문단을 제거한 뒤
  /// 앞 문단에 뒤 문단 텍스트를 이어 붙인다.
  Future<void> _deleteRecommendationAndMergeParagraphs(
    EditorState editorState,
    Node recommendationNode,
  ) async {
    final previous = recommendationNode.previous;
    final next = recommendationNode.next;
    final transaction = editorState.transaction;

    if (previous != null &&
        next != null &&
        previous.type == ParagraphBlockKeys.type &&
        next.type == ParagraphBlockKeys.type &&
        previous.delta != null &&
        next.delta != null) {
      // 커서는 합쳐지기 전 뒤 문단이 시작되던 위치(앞 문단 끝)에 둔다.
      final mergeOffset = previous.delta!.length;
      transaction
        ..mergeText(previous, next)
        ..deleteNode(recommendationNode)
        ..deleteNode(next)
        ..afterSelection = Selection.collapsed(
          Position(path: previous.path, offset: mergeOffset),
        );
    } else {
      transaction.deleteNode(recommendationNode);
      if (next != null &&
          next.type == ParagraphBlockKeys.type &&
          (next.delta?.toPlainText().isEmpty ?? true)) {
        transaction.deleteNode(next);
      }
    }

    await editorState.apply(transaction);
  }

  /// 삭제 확인 모달을 띄운 뒤, 확인 시 추천 카드 노드를 제거한다.
  ///
  /// [mergeParagraphs]가 true이면 Backspace 경로로 호출된 것으로,
  /// 카드 삭제 후 앞·뒤 문단을 합친다. 카드 UI의 X 버튼은 false(카드만 삭제).
  Future<void> _confirmAndDeleteRecommendationNode(
    EditorState editorState,
    Node node, {
    bool mergeParagraphs = false,
  }) async {
    if (_isDeletingRecommendation) {
      return;
    }

    final item = ssossRecommendationItemFromNode(node);
    if (item == null) {
      return;
    }

    final context = _editorKey.currentContext;
    if (context == null) {
      return;
    }

    _isDeletingRecommendation = true;
    try {
      final deleted = await confirmDeleteSsossRecommendation(
        context,
        item: item,
        onDelete: widget.onRecommendationDelete,
        config: widget.recommendationDeleteConfig ??
            const SsossRecommendationCardDeleteConfig(),
      );

      if (!deleted || !mounted) {
        return;
      }

      if (mergeParagraphs) {
        await _deleteRecommendationAndMergeParagraphs(editorState, node);
      } else {
        final transaction = editorState.transaction..deleteNode(node);
        await editorState.apply(transaction);
      }
      widget.onRecommendationDeleted?.call(item);
    } finally {
      _isDeletingRecommendation = false;
    }
  }

  /// 커스텀 Backspace 핸들러. 표준 병합보다 먼저 실행된다.
  ///
  /// 확인 시 카드 삭제 + 문단 병합, 취소 시 아무 변화 없이 handled를 반환해
  /// AppFlowy 기본 Backspace(문단 건너뛰기 병합)가 실행되지 않게 한다.
  KeyEventResult _handleRecommendationBackspace(EditorState editorState) {
    final node = _findRecommendationNodeForBackspace(editorState);
    if (node == null) {
      return KeyEventResult.ignored;
    }

    unawaited(
      _confirmAndDeleteRecommendationNode(
        editorState,
        node,
        mergeParagraphs: true,
      ),
    );
    return KeyEventResult.handled;
  }

  @override
  Widget build(BuildContext context) {
    final style = _resolveStyle();

    return Container(
      key: _editorKey,
      width: widget.width,
      constraints: BoxConstraints(minHeight: widget.minHeight),
      padding: widget.padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? AppColors.white,
        borderRadius: widget.borderRadius ?? BorderRadius.circular(12),
        border: Border.all(color: style.borderColor),
        boxShadow: _resolveState() == SsossContentsEditCardState.pressed
            ? const [
                BoxShadow(
                  color: Color(0x4DFF9E70),
                  blurRadius: 3,
                ),
              ]
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: IntrinsicHeight(
              child: AppFlowyEditor(
                key: ValueKey(_editorState),
                editorState: _editorState,
                editorScrollController: _editorScrollController,
                editorStyle: _editorStyle,
                focusNode: _editorFocusNode,
                editable: widget.enabled && !widget.readOnly,
                autoFocus: false,
                shrinkWrap: true,
                blockComponentBuilders: _buildBlockComponentBuilders(),
                // ssoss 핸들러를 standard 이벤트보다 앞에 둔다.
                commandShortcutEvents: [
                  CommandShortcutEvent(
                    key: 'ssoss recommendation backspace',
                    command: 'backspace',
                    getDescription: () => 'ssoss recommendation backspace',
                    handler: _handleRecommendationBackspace,
                  ),
                  ...standardCommandShortcutEvents,
                ],
              ),
            ),
          ),
          const SizedBox(height: 36),
          _CounterText(
            current: _textLength,
            max: widget.maxLength,
            isError: _resolveState() == SsossContentsEditCardState.error,
            currentColor: widget.counterColor ?? style.counterColor,
            mutedColor: widget.counterMutedColor ?? AppColors.neutral300,
            textStyle: widget.counterStyle,
          ),
        ],
      ),
    );
  }
}

class _CounterText extends StatelessWidget {
  const _CounterText({
    required this.current,
    required this.max,
    required this.isError,
    required this.currentColor,
    required this.mutedColor,
    this.textStyle,
  });

  final int current;
  final int max;
  final bool isError;
  final Color currentColor;
  final Color mutedColor;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final baseStyle = textStyle ?? AppTextStyles.b6;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppText(
          '$current',
          style: baseStyle.copyWith(
            color: isError ? AppColors.error500 : currentColor,
          ),
        ),
        AppText(
          ' / ',
          style: baseStyle.copyWith(
            color: mutedColor,
          ),
        ),
        AppText(
          '$max',
          style: baseStyle.copyWith(
            color: mutedColor,
          ),
        ),
      ],
    );
  }
}

class _ContentsEditCardStyle {
  const _ContentsEditCardStyle({
    required this.borderColor,
    required this.textColor,
    required this.hintColor,
    required this.counterColor,
  });

  final Color borderColor;
  final Color textColor;
  final Color hintColor;
  final Color counterColor;

  static _ContentsEditCardStyle from(
    SsossContentsEditCardState state, {
    Color? borderColor,
    Color? focusedBorderColor,
    Color? errorBorderColor,
    Color? textColor,
    Color? hintColor,
    Color? errorTextColor,
  }) {
    switch (state) {
      case SsossContentsEditCardState.normal:
        return _ContentsEditCardStyle(
          borderColor: borderColor ?? AppColors.neutral200,
          textColor: textColor ?? AppColors.neutral700,
          hintColor: hintColor ?? AppColors.neutral400,
          counterColor: AppColors.neutral700,
        );
      case SsossContentsEditCardState.hover:
        return _ContentsEditCardStyle(
          borderColor: focusedBorderColor ?? AppColors.neutral600,
          textColor: textColor ?? AppColors.neutral700,
          hintColor: hintColor ?? AppColors.neutral400,
          counterColor: AppColors.neutral700,
        );
      case SsossContentsEditCardState.filled:
        return _ContentsEditCardStyle(
          borderColor: borderColor ?? AppColors.neutral200,
          textColor: textColor ?? AppColors.neutral700,
          hintColor: hintColor ?? AppColors.neutral400,
          counterColor: AppColors.neutral700,
        );
      case SsossContentsEditCardState.pressed:
        return _ContentsEditCardStyle(
          borderColor: focusedBorderColor ?? AppColors.primary200,
          textColor: textColor ?? AppColors.neutral700,
          hintColor: hintColor ?? AppColors.neutral400,
          counterColor: AppColors.neutral700,
        );
      case SsossContentsEditCardState.error:
        return _ContentsEditCardStyle(
          borderColor: errorBorderColor ?? AppColors.error500,
          textColor: errorTextColor ?? AppColors.error500,
          hintColor: errorTextColor ?? AppColors.error500,
          counterColor: AppColors.error500,
        );
    }
  }
}
