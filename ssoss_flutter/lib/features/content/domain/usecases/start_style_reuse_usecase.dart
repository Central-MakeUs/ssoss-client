import 'package:ssoss_flutter/core/exception/app_exception.dart';
import 'package:ssoss_flutter/features/content/domain/entities/style_reuse_input.dart';
import 'package:ssoss_flutter/features/content/domain/repositories/content_repository.dart';

class StartStyleReuseUseCase {
  StartStyleReuseUseCase(this._repository);

  final ContentRepository _repository;

  Future<int> call(StyleReuseInput input) {
    final trimmedHighlight = input.highlight.trim();
    if (trimmedHighlight.isEmpty) {
      throw const ValidationException('강조 내용을 입력해 주세요.');
    }

    final trimmedForbidden = input.forbidden?.trim();
    return _repository.startStyleReuse(
      StyleReuseInput(
        contentId: input.contentId,
        contentChannelId: input.contentChannelId,
        highlight: trimmedHighlight,
        forbidden: (trimmedForbidden == null || trimmedForbidden.isEmpty)
            ? null
            : trimmedForbidden,
        keywords: input.keywords,
        photoGuideEnabled: input.photoGuideEnabled,
      ),
    );
  }
}
