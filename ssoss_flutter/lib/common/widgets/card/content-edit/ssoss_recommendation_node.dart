import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:ssoss_flutter/common/widgets/card/ssoss_recommendation_card.dart';

/// AppFlowy 커스텀 블록 `ssoss_recommendation`의 노드 키·속성 이름.
class SsossRecommendationNodeKeys {
  const SsossRecommendationNodeKeys._();

  static const String type = 'ssoss_recommendation';
  static const String id = 'recommendation_id';
  static const String label = 'label';
  static const String title = 'title';
  static const String description = 'description';
  static const String dismissible = 'dismissible';
}

/// [SsossRecommendationCardItem]을 AppFlowy [Node]로 직렬화한다.
Node ssossRecommendationNode({
  required SsossRecommendationCardItem item,
}) {
  return Node(
    type: SsossRecommendationNodeKeys.type,
    attributes: {
      SsossRecommendationNodeKeys.id: item.id,
      SsossRecommendationNodeKeys.label: item.label,
      SsossRecommendationNodeKeys.title: item.title,
      SsossRecommendationNodeKeys.description: item.description,
      SsossRecommendationNodeKeys.dismissible: item.dismissible,
    },
  );
}

/// AppFlowy 노드 attributes에서 추천 카드 도메인 모델을 복원한다.
///
/// 필수 문자열 필드가 없으면 null을 반환해 잘못된 노드를 무시한다.
SsossRecommendationCardItem? ssossRecommendationItemFromNode(Node node) {
  if (node.type != SsossRecommendationNodeKeys.type) {
    return null;
  }

  final id = node.attributes[SsossRecommendationNodeKeys.id];
  final label = node.attributes[SsossRecommendationNodeKeys.label];
  final title = node.attributes[SsossRecommendationNodeKeys.title];
  final description = node.attributes[SsossRecommendationNodeKeys.description];

  if (id is! String ||
      label is! String ||
      title is! String ||
      description is! String) {
    return null;
  }

  return SsossRecommendationCardItem(
    id: id,
    label: label,
    title: title,
    description: description,
    dismissible: node.attributes[SsossRecommendationNodeKeys.dismissible] == true,
  );
}
