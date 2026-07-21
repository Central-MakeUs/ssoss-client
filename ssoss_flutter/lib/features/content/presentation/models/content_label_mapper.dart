import 'package:ssoss_flutter/features/content/domain/entities/content_tone.dart';
import 'package:ssoss_flutter/features/content/domain/entities/upload_channel.dart';
import 'package:ssoss_flutter/features/content/domain/entities/upload_purpose.dart';

/// 결과/요약 UI용 한글 라벨.
class ContentLabelMapper {
  const ContentLabelMapper._();

  static String channel(UploadChannel value) => switch (value) {
        UploadChannel.blog => '블로그',
        UploadChannel.instagram => '인스타그램',
        UploadChannel.carrot => '당근',
        UploadChannel.thread => '스레드',
      };

  static String purpose(UploadPurpose value) => switch (value) {
        UploadPurpose.informative => '정보성',
        UploadPurpose.eventDiscount => '이벤트/할인',
        UploadPurpose.newMenuPromo => '신메뉴/홍보',
      };

  static String tone(ContentTone value) => switch (value) {
        ContentTone.daily => '일상형',
        ContentTone.emotional => '감성형',
        ContentTone.informational => '정보형',
        ContentTone.promotional => '홍보형',
      };

  /// enum 고정 순서로 정렬한 채널 목록.
  static List<UploadChannel> orderedChannels(List<UploadChannel> channels) {
    return UploadChannel.values
        .where(channels.contains)
        .toList(growable: false);
  }

  static String channelsJoined(List<UploadChannel> channels) {
    return orderedChannels(channels).map(channel).join('/');
  }
}
