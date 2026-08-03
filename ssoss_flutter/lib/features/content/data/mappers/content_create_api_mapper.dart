import 'package:ssoss_flutter/core/constants/writing_tone.dart';
import 'package:ssoss_flutter/features/content/domain/entities/content_sort.dart';
import 'package:ssoss_flutter/features/content/domain/entities/generation_status.dart';
import 'package:ssoss_flutter/features/content/domain/entities/upload_channel.dart';
import 'package:ssoss_flutter/features/content/domain/entities/upload_purpose.dart';

/// domain enum ↔ API 문자열 매퍼.
///
/// 서버 스펙: channels BLOG / INSTAGRAM / DAANGN_BIZ / THREADS
/// purpose INFORMATION / EVENT_DISCOUNT / NEW_MENU_PROMOTION
/// tone CASUAL / EMOTIONAL / INFORMATIVE / PROMOTIONAL
/// sort LATEST / OLDEST
class ContentCreateApiMapper {
  const ContentCreateApiMapper._();

  static String channel(UploadChannel value) => switch (value) {
        UploadChannel.blog => 'BLOG',
        UploadChannel.instagram => 'INSTAGRAM',
        UploadChannel.carrot => 'DAANGN_BIZ',
        UploadChannel.thread => 'THREADS',
      };

  static String sort(ContentSort value) => switch (value) {
        ContentSort.latest => 'LATEST',
        ContentSort.oldest => 'OLDEST',
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

  static String tone(WritingTone value) => value.code;

  static WritingTone toneFromApi(String value) {
    final tone = WritingTone.fromCode(value);
    if (tone == null) {
      throw ArgumentError('Unknown tone: $value');
    }
    return tone;
  }

  static GenerationStatus statusFromApi(String value) => switch (value) {
        'IN_PROGRESS' => GenerationStatus.inProgress,
        'SUCCEEDED' => GenerationStatus.succeeded,
        'FAILED' => GenerationStatus.failed,
        _ => throw ArgumentError('Unknown generation status: $value'),
      };
}
