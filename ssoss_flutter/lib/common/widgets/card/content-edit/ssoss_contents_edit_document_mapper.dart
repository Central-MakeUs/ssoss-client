import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:ssoss_flutter/common/widgets/card/content-edit/ssoss_contents_edit_document.dart';
import 'package:ssoss_flutter/common/widgets/card/content-edit/ssoss_recommendation_node.dart';

/// [SsossContentsEditDocument] ↔ AppFlowy [Document] 변환기.
///
/// 도메인 블록 리스트와 에디터 노드 트리 사이의 경계 역할을 한다.
/// presentation/feature는 AppFlowy 타입에 직접 의존하지 않도록 한다.
///
/// AppFlowy는 Enter를 문단 노드 추가로 표현하고, 도메인 `plainText`는 `\n`을
/// 쓴다. 문단을 텍스트로 이어 붙이면 줄바꿈만 바꾼 편집이 dirty로 잡히지 않고
/// 저장 시 `\n`이 빠지므로, 변환 시 반드시 문단 ↔ `\n`을 대응시킨다.
class SsossContentsEditDocumentMapper {
  const SsossContentsEditDocumentMapper._();

  /// 도메인 문서 → AppFlowy 문서.
  ///
  /// - [SsossContentsEditTextBlock] → `\n`으로 나눈 paragraph 노드
  /// - [SsossContentsEditRecommendationBlock] → 추천 카드 커스텀 노드
  static Document toAppFlowyDocument(SsossContentsEditDocument document) {
    final children = <Node>[];

    for (final block in document.blocks) {
      switch (block) {
        case SsossContentsEditTextBlock():
          for (final line in block.text.split('\n')) {
            children.add(paragraphNode(text: line));
          }
        case SsossContentsEditRecommendationBlock():
          children.add(ssossRecommendationNode(item: block.item));
      }
    }

    if (children.isEmpty) {
      children.add(paragraphNode());
    }

    return Document(
      root: pageNode(children: children),
    );
  }

  /// AppFlowy 문서 → 도메인 문서.
  ///
  /// 루트 자식 순서를 유지하며 paragraph·추천 노드를 블록으로 역매핑한다.
  /// 연속 paragraph는 `\n`으로 이어 하나의 텍스트 블록이 된다.
  /// 추천 카드는 텍스트 블록을 나누며, 카드 전후에 임의 `\n`을 넣지 않는다.
  static SsossContentsEditDocument fromAppFlowyDocument(Document document) {
    final blocks = <SsossContentsEditBlock>[];
    var textIndex = 0;
    final pendingLines = <String>[];

    void flushText() {
      if (pendingLines.isEmpty) {
        return;
      }
      blocks.add(
        SsossContentsEditTextBlock(
          id: 'text-$textIndex',
          text: pendingLines.join('\n'),
        ),
      );
      textIndex++;
      pendingLines.clear();
    }

    for (final node in document.root.children) {
      if (node.type == ParagraphBlockKeys.type) {
        pendingLines.add(node.delta?.toPlainText() ?? '');
        continue;
      }

      final item = ssossRecommendationItemFromNode(node);
      if (item != null) {
        flushText();
        blocks.add(SsossContentsEditRecommendationBlock(item: item));
      }
    }

    flushText();

    if (blocks.isEmpty) {
      blocks.add(const SsossContentsEditTextBlock(id: 'text-0'));
    }

    return SsossContentsEditDocument(blocks: blocks);
  }

  /// 글자 수 카운터용. 추천 카드는 제외하고 텍스트 문단만 합산한다.
  ///
  /// 연속 문단 사이의 `\n`도 포함해 [SsossContentsEditDocument.plainText]와
  /// 길이를 맞춘다.
  static int plainTextLength(Document document) {
    return fromAppFlowyDocument(document).plainText.length;
  }
}
