import 'package:ssoss_flutter/features/content/domain/entities/content_tone.dart';
import 'package:ssoss_flutter/features/content/domain/entities/generation_channel_result.dart';
import 'package:ssoss_flutter/features/content/domain/entities/generation_status.dart';
import 'package:ssoss_flutter/features/content/domain/entities/upload_purpose.dart';

/// 생성 작업 조회 결과.
class GenerationDetail {
  const GenerationDetail({
    required this.generationId,
    required this.status,
    required this.purpose,
    required this.tone,
    required this.keywords,
    required this.results,
  });

  final int generationId;
  final GenerationStatus status;
  final UploadPurpose purpose;
  final ContentTone tone;
  final List<String> keywords;
  final List<GenerationChannelResult> results;
}
