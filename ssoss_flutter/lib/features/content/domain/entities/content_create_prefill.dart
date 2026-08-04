import 'package:ssoss_flutter/core/constants/writing_tone.dart';

/// 콘텐츠 생성 화면에 미리 채워 넣을 저장 정보.
class ContentCreatePrefill {
  const ContentCreatePrefill({
    this.tone,
    this.forbidden,
    this.keywords = const [],
  });

  final WritingTone? tone;
  final String? forbidden;
  final List<String> keywords;

  bool get isEmpty =>
      tone == null &&
      (forbidden == null || forbidden!.isEmpty) &&
      keywords.isEmpty;
}
