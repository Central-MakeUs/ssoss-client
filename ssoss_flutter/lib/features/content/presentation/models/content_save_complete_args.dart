import 'package:ssoss_flutter/features/content/domain/entities/content_create_input.dart';
import 'package:ssoss_flutter/features/content/presentation/models/content_save_complete_mode.dart';

/// 저장 완료 화면 route extra.
class ContentSaveCompleteArgs {
  const ContentSaveCompleteArgs({
    required this.mode,
    this.previousInput,
  });

  final ContentSaveCompleteMode mode;

  /// `continueAvailable`일 때 다른 채널용 생성에 넘길 이전 입력.
  final ContentCreateInput? previousInput;
}
