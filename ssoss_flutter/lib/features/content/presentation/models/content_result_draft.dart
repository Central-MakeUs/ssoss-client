import 'package:ssoss_flutter/common/widgets/input/ssoss_hashtag_input.dart';
import 'package:ssoss_flutter/features/content/domain/entities/upload_channel.dart';
import 'package:ssoss_flutter/features/content/presentation/models/content_result_dummy.dart';

/// 채널별 결과 draft (로컬 편집 반영용).
class ContentChannelDraft {
  const ContentChannelDraft({
    required this.body,
    this.title,
    this.hashtags = const [],
    this.showPhotoGuide = false,
  });

  final String? title;
  final String body;
  final List<String> hashtags;
  final bool showPhotoGuide;

  ContentChannelDraft copyWith({
    String? title,
    String? body,
    List<String>? hashtags,
    bool? showPhotoGuide,
  }) {
    return ContentChannelDraft(
      title: title ?? this.title,
      body: body ?? this.body,
      hashtags: hashtags ?? this.hashtags,
      showPhotoGuide: showPhotoGuide ?? this.showPhotoGuide,
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

  /// 더미 + 생성 입력 기준으로 초기 draft를 만든다.
  factory ContentResultDraft.fromChannels({
    required List<UploadChannel> channels,
    required bool photoGuideEnabled,
    required bool compact,
  }) {
    final map = <UploadChannel, ContentChannelDraft>{};
    for (final channel in channels) {
      map[channel] = ContentChannelDraft(
        title: channel == UploadChannel.blog
            ? ContentResultDummy.blogTitle
            : null,
        body: ContentResultDummy.bodyFor(channel, compact: compact),
        hashtags: channel == UploadChannel.instagram
            ? SsossHashtagNormalizer.stripAll(
                ContentResultDummy.instagramHashtags,
              )
            : const [],
        showPhotoGuide: photoGuideEnabled,
      );
    }
    return ContentResultDraft(byChannel: map);
  }
}
