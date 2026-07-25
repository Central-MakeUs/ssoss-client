import 'package:ssoss_flutter/core/exception/app_exception.dart';
import 'package:ssoss_flutter/features/content/domain/entities/content_create_input.dart';
import 'package:ssoss_flutter/features/content/domain/entities/create_content_result.dart';
import 'package:ssoss_flutter/features/content/domain/repositories/content_repository.dart';

class CreateContentUseCase {
  CreateContentUseCase(this._repository);

  final ContentRepository _repository;

  Future<CreateContentResult> call(ContentCreateInput input) {
    final hasSourceContent =
        input.sourceContentId != null && input.sourceContentId!.trim().isNotEmpty;

    final trimmedHighlight = input.highlight.trim();
    if (!hasSourceContent && trimmedHighlight.isEmpty) {
      throw const ValidationException('강조 내용을 입력해 주세요.');
    }

    final trimmedForbidden = input.forbidden?.trim();
    return _repository.createContent(
      ContentCreateInput(
        channels: input.channels,
        purpose: input.purpose,
        tone: input.tone,
        highlight: trimmedHighlight,
        forbidden: (trimmedForbidden == null || trimmedForbidden.isEmpty)
            ? null
            : trimmedForbidden,
        keywords: input.keywords,
        photoGuideEnabled: input.photoGuideEnabled,
        sourceContentId: hasSourceContent ? input.sourceContentId!.trim() : null,
      ),
    );
  }
}
