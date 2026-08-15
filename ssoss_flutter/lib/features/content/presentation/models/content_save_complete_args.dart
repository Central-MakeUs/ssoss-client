import 'package:ssoss_flutter/features/content/domain/entities/content_create_input.dart';
import 'package:ssoss_flutter/features/content/domain/entities/upload_channel.dart';
import 'package:ssoss_flutter/features/content/presentation/models/content_save_complete_mode.dart';

/// 저장 완료 화면 route extra.
class ContentSaveCompleteArgs {
  const ContentSaveCompleteArgs({
    required this.mode,
    this.sourceContentId,
    this.excludedChannels = const [],
    this.previousInput,
  });

  final ContentSaveCompleteMode mode;

  /// `continueAvailable`일 때 다른 채널용 생성에 넘길 저장된 콘텐츠 ID.
  final String? sourceContentId;

  /// 다른 채널 선택에서 제외할 채널.
  final List<UploadChannel> excludedChannels;

  /// 최초 생성 시 입력한 purpose/tone/keywords 등. 다른 채널용 생성에 재사용.
  final ContentCreateInput? previousInput;
}
