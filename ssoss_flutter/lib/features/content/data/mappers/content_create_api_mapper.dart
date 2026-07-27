import 'package:ssoss_flutter/features/content/domain/entities/content_tone.dart';
import 'package:ssoss_flutter/features/content/domain/entities/generation_status.dart';
import 'package:ssoss_flutter/features/content/domain/entities/upload_channel.dart';
import 'package:ssoss_flutter/features/content/domain/entities/upload_purpose.dart';

/// domain enum ↔ API 문자열 매퍼.
///
/// 서버 스펙: channels BLOG / INSTAGRAM / DAANGN_BIZ / THREADS
/// purpose INFORMATION / EVENT_DISCOUNT / NEW_MENU_PROMOTION
/// tone CASUAL / EMOTIONAL / INFORMATIVE / PROMOTIONAL
class ContentCreateApiMapper {
  const ContentCreateApiMapper._();

  static String channel(UploadChannel value) => switch (value) {
        UploadChannel.blog => 'BLOG',
        UploadChannel.instagram => 'INSTAGRAM',
        UploadChannel.carrot => 'DAANGN_BIZ',
        UploadChannel.thread => 'THREADS',
      };

  static UploadChannel channelFromApi(String value) => switch (value) {
        'BLOG' => UploadChannel.blog,
        'INSTAGRAM' => UploadChannel.instagram,
        'DAANGN_BIZ' || 'CARROT' => UploadChannel.carrot,
        'THREADS' || 'THREAD' => UploadChannel.thread,
        _ => throw ArgumentError('Unknown channel: $value'),
      };

  static List<String> channels(List<UploadChannel> values) =>
      values.map(channel).toList(growable: false);

  static String purpose(UploadPurpose value) => switch (value) {
        UploadPurpose.informative => 'INFORMATION',
        UploadPurpose.eventDiscount => 'EVENT_DISCOUNT',
        UploadPurpose.newMenuPromo => 'NEW_MENU_PROMOTION',
      };

  static UploadPurpose purposeFromApi(String value) => switch (value) {
        'INFORMATION' || 'INFORMATIVE' => UploadPurpose.informative,
        'EVENT_DISCOUNT' => UploadPurpose.eventDiscount,
        'NEW_MENU_PROMOTION' || 'NEW_MENU_PROMO' => UploadPurpose.newMenuPromo,
        _ => throw ArgumentError('Unknown purpose: $value'),
      };

  static String tone(ContentTone value) => switch (value) {
        ContentTone.daily => 'CASUAL',
        ContentTone.emotional => 'EMOTIONAL',
        ContentTone.informational => 'INFORMATIVE',
        ContentTone.promotional => 'PROMOTIONAL',
      };

  static ContentTone toneFromApi(String value) => switch (value) {
        'CASUAL' || 'DAILY' => ContentTone.daily,
        'EMOTIONAL' => ContentTone.emotional,
        'INFORMATIVE' || 'INFORMATIONAL' => ContentTone.informational,
        'PROMOTIONAL' => ContentTone.promotional,
        _ => throw ArgumentError('Unknown tone: $value'),
      };

  static GenerationStatus statusFromApi(String value) => switch (value) {
        'IN_PROGRESS' => GenerationStatus.inProgress,
        'SUCCEEDED' => GenerationStatus.succeeded,
        'FAILED' => GenerationStatus.failed,
        _ => throw ArgumentError('Unknown generation status: $value'),
      };
}
