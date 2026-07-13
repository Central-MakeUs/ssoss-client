import 'package:ssoss_flutter/common/widgets/card/ssoss_recommendation_card.dart';

/// 편집 카드 본문. 서버가 내려준 블록 순서대로 텍스트·추천 카드를 배치한다.
class SsossContentsEditDocument {
  const SsossContentsEditDocument({
    required this.blocks,
  });

  final List<SsossContentsEditBlock> blocks;

  factory SsossContentsEditDocument.single({
    String id = 'text-0',
    String text = '',
  }) {
    return SsossContentsEditDocument(
      blocks: [
        SsossContentsEditTextBlock(id: id, text: text),
      ],
    );
  }

  factory SsossContentsEditDocument.fromPlainText({
    required String plainText,
    List<SsossContentsEditRecommendationAnchor> anchors = const [],
  }) {
    return SsossContentsEditDocument(
      blocks: toBlocks(plainText: plainText, anchors: anchors),
    );
  }

  SsossContentsEditDocument copyWith({
    List<SsossContentsEditBlock>? blocks,
  }) {
    return SsossContentsEditDocument(
      blocks: blocks ?? this.blocks,
    );
  }

  /// 텍스트 블록만 이어 붙인 plain text. 추천 카드는 글자 수에 포함하지 않는다.
  String get plainText {
    final buffer = StringBuffer();
    for (final block in blocks) {
      if (block is SsossContentsEditTextBlock) {
        buffer.write(block.text);
      }
    }
    return buffer.toString();
  }

  int get textLength => plainText.length;

  List<SsossContentsEditRecommendationAnchor> get recommendationAnchors {
    return parseAnchors(blocks);
  }

  SsossContentsEditDocument removeRecommendation(String recommendationId) {
    return copyWith(
      blocks: blocks
          .where(
            (block) =>
                block is! SsossContentsEditRecommendationBlock ||
                block.item.id != recommendationId,
          )
          .toList(growable: false),
    );
  }

  /// 블록 순회하며 plain text 오프셋 기준으로 추천 카드 앵커를 계산한다.
  static List<SsossContentsEditRecommendationAnchor> parseAnchors(
    List<SsossContentsEditBlock> blocks,
  ) {
    final anchors = <SsossContentsEditRecommendationAnchor>[];
    var offset = 0;

    for (final block in blocks) {
      switch (block) {
        case SsossContentsEditTextBlock():
          offset += block.text.length;
        case SsossContentsEditRecommendationBlock():
          anchors.add(
            SsossContentsEditRecommendationAnchor(
              offset: offset,
              item: block.item,
            ),
          );
      }
    }

    return anchors;
  }

  /// plain text + 앵커 목록을 교차 배치된 블록 리스트로 분할한다.
  ///
  /// 앵커 offset은 합쳐진 텍스트 기준이며, offset 위치에 추천 카드가 삽입된다.
  static List<SsossContentsEditBlock> toBlocks({
    required String plainText,
    required List<SsossContentsEditRecommendationAnchor> anchors,
  }) {
    if (anchors.isEmpty) {
      return [
        SsossContentsEditTextBlock(id: 'text-0', text: plainText),
      ];
    }

    final sortedAnchors = List<SsossContentsEditRecommendationAnchor>.from(
      anchors,
    )..sort((a, b) => a.offset.compareTo(b.offset));

    final blocks = <SsossContentsEditBlock>[];
    var cursor = 0;
    var textIndex = 0;

    for (final anchor in sortedAnchors) {
      final safeOffset = anchor.offset.clamp(0, plainText.length);
      if (safeOffset > cursor) {
        blocks.add(
          SsossContentsEditTextBlock(
            id: 'text-$textIndex',
            text: plainText.substring(cursor, safeOffset),
          ),
        );
        textIndex++;
      }

      blocks.add(
        SsossContentsEditRecommendationBlock(item: anchor.item),
      );
      cursor = safeOffset;
    }

    if (cursor < plainText.length) {
      blocks.add(
        SsossContentsEditTextBlock(
          id: 'text-$textIndex',
          text: plainText.substring(cursor),
        ),
      );
    }

    return blocks;
  }
}

sealed class SsossContentsEditBlock {
  const SsossContentsEditBlock();
}

/// 편집 가능한 텍스트 구간. 추천 카드 사이사이에 여러 개 존재할 수 있다.
final class SsossContentsEditTextBlock extends SsossContentsEditBlock {
  const SsossContentsEditTextBlock({
    required this.id,
    this.text = '',
  });

  final String id;
  final String text;

  SsossContentsEditTextBlock copyWith({
    String? id,
    String? text,
  }) {
    return SsossContentsEditTextBlock(
      id: id ?? this.id,
      text: text ?? this.text,
    );
  }
}

/// 편집 영역에 삽입된 추천 카드(커스텀 컨테이너) 블록.
final class SsossContentsEditRecommendationBlock extends SsossContentsEditBlock {
  const SsossContentsEditRecommendationBlock({
    required this.item,
  });

  final SsossRecommendationCardItem item;
}

/// [plainText] 기준으로 추천 카드가 삽입되는 위치.
final class SsossContentsEditRecommendationAnchor {
  const SsossContentsEditRecommendationAnchor({
    required this.offset,
    required this.item,
  });

  final int offset;
  final SsossRecommendationCardItem item;

  String get id => item.id;

  SsossContentsEditRecommendationAnchor copyWith({
    int? offset,
    SsossRecommendationCardItem? item,
  }) {
    return SsossContentsEditRecommendationAnchor(
      offset: offset ?? this.offset,
      item: item ?? this.item,
    );
  }
}
