import 'package:ssoss_flutter/features/content/domain/entities/upload_channel.dart';
import 'package:ssoss_flutter/features/content/presentation/models/content_edit_persist_mode.dart';
import 'package:ssoss_flutter/features/content/presentation/models/content_edit_target.dart';
import 'package:ssoss_flutter/utils/photo_guide_parser.dart';

/// 콘텐츠 편집 화면 진입 인자.
class ContentEditArgs {
  const ContentEditArgs({
    required this.channel,
    required this.target,
    this.initialTitle = '',
    this.initialBody = '',
    this.initialHashtags = const [],
    this.photoGuides = const [],
    this.persistMode = ContentEditPersistMode.none,
    this.contentId,
    this.contentChannelId,
  });

  final UploadChannel channel;
  final ContentEditTarget target;
  final String initialTitle;
  final String initialBody;
  final List<String> initialHashtags;

  /// 본문 편집 시 표시할 photo-guide 배치.
  final List<PhotoGuidePlacement> photoGuides;

  /// [ContentEditPersistMode.none] — 결과 화면 로컬 draft.
  /// [ContentEditPersistMode.put] — 상세 등 PUT.
  final ContentEditPersistMode persistMode;

  /// [persistMode] == put 일 때 필수.
  final int? contentId;

  /// [persistMode] == put 일 때 필수.
  final int? contentChannelId;
}
