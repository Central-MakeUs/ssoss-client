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
  });

  final List<UploadChannel> channels;
  final UploadPurpose purpose;
  final ContentTone tone;
  final String highlight;
  final String? forbidden;
  final List<String> keywords;
  final bool photoGuideEnabled;
}
