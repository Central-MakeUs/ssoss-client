import 'package:ssoss_flutter/features/content/domain/entities/content_channel_limits.dart';
import 'package:ssoss_flutter/features/content/domain/entities/generation_channel_result.dart';
import 'package:ssoss_flutter/features/content/domain/entities/saved_content.dart';
import 'package:ssoss_flutter/features/content/domain/repositories/content_repository.dart';

class SaveContentUseCase {
  SaveContentUseCase(this._repository);

  final ContentRepository _repository;

  Future<SavedContent> call({
    required int generationId,
    required List<GenerationChannelResult> channels,
  }) {
    ContentChannelLimits.validateChannelResults(channels);
    return _repository.saveContent(
      generationId: generationId,
      channels: channels,
    );
  }
}
