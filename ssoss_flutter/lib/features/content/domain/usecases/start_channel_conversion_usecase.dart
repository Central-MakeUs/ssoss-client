import 'package:ssoss_flutter/core/exception/app_exception.dart';
import 'package:ssoss_flutter/features/content/domain/entities/channel_conversion_input.dart';
import 'package:ssoss_flutter/features/content/domain/repositories/content_repository.dart';

class StartChannelConversionUseCase {
  StartChannelConversionUseCase(this._repository);

  final ContentRepository _repository;

  Future<int> call(ChannelConversionInput input) {
    if (input.channels.isEmpty) {
      throw const ValidationException('채널을 선택해 주세요.');
    }
    if (input.channels.length > 3) {
      throw const ValidationException('채널은 최대 3개까지 선택할 수 있어요.');
    }

    return _repository.startChannelConversion(
      ChannelConversionInput(
        contentId: input.contentId,
        contentChannelId: input.contentChannelId,
        channels: List.unmodifiable(input.channels),
      ),
    );
  }
}
