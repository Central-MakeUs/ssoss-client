import 'package:ssoss_flutter/core/constants/writing_tone.dart';
import 'package:ssoss_flutter/features/content/domain/entities/upload_channel.dart';
import 'package:ssoss_flutter/features/content/domain/entities/upload_purpose.dart';

/// 콘텐츠 생성 API 요청에 필요한 입력 값.
class ContentCreateInput {
  const ContentCreateInput({
    required this.channels,
    required this.purpose,
    required this.tone,
    required this.highlight,
    this.forbidden,
    this.keywords = const [],
    this.photoGuideEnabled = false,
    this.sourceContentId,
  });

  final List<UploadChannel> channels;
  final UploadPurpose purpose;
  final WritingTone tone;
  final String highlight;
  final String? forbidden;
  final List<String> keywords;
  final bool photoGuideEnabled;

  /// 원본 저장 콘텐츠 ID (다른 채널용·스타일 재사용 등 경로용).
  final String? sourceContentId;
}
