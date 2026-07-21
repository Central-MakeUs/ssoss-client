import 'package:ssoss_flutter/features/content/domain/entities/content_tone.dart';
import 'package:ssoss_flutter/features/content/domain/entities/upload_channel.dart';
import 'package:ssoss_flutter/features/content/domain/entities/upload_purpose.dart';

/// domain enum → API 전송 문자열 매퍼.
///
/// 서버 스펙 변경 시 이 클래스만 수정한다.
class ContentCreateApiMapper {
  const ContentCreateApiMapper._();

  static String channel(UploadChannel value) => switch (value) {
        UploadChannel.blog => 'BLOG',
        UploadChannel.instagram => 'INSTAGRAM',
        UploadChannel.carrot => 'CARROT',
        UploadChannel.thread => 'THREAD',
      };

  static List<String> channels(List<UploadChannel> values) =>
      values.map(channel).toList(growable: false);

  static String purpose(UploadPurpose value) => switch (value) {
        UploadPurpose.informative => 'INFORMATIVE',
        UploadPurpose.eventDiscount => 'EVENT_DISCOUNT',
        UploadPurpose.newMenuPromo => 'NEW_MENU_PROMO',
      };

  static String tone(ContentTone value) => switch (value) {
        ContentTone.daily => 'DAILY',
        ContentTone.emotional => 'EMOTIONAL',
        ContentTone.informational => 'INFORMATIONAL',
        ContentTone.promotional => 'PROMOTIONAL',
      };
}
