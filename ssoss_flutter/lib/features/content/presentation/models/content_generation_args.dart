import 'package:ssoss_flutter/features/content/domain/entities/content_create_input.dart';
import 'package:ssoss_flutter/features/content/domain/entities/upload_channel.dart';
import 'package:ssoss_flutter/features/content/presentation/models/content_create_flow.dart';

/// 생성 중·결과 화면 route extra.
class ContentGenerationArgs {
  const ContentGenerationArgs({
    required this.input,
    required this.flow,
    this.completedChannels = const [],
  });

  final ContentCreateInput input;
  final ContentCreateFlow flow;

  /// 이미 저장되어 다른 채널 선택에서 제외할 채널.
  final List<UploadChannel> completedChannels;
}
