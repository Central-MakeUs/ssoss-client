import 'package:ssoss_flutter/common/widgets/card/ssoss_recommendation_card.dart';

/// 읽기용 콘텐츠 카드 본문 블록. 순서가 곧 화면 배치다.
sealed class SsossContentsCardBlock {
  const SsossContentsCardBlock();
}

class SsossContentsCardTextBlock extends SsossContentsCardBlock {
  const SsossContentsCardTextBlock(this.text);

  final String text;
}

class SsossContentsCardRecommendationBlock extends SsossContentsCardBlock {
  const SsossContentsCardRecommendationBlock(this.item);

  final SsossRecommendationCardItem item;
}

class SsossContentsCardHashtagsBlock extends SsossContentsCardBlock {
  const SsossContentsCardHashtagsBlock(
    this.hashtags, {
    this.displayAsPlainText = false,
  });

  final List<String> hashtags;

  /// true이면 칩 대신 본문과 동일한 평문 스타일로 표시한다. (블로그 본문 하단 등)
  final bool displayAsPlainText;
}
