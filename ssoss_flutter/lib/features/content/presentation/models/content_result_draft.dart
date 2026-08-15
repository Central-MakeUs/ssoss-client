import 'package:ssoss_flutter/common/widgets/input/ssoss_hashtag_input.dart';
import 'package:ssoss_flutter/features/content/domain/entities/generation_channel_result.dart';
import 'package:ssoss_flutter/features/content/domain/entities/generation_detail.dart';
import 'package:ssoss_flutter/features/content/domain/entities/upload_channel.dart';
import 'package:ssoss_flutter/utils/photo_guide_parser.dart';

/// 채널별 결과 draft (로컬 편집 반영용).
class ContentChannelDraft {
  const ContentChannelDraft({
    required this.body,
    this.title,
    this.hashtags = const [],
    this.photoGuides = const [],
  });

  final String? title;

  /// 태그 제거된 화면용 본문.
  final String body;
  final List<String> hashtags;

  /// displayBody 기준 추천 사진 가이드 위치.
  final List<PhotoGuidePlacement> photoGuides;

  bool get showPhotoGuide => photoGuides.isNotEmpty;

  ContentChannelDraft copyWith({
    String? title,
    String? body,
    List<String>? hashtags,
    List<PhotoGuidePlacement>? photoGuides,
  }) {
    return ContentChannelDraft(
      title: title ?? this.title,
      body: body ?? this.body,
      hashtags: hashtags ?? this.hashtags,
      photoGuides: photoGuides ?? this.photoGuides,
    );
  }
}

/// 결과 화면 전체 draft.
class ContentResultDraft {
  const ContentResultDraft({
    required this.byChannel,
  });

  final Map<UploadChannel, ContentChannelDraft> byChannel;

  ContentChannelDraft forChannel(UploadChannel channel) {
    final draft = byChannel[channel];
    if (draft == null) {
      throw StateError('Missing draft for $channel');
    }
    return draft;
  }

  ContentResultDraft updateChannel(
    UploadChannel channel,
    ContentChannelDraft draft,
  ) {
    return ContentResultDraft(
      byChannel: {
        ...byChannel,
        channel: draft,
      },
    );
  }

  factory ContentResultDraft.fromGenerationDetail(GenerationDetail detail) {
    final map = <UploadChannel, ContentChannelDraft>{};
    for (final result in detail.results) {
      map[result.channel] = _draftFromResult(result);
    }
    return ContentResultDraft(byChannel: map);
  }

  static ContentChannelDraft _draftFromResult(GenerationChannelResult result) {
    final parsed = PhotoGuideParser.parse(result.body);
    return ContentChannelDraft(
      title: result.title,
      body: parsed.displayBody,
      hashtags: SsossHashtagNormalizer.stripAll(result.hashtags),
      photoGuides: parsed.placements,
    );
  }

  /// 저장(POST)용 채널별 완전체. 작업의 전 채널을 포함하며,
  /// 각 원소는 title/body/hashtags를 통째로 담는다.
  ///
  /// - 블로그: trim된 title (빈/공백이면 null → 직렬화 시 omit)
  /// - 그 외: title 없음
  /// - hashtags: 화면에 보이는 `#` 포함 형태로 전송
  /// - body: 남은 photo-guide 태그를 재삽입한 API 본문
  List<GenerationChannelResult> toGenerationChannelResults() {
    return byChannel.entries
        .map((entry) {
          final channel = entry.key;
          final draft = entry.value;
          final trimmed = draft.title?.trim();
          final title = channel == UploadChannel.blog
              ? (trimmed == null || trimmed.isEmpty ? null : trimmed)
              : null;
          return GenerationChannelResult(
            channel: channel,
            title: title,
            body: PhotoGuideParser.serialize(
              draft.body,
              placements: draft.photoGuides,
            ),
            hashtags: [
              for (final tag in draft.hashtags)
                SsossHashtagNormalizer.display(tag),
            ],
          );
        })
        .toList(growable: false);
  }
}
