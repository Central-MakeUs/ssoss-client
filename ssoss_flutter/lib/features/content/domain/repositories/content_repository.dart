import 'package:ssoss_flutter/features/content/domain/entities/content_channel_content.dart';
import 'package:ssoss_flutter/features/content/domain/entities/content_create_input.dart';
import 'package:ssoss_flutter/features/content/domain/entities/content_detail.dart';
import 'package:ssoss_flutter/features/content/domain/entities/content_list_page.dart';
import 'package:ssoss_flutter/features/content/domain/entities/content_sort.dart';
import 'package:ssoss_flutter/features/content/domain/entities/generation_channel_result.dart';
import 'package:ssoss_flutter/features/content/domain/entities/generation_detail.dart';
import 'package:ssoss_flutter/features/content/domain/entities/saved_content.dart';
import 'package:ssoss_flutter/features/content/domain/entities/upload_channel.dart';

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

  /// 저장 콘텐츠 목록을 조회한다.
  ///
  /// [sort] 기본값은 [ContentSort.latest](저장 시각 최신순).
  Future<ContentListPage> listContents({
    UploadChannel? channel,
    ContentSort sort = ContentSort.latest,
    int page = 0,
    int size = 20,
  });

  /// 저장 콘텐츠 상세를 조회한다.
  Future<ContentDetail> getContent(int contentId);

  /// 저장 콘텐츠 1건을 삭제한다.
  Future<void> deleteContent(int contentId);

  /// 진행 중인 생성 요청·폴링을 취소한다.
  void cancelGeneration();
}
