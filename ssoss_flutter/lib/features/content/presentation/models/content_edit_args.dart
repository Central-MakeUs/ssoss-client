import 'package:ssoss_flutter/common/widgets/card/ssoss_recommendation_card.dart';
import 'package:ssoss_flutter/features/content/domain/entities/upload_channel.dart';
import 'package:ssoss_flutter/features/content/presentation/models/content_edit_target.dart';

/// 콘텐츠 편집 화면 진입 인자.
class ContentEditArgs {
  const ContentEditArgs({
    required this.channel,
    required this.target,
    this.initialTitle = '',
    this.initialBody = '',
    this.initialHashtags = const [],
    this.photoGuideEnabled = false,
    this.recommendation,
  });

  final UploadChannel channel;
  final ContentEditTarget target;
  final String initialTitle;
  final String initialBody;
  final List<String> initialHashtags;
  final bool photoGuideEnabled;
  final SsossRecommendationCardItem? recommendation;
}
