import 'package:ssoss_flutter/features/content/domain/entities/generation_detail.dart';
import 'package:ssoss_flutter/features/content/domain/entities/generation_status.dart';
import 'package:ssoss_flutter/features/content/domain/repositories/content_repository.dart';

class PollGenerationUseCase {
  PollGenerationUseCase(this._repository);

  final ContentRepository _repository;

  static const pollInterval = Duration(milliseconds: 2500);
  static const maxWait = Duration(seconds: 65);

  /// [generationId] 작업이 종료 상태가 될 때까지 폴링한다.
  Future<GenerationDetail> call(int generationId) async {
    final deadline = DateTime.now().add(maxWait);
    while (DateTime.now().isBefore(deadline)) {
      final detail = await _repository.getGeneration(generationId);
      if (detail.status != GenerationStatus.inProgress) {
        return detail;
      }
      await Future<void>.delayed(pollInterval);
    }
    return _repository.getGeneration(generationId);
  }
}
