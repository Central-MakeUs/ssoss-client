import 'package:ssoss_flutter/features/content/domain/entities/content_channel_content.dart';
import 'package:ssoss_flutter/features/content/domain/entities/content_create_input.dart';
import 'package:ssoss_flutter/features/content/domain/entities/generation_channel_result.dart';
import 'package:ssoss_flutter/features/content/domain/entities/generation_detail.dart';
import 'package:ssoss_flutter/features/content/domain/entities/saved_content.dart';

/// Content 도메인 repository 계약.
abstract class ContentRepository {
  /// 생성 작업을 시작하고 작업 id 를 반환한다.
  Future<int> startGeneration(ContentCreateInput input);

  /// 생성 작업 상태와 결과를 조회한다.
  Future<GenerationDetail> getGeneration(int generationId);

  /// 생성 결과(수정본 포함)를 콘텐츠로 저장한다.
  Future<SavedContent> saveContent({
    required int generationId,
    required List<GenerationChannelResult> channels,
  });

  /// 저장한 콘텐츠의 채널 하나를 편집한다.
  Future<ContentChannelContent> editChannel({
    required int contentId,
    required int contentChannelId,
    required GenerationChannelResult channel,
  });

  /// 진행 중인 생성 요청·폴링을 취소한다.
  void cancelGeneration();
}
