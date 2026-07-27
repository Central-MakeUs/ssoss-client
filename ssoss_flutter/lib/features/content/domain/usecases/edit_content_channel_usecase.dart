import 'package:ssoss_flutter/features/content/domain/entities/content_channel_limits.dart';
import 'package:ssoss_flutter/features/content/domain/entities/content_channel_content.dart';
import 'package:ssoss_flutter/features/content/domain/entities/generation_channel_result.dart';
import 'package:ssoss_flutter/features/content/domain/repositories/content_repository.dart';

class EditContentChannelUseCase {
  EditContentChannelUseCase(this._repository);

  final ContentRepository _repository;

  Future<ContentChannelContent> call({
    required int contentId,
    required int contentChannelId,
    required GenerationChannelResult channel,
  }) {
    ContentChannelLimits.validateChannelResult(channel);
    return _repository.editChannel(
      contentId: contentId,
      contentChannelId: contentChannelId,
      channel: channel,
    );
  }
}
