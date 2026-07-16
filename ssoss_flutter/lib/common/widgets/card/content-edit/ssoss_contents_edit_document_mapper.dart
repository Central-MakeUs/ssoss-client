import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:ssoss_flutter/common/widgets/card/content-edit/ssoss_contents_edit_document.dart';
import 'package:ssoss_flutter/common/widgets/card/content-edit/ssoss_recommendation_node.dart';

/// [SsossContentsEditDocument] ↔ AppFlowy [Document] 변환기.
///
/// 도메인 블록 리스트와 에디터 노드 트리 사이의 경계 역할을 한다.
/// presentation/feature는 AppFlowy 타입에 직접 의존하지 않도록 한다.
class SsossContentsEditDocumentMapper {
  const SsossContentsEditDocumentMapper._();

  /// 도메인 문서 → AppFlowy 문서.
  ///
  /// - [SsossContentsEditTextBlock] → paragraph 노드
  /// - [SsossContentsEditRecommendationBlock] → 추천 카드 커스텀 노드
  static Document toAppFlowyDocument(SsossContentsEditDocument document) {
    final children = <Node>[];

    for (final block in document.blocks) {
      switch (block) {
        case SsossContentsEditTextBlock():
          children.add(
            paragraphNode(text: block.text),
          );
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
  static SsossContentsEditDocument fromAppFlowyDocument(Document document) {
    final blocks = <SsossContentsEditBlock>[];
    var textIndex = 0;

    for (final node in document.root.children) {
      if (node.type == ParagraphBlockKeys.type) {
        blocks.add(
          SsossContentsEditTextBlock(
            id: 'text-$textIndex',
            text: node.delta?.toPlainText() ?? '',
          ),
        );
        textIndex++;
        continue;
      }

      final item = ssossRecommendationItemFromNode(node);
      if (item != null) {
        blocks.add(SsossContentsEditRecommendationBlock(item: item));
      }
    }

    if (blocks.isEmpty) {
      blocks.add(const SsossContentsEditTextBlock(id: 'text-0'));
    }

    return SsossContentsEditDocument(blocks: blocks);
  }

  /// 글자 수 카운터용. 추천 카드는 제외하고 텍스트 문단만 합산한다.
  static int plainTextLength(Document document) {
    var length = 0;
    for (final node in document.root.children) {
      if (node.type == ParagraphBlockKeys.type) {
        length += node.delta?.toPlainText().length ?? 0;
      }
    }
    return length;
  }
}
