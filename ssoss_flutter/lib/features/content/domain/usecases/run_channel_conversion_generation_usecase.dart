import 'package:ssoss_flutter/features/content/domain/entities/channel_conversion_input.dart';
import 'package:ssoss_flutter/features/content/domain/entities/generation_detail.dart';
import 'package:ssoss_flutter/features/content/domain/usecases/poll_generation_usecase.dart';
import 'package:ssoss_flutter/features/content/domain/usecases/start_channel_conversion_usecase.dart';

class RunChannelConversionGenerationUseCase {
  RunChannelConversionGenerationUseCase({
    required StartChannelConversionUseCase startChannelConversion,
    required PollGenerationUseCase pollGeneration,
  })  : _startChannelConversion = startChannelConversion,
        _pollGeneration = pollGeneration;

  final StartChannelConversionUseCase _startChannelConversion;
  final PollGenerationUseCase _pollGeneration;

  Future<GenerationDetail> call(ChannelConversionInput input) async {
    final generationId = await _startChannelConversion(input);
    return _pollGeneration(generationId);
  }
}
