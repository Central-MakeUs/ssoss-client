import 'package:ssoss_flutter/features/content/domain/entities/content_create_input.dart';
import 'package:ssoss_flutter/features/content/domain/entities/create_content_result.dart';

/// Content 도메인 repository 계약.
abstract class ContentRepository {
  /// 수집된 입력으로 AI 콘텐츠 생성을 요청한다.
  Future<CreateContentResult> createContent(ContentCreateInput input);

  /// 진행 중인 생성 요청을 취소한다.
  void cancelCreate();
}
