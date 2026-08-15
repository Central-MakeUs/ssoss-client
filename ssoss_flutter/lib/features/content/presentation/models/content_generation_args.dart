import 'package:ssoss_flutter/features/content/domain/entities/content_create_input.dart';
import 'package:ssoss_flutter/features/content/domain/entities/generation_detail.dart';
import 'package:ssoss_flutter/features/content/domain/entities/upload_channel.dart';
import 'package:ssoss_flutter/features/content/presentation/models/content_create_flow.dart';
import 'package:ssoss_flutter/features/new_style/presentation/models/new_style_args.dart';

/// 생성 중·결과 화면 route extra.
class ContentGenerationArgs {
  const ContentGenerationArgs({
    required this.input,
    required this.flow,
    this.styleReuseContentChannelId,
    this.newStyleArgs,
    this.completedChannels = const [],
    this.generationDetail,
  });

  final ContentCreateInput input;
  final ContentCreateFlow flow;

  /// 스타일 재사용 API 경로에 사용할 채널별 콘텐츠 ID.
  final int? styleReuseContentChannelId;

  /// 스타일 재사용 실패 복귀 시 상세 화면 복원용.
  final NewStyleArgs? newStyleArgs;

  /// 이미 저장되어 다른 채널 선택에서 제외할 채널.
  final List<UploadChannel> completedChannels;

  /// 생성 완료 후 조회 결과. 결과 화면에서 필수.
  final GenerationDetail? generationDetail;

  ContentGenerationArgs copyWith({
    ContentCreateInput? input,
    ContentCreateFlow? flow,
    int? styleReuseContentChannelId,
    NewStyleArgs? newStyleArgs,
    List<UploadChannel>? completedChannels,
    GenerationDetail? generationDetail,
  }) {
    return ContentGenerationArgs(
      input: input ?? this.input,
      flow: flow ?? this.flow,
      styleReuseContentChannelId:
          styleReuseContentChannelId ?? this.styleReuseContentChannelId,
      newStyleArgs: newStyleArgs ?? this.newStyleArgs,
      completedChannels: completedChannels ?? this.completedChannels,
      generationDetail: generationDetail ?? this.generationDetail,
    );
  }
}
