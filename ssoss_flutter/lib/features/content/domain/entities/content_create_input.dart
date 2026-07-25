import 'package:ssoss_flutter/features/content/domain/entities/content_tone.dart';
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
  final ContentTone tone;
  final String highlight;
  final String? forbidden;
  final List<String> keywords;
  final bool photoGuideEnabled;

  /// 다른 채널용 생성 시 원문으로 사용할 저장된 콘텐츠 ID.
  final String? sourceContentId;
}
