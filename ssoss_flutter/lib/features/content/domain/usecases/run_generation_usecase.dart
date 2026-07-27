import 'package:ssoss_flutter/features/content/domain/entities/content_create_input.dart';
import 'package:ssoss_flutter/features/content/domain/entities/generation_detail.dart';
import 'package:ssoss_flutter/features/content/domain/usecases/poll_generation_usecase.dart';
import 'package:ssoss_flutter/features/content/domain/usecases/start_generation_usecase.dart';

class RunGenerationUseCase {
  RunGenerationUseCase({
    required StartGenerationUseCase startGeneration,
    required PollGenerationUseCase pollGeneration,
  })  : _startGeneration = startGeneration,
        _pollGeneration = pollGeneration;

  final StartGenerationUseCase _startGeneration;
  final PollGenerationUseCase _pollGeneration;

  Future<GenerationDetail> call(ContentCreateInput input) async {
    final generationId = await _startGeneration(input);
    return _pollGeneration(generationId);
  }
}
