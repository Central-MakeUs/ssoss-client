import 'package:ssoss_flutter/core/constants/writing_tone.dart';
import 'package:ssoss_flutter/features/content/domain/entities/upload_channel.dart';
import 'package:ssoss_flutter/features/content/domain/entities/upload_purpose.dart';

/// 이 스타일로 새로 만들기 — 채널 선택 화면 route extra.
class NewStyleArgs {
  const NewStyleArgs({
    required this.sourceContentId,
    required this.purpose,
    required this.tone,
    required this.referenceChannel,
    required this.referenceRawText,
  });

  /// 참고 원본 저장 콘텐츠 ID.
  final String sourceContentId;

  /// 원본 목적 (추후 ContentCreateInput 조립용).
  final UploadPurpose purpose;

  /// 원본 톤 (추후 ContentCreateInput 조립용).
  final WritingTone tone;

  /// 참고 문구 출처 채널 (스타일 참고 대상).
  final UploadChannel referenceChannel;

  /// 참고 콘텐츠 이름(목록·상세의 name).
  final String referenceRawText;
}

/// 이 스타일로 새로 만들기 — 상세 입력 화면 route extra.
class NewStyleDetailArgs {
  const NewStyleDetailArgs({
    required this.source,
    required this.channels,
  });

  final NewStyleArgs source;
  final List<UploadChannel> channels;
}
