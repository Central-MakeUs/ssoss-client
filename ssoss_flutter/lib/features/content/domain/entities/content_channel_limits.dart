import 'package:ssoss_flutter/core/exception/app_exception.dart';
import 'package:ssoss_flutter/features/content/domain/entities/generation_channel_result.dart';
import 'package:ssoss_flutter/features/content/domain/entities/upload_channel.dart';

/// 채널별 콘텐츠 글자 수 상한.
///
/// [`docs/specs/content/generation-api/prd.md`](../../../../docs/specs/content/generation-api/prd.md) §4
///
/// 본문 길이는 `<photo-guide />` 태그를 제외한 화면 표시용 텍스트만 센다.
class ContentChannelLimits {
  const ContentChannelLimits._();

  static final _photoGuideTagPattern = RegExp(
    r'<photo-guide\s+title="([^"]*)"\s+description="([^"]*)"\s*/>',
  );

  static int? titleMaxLength(UploadChannel channel) =>
      channel == UploadChannel.blog ? 40 : null;

  static int bodyMaxLength(UploadChannel channel) => switch (channel) {
        UploadChannel.blog => 2000,
        UploadChannel.instagram => 700,
        UploadChannel.carrot => 400,
        UploadChannel.thread => 500,
      };

  /// 추천 사진 가이드 태그를 제외한 본문 글자 수.
  static int plainBodyLength(String body) =>
      body.replaceAll(_photoGuideTagPattern, '').length;

  static void validateChannelResult(GenerationChannelResult result) {
    final titleMax = titleMaxLength(result.channel);
    final title = result.title?.trim();
    if (titleMax != null) {
      if (title == null || title.isEmpty) {
        throw const ValidationException('제목을 입력해 주세요.');
      }
      if (title.length > titleMax) {
        throw ValidationException('제목은 $titleMax자 이내로 입력해 주세요.');
      }
    } else if (title != null && title.isNotEmpty) {
      throw const ValidationException('제목을 쓸 수 없는 채널입니다.');
    }

    final bodyMax = bodyMaxLength(result.channel);
    if (plainBodyLength(result.body) > bodyMax) {
      throw ValidationException('본문은 $bodyMax자 이내로 입력해 주세요.');
    }
  }

  static void validateChannelResults(List<GenerationChannelResult> results) {
    for (final result in results) {
      validateChannelResult(result);
    }
  }
}
