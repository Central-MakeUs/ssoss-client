import 'package:ssoss_flutter/core/constants/writing_tone.dart';
import 'package:ssoss_flutter/features/content/domain/entities/content_create_input.dart';
import 'package:ssoss_flutter/features/content/domain/entities/upload_channel.dart';
import 'package:ssoss_flutter/features/content/domain/entities/upload_purpose.dart';

/// 이 스타일로 새로 만들기 — 상세 입력 화면 route extra.
class NewStyleArgs {
  const NewStyleArgs({
    required this.sourceContentId,
    required this.contentChannelId,
    required this.purpose,
    required this.tone,
    required this.referenceChannel,
    required this.referenceRawText,
  });

  /// 참고 원본 저장 콘텐츠 ID.
  final String sourceContentId;

  /// 참고할 채널별 콘텐츠 ID.
  final int contentChannelId;

  /// 원본 목적.
  final UploadPurpose purpose;

  /// 원본 톤.
  final WritingTone tone;

  /// 참고 문구 출처 채널 (스타일 참고 대상).
  final UploadChannel referenceChannel;

  /// 참고 콘텐츠 이름(목록·상세의 name).
  final String referenceRawText;
}

/// 상세 입력 화면 route extra (실패 복귀 시 입력값 복원 포함).
class NewStyleDetailRouteArgs {
  const NewStyleDetailRouteArgs({
    required this.args,
    this.restoredInput,
  });

  final NewStyleArgs args;
  final ContentCreateInput? restoredInput;
}
