import 'package:ssoss_flutter/features/content/domain/entities/upload_channel.dart';
import 'package:ssoss_flutter/features/content/presentation/models/content_label_mapper.dart';
import 'package:ssoss_flutter/features/content/presentation/models/content_recent_item.dart';
import 'package:ssoss_flutter/features/content/presentation/models/content_result_dummy.dart';

/// 채널별 생성 결과 프리뷰 (API 연동 전 더미).
class ContentGenerationChannelPreview {
  const ContentGenerationChannelPreview({
    required this.channel,
    required this.title,
    required this.body,
    required this.category,
    required this.tone,
    required this.tags,
  });

  final UploadChannel channel;
  final String title;
  final String body;
  final String category;
  final String tone;
  final List<String> tags;

  /// 홈 최근 목록용 표시 제목.
  /// 블로그는 [title], 그 외 채널은 본문. 모두 최대 20자(+…).
  String get recentDisplayTitle {
    final raw = channel == UploadChannel.blog
        ? title.trim()
        : body
            .trim()
            .split('\n')
            .map((line) => line.trim())
            .where((line) => line.isNotEmpty)
            .join(' ');
    if (raw.length <= 20) {
      return raw;
    }
    return '${raw.substring(0, 20)}...';
  }
}

/// 생성 단위 프리뷰. 홈 최근 목록은 1행, 대시보드는 채널별 행으로 펼친다.
class ContentGenerationPreview {
  const ContentGenerationPreview({
    required this.id,
    required this.createdAt,
    required this.channels,
  });

  final String id;
  final DateTime createdAt;
  final List<ContentGenerationChannelPreview> channels;

  List<UploadChannel> get orderedChannelEnums =>
      ContentLabelMapper.orderedChannels(
        channels.map((c) => c.channel).toList(growable: false),
      );

  ContentGenerationChannelPreview? get firstChannel {
    final ordered = orderedChannelEnums;
    if (ordered.isEmpty) {
      return null;
    }
    final first = ordered.first;
    for (final channel in channels) {
      if (channel.channel == first) {
        return channel;
      }
    }
    return null;
  }

  String get managementDate {
    final yy = (createdAt.year % 100).toString().padLeft(2, '0');
    final mm = createdAt.month.toString().padLeft(2, '0');
    final dd = createdAt.day.toString().padLeft(2, '0');
    return '$yy.$mm.$dd';
  }

  String managementItemId(UploadChannel channel) => '$id-${channel.name}';

  /// 더미 PUT용 contentId. `content-N` → N.
  int get dummyContentId {
    final match = RegExp(r'(\d+)$').firstMatch(id);
    return int.tryParse(match?.group(1) ?? '') ?? 1;
  }

  int dummyContentChannelId(UploadChannel channel) {
    final base = dummyContentId * 10;
    final index = orderedChannelEnums.indexOf(channel);
    return base + (index < 0 ? 0 : index);
  }
}

/// API 연동 전 홈·대시보드 공통 더미.
/// TODO: API 연동 후 제거하고 repository 조회 결과를 사용한다.
final List<ContentGenerationPreview> contentGenerationPreviews =
    <ContentGenerationPreview>[
  ContentGenerationPreview(
    id: 'content-1',
    createdAt: DateTime(2026, 9, 1),
    channels: const [
      ContentGenerationChannelPreview(
        channel: UploadChannel.blog,
        title: '을지로 크루아상 맛집 | 겹겹이 살아있는 결, 보니스커피',
        body: ContentResultDummy.blogBody,
        category: '정보성',
        tone: '일상형',
        tags: ['#을지로카페', '#을지로크루아상'],
      ),
    ],
  ),
  ContentGenerationPreview(
    id: 'content-2',
    createdAt: DateTime(2026, 8, 23),
    channels: const [
      ContentGenerationChannelPreview(
        channel: UploadChannel.blog,
        title: '신메뉴 앙버터 토스트 출시! 선착순 이벤트',
        body: ContentResultDummy.blogBody,
        category: '이벤트/할인',
        tone: '일상형',
        tags: ['#을지로카페', '#을지로토스트'],
      ),
      ContentGenerationChannelPreview(
        channel: UploadChannel.carrot,
        title: '을지로에서 크루아상 찾으신다면 저희 가게로 오세요 🥐',
        body: ContentResultDummy.carrotBody,
        category: '신메뉴/홍보',
        tone: '홍보형',
        tags: ['#을지로맛집', '#보니스커피'],
      ),
      ContentGenerationChannelPreview(
        channel: UploadChannel.thread,
        title: '매일 새벽부터 만드는 버터 크루아상, 오늘도 오전에 완판됐어요',
        body: ContentResultDummy.threadBody,
        category: '정보성',
        tone: '정보형',
        tags: ['#을지로디저트', '#서울카페'],
      ),
    ],
  ),
  ContentGenerationPreview(
    id: 'content-3',
    createdAt: DateTime(2026, 8, 20),
    channels: const [
      ContentGenerationChannelPreview(
        channel: UploadChannel.instagram,
        title: '겹겹이 살아있는 결 🥐 매일 아침 직접 구워내는 을지로 크루아상',
        body: ContentResultDummy.shortSnsBody,
        category: '정보성',
        tone: '감성형',
        tags: ['#을지로카페', '#을지로크루아상', '#베이커리추천'],
      ),
    ],
  ),
];

/// 홈「최근 생성된 콘텐츠」용. generation당 1행. (위젯 테스트·프리뷰용)
final List<ContentRecentItem> contentRecentPreviewItems =
    contentGenerationPreviews.map(_toRecentItem).toList(growable: false);

ContentRecentItem _toRecentItem(ContentGenerationPreview generation) {
  final first = generation.firstChannel;
  return ContentRecentItem(
    id: generation.id,
    title: first?.recentDisplayTitle ?? '',
    createdAt: generation.createdAt,
    channels: generation.orderedChannelEnums
        .map(ContentLabelMapper.channel)
        .toList(growable: false),
  );
}
