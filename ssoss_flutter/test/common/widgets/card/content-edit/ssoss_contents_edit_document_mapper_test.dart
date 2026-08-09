import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ssoss_flutter/common/widgets/card/content-edit/ssoss_contents_edit_document.dart';
import 'package:ssoss_flutter/common/widgets/card/content-edit/ssoss_contents_edit_document_mapper.dart';
import 'package:ssoss_flutter/common/widgets/card/content-edit/ssoss_recommendation_node.dart';
import 'package:ssoss_flutter/common/widgets/card/ssoss_recommendation_card.dart';

void main() {
  const recommendation = SsossRecommendationCardItem(
    id: 'photo-guide-0',
    label: '추천 사진',
    title: '매장 사진',
    description: '분위기 있는 사진',
  );

  group('SsossContentsEditDocumentMapper', () {
    test('round-trips newlines inside a single text block', () {
      final original = SsossContentsEditDocument.fromPlainText(
        plainText: '첫 줄\n둘째 줄\n\n빈 줄 다음',
      );

      final mapped = SsossContentsEditDocumentMapper.fromAppFlowyDocument(
        SsossContentsEditDocumentMapper.toAppFlowyDocument(original),
      );

      expect(mapped.plainText, original.plainText);
      expect(mapped.blocks, hasLength(1));
    });

    test('joins consecutive AppFlowy paragraphs with newlines', () {
      final appflowy = Document(
        root: pageNode(
          children: [
            paragraphNode(text: 'Hello'),
            paragraphNode(text: 'World'),
          ],
        ),
      );

      final document =
          SsossContentsEditDocumentMapper.fromAppFlowyDocument(appflowy);

      expect(document.plainText, 'Hello\nWorld');
      expect(
        SsossContentsEditDocumentMapper.plainTextLength(appflowy),
        'Hello\nWorld'.length,
      );
    });

    test('does not insert a newline across a recommendation card', () {
      final original = SsossContentsEditDocument.fromPlainText(
        plainText: '앞뒤',
        anchors: const [
          SsossContentsEditRecommendationAnchor(
            offset: 1,
            item: recommendation,
          ),
        ],
      );

      final mapped = SsossContentsEditDocumentMapper.fromAppFlowyDocument(
        SsossContentsEditDocumentMapper.toAppFlowyDocument(original),
      );

      expect(mapped.plainText, '앞뒤');
      expect(mapped.recommendationAnchors.single.offset, 1);
      expect(mapped.recommendationAnchors.single.id, recommendation.id);
    });

    test('preserves newline immediately before a recommendation', () {
      final original = SsossContentsEditDocument.fromPlainText(
        plainText: '앞\n뒤',
        anchors: const [
          SsossContentsEditRecommendationAnchor(
            offset: 2,
            item: recommendation,
          ),
        ],
      );

      final mapped = SsossContentsEditDocumentMapper.fromAppFlowyDocument(
        SsossContentsEditDocumentMapper.toAppFlowyDocument(original),
      );

      expect(mapped.plainText, '앞\n뒤');
      expect(mapped.recommendationAnchors.single.offset, 2);
    });

    test('newline-only paragraph split changes plainText', () {
      const originalText = 'Hello World';
      final original = SsossContentsEditDocument.fromPlainText(
        plainText: originalText,
      );
      final afterEnter = Document(
        root: pageNode(
          children: [
            paragraphNode(text: 'Hello'),
            paragraphNode(text: 'World'),
          ],
        ),
      );

      final edited =
          SsossContentsEditDocumentMapper.fromAppFlowyDocument(afterEnter);

      expect(original.plainText, originalText);
      expect(edited.plainText, 'Hello\nWorld');
      expect(edited.plainText, isNot(original.plainText));
    });

    test('toAppFlowy splits text newlines into paragraph nodes', () {
      final document = SsossContentsEditDocument.fromPlainText(
        plainText: 'A\nB',
      );
      final appflowy =
          SsossContentsEditDocumentMapper.toAppFlowyDocument(document);
      final paragraphs = appflowy.root.children
          .where((node) => node.type == ParagraphBlockKeys.type)
          .toList();

      expect(paragraphs, hasLength(2));
      expect(paragraphs[0].delta?.toPlainText(), 'A');
      expect(paragraphs[1].delta?.toPlainText(), 'B');
      expect(
        appflowy.root.children
            .any((node) => node.type == SsossRecommendationNodeKeys.type),
        isFalse,
      );
    });
  });
}
