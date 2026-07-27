import 'package:ssoss_flutter/common/widgets/card/content-edit/ssoss_contents_edit_document.dart';
import 'package:ssoss_flutter/common/widgets/card/ssoss_contents_card_block.dart';
import 'package:ssoss_flutter/common/widgets/card/ssoss_recommendation_card.dart';
import 'package:ssoss_flutter/utils/photo_guide_parser.dart';

const String kPhotoGuideDefaultTitle = '매장의 분위기가 담긴 사진을 추천해요.';
const String kPhotoGuideDefaultDescription =
    '방문하고 싶은 느낌을 전달하는 데 효과적이에요';

SsossRecommendationCardItem photoGuideCardItem(
  PhotoGuidePlacement placement, {
  required int index,
  bool dismissible = false,
}) {
  return SsossRecommendationCardItem(
    id: 'photo-guide-$index',
    label: '추천 사진',
    title: placement.title.isEmpty
        ? kPhotoGuideDefaultTitle
        : placement.title,
    description: placement.description.isEmpty
        ? kPhotoGuideDefaultDescription
        : placement.description,
    dismissible: dismissible,
  );
}

List<SsossContentsEditRecommendationAnchor> photoGuideEditAnchors(
  List<PhotoGuidePlacement> placements, {
  bool dismissible = true,
}) {
  return [
    for (var i = 0; i < placements.length; i++)
      SsossContentsEditRecommendationAnchor(
        offset: placements[i].displayOffset,
        item: photoGuideCardItem(
          placements[i],
          index: i,
          dismissible: dismissible,
        ),
      ),
  ];
}

/// displayBody + placements → 읽기용 카드 블록 (텍스트·추천 교차).
List<SsossContentsCardBlock> photoGuideBodyBlocks({
  required String displayBody,
  required List<PhotoGuidePlacement> placements,
}) {
  if (placements.isEmpty) {
    return [SsossContentsCardTextBlock(displayBody)];
  }

  final editBlocks = SsossContentsEditDocument.toBlocks(
    plainText: displayBody,
    anchors: photoGuideEditAnchors(placements, dismissible: false),
  );

  return [
    for (final block in editBlocks)
      switch (block) {
        SsossContentsEditTextBlock(:final text) =>
          SsossContentsCardTextBlock(text),
        SsossContentsEditRecommendationBlock(:final item) =>
          SsossContentsCardRecommendationBlock(item),
      },
  ];
}

/// 편집 문서의 남은 추천 앵커 → placements.
///
/// title/description은 [original]의 동일 id에서 가져오고,
/// offset은 문서 기준(텍스트 편집 반영)을 사용한다. 삭제된 앵커는 빠진다.
List<PhotoGuidePlacement> photoGuidesFromAnchors(
  List<SsossContentsEditRecommendationAnchor> anchors, {
  required List<PhotoGuidePlacement> original,
}) {
  final byId = <String, PhotoGuidePlacement>{
    for (var i = 0; i < original.length; i++)
      'photo-guide-$i': original[i],
  };

  return [
    for (final anchor in anchors)
      PhotoGuidePlacement(
        displayOffset: anchor.offset,
        title: byId[anchor.id]?.title ??
            (anchor.item.title == kPhotoGuideDefaultTitle
                ? ''
                : anchor.item.title),
        description: byId[anchor.id]?.description ??
            (anchor.item.description == kPhotoGuideDefaultDescription
                ? ''
                : anchor.item.description),
      ),
  ];
}
