import 'package:ssoss_flutter/features/content/domain/entities/generation_detail.dart';
import 'package:ssoss_flutter/features/content/domain/entities/style_reuse_input.dart';
import 'package:ssoss_flutter/features/content/domain/usecases/poll_generation_usecase.dart';
import 'package:ssoss_flutter/features/content/domain/usecases/start_style_reuse_usecase.dart';

class RunStyleReuseGenerationUseCase {
  RunStyleReuseGenerationUseCase({
    required StartStyleReuseUseCase startStyleReuse,
    required PollGenerationUseCase pollGeneration,
  })  : _startStyleReuse = startStyleReuse,
        _pollGeneration = pollGeneration;

  final StartStyleReuseUseCase _startStyleReuse;
  final PollGenerationUseCase _pollGeneration;

  Future<GenerationDetail> call(StyleReuseInput input) async {
    final generationId = await _startStyleReuse(input);
    return _pollGeneration(generationId);
  }
}
