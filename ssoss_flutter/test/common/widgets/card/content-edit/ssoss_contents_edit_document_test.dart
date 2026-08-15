import 'package:flutter_test/flutter_test.dart';
import 'package:ssoss_flutter/common/widgets/card/content-edit/ssoss_contents_edit_document.dart';
import 'package:ssoss_flutter/common/widgets/card/ssoss_recommendation_card.dart';

void main() {
  const recommendation = SsossRecommendationCardItem(
    id: 'photo-guide',
    label: '추천 사진',
    title: '매장 사진',
    description: '분위기 있는 사진',
  );

  test('reset restores original blocks after text edit', () {
    final original = SsossContentsEditDocument.single(text: '원본 본문');
    final edited = original.copyWith(
      blocks: [
        const SsossContentsEditTextBlock(id: 'text-0', text: '수정된 본문'),
      ],
    );

    expect(edited.plainText, '수정된 본문');
    expect(edited.reset().plainText, '원본 본문');
    expect(edited.reset().originalBlocks, same(original.originalBlocks));
  });

  test('reset restores deleted recommendation', () {
    final original = SsossContentsEditDocument(
      blocks: [
        const SsossContentsEditTextBlock(id: 'text-0', text: '앞'),
        const SsossContentsEditRecommendationBlock(item: recommendation),
        const SsossContentsEditTextBlock(id: 'text-1', text: '뒤'),
      ],
    );
    final withoutRecommendation = original.removeRecommendation(recommendation.id);

    expect(withoutRecommendation.recommendationAnchors, isEmpty);

    final restored = withoutRecommendation.reset();
    expect(restored.blocks.length, 3);
    expect(restored.recommendationAnchors.single.id, recommendation.id);
    expect(restored.plainText, '앞뒤');
  });

  test('copyWith preserves originalBlocks for later reset', () {
    final original = SsossContentsEditDocument.fromPlainText(
      plainText: 'hello',
      anchors: [
        const SsossContentsEditRecommendationAnchor(
          offset: 2,
          item: recommendation,
        ),
      ],
    );
    final edited = original.copyWith(
      blocks: [
        const SsossContentsEditTextBlock(id: 'text-0', text: 'changed'),
      ],
    );

    expect(edited.originalBlocks, same(original.originalBlocks));
    expect(edited.reset().plainText, original.plainText);
  });
}
