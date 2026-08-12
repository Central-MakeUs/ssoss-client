import 'package:ssoss_flutter/core/constants/writing_tone.dart';

enum StoreInfoStatus {
  notWritten,
  completed;

  static StoreInfoStatus fromCode(String? code) {
    return switch (code) {
      'COMPLETED' => StoreInfoStatus.completed,
      _ => StoreInfoStatus.notWritten,
    };
  }

  String get label {
    return switch (this) {
      StoreInfoStatus.notWritten => '입력 전',
      StoreInfoStatus.completed => '입력 완료',
    };
  }

  bool get isCompleted => this == StoreInfoStatus.completed;
}

enum StoreType {
  cafe('CAFE', '카페'),
  dessertCafe('DESSERT_CAFE', '디저트 카페'),
  bakery('BAKERY', '베이커리'),
  bakeryCafe('BAKERY_CAFE', '베이커리 카페'),
  brunchCafe('BRUNCH_CAFE', '브런치 카페'),
  roasteryCafe('ROASTERY_CAFE', '로스터리 카페'),
  cafeBar('CAFE_BAR', '카페·바');

  const StoreType(this.code, this.label);

  final String code;
  final String label;

  static StoreType? fromCode(String? code) {
    for (final type in StoreType.values) {
      if (type.code == code) return type;
    }
    return null;
  }

  static StoreType? fromLabel(String? label) {
    for (final type in StoreType.values) {
      if (type.label == label) return type;
    }
    return null;
  }
}

enum BusinessDay {
  monday('MONDAY', '월'),
  tuesday('TUESDAY', '화'),
  wednesday('WEDNESDAY', '수'),
  thursday('THURSDAY', '목'),
  friday('FRIDAY', '금'),
  saturday('SATURDAY', '토'),
  sunday('SUNDAY', '일');

  const BusinessDay(this.code, this.label);

  final String code;
  final String label;

  static BusinessDay? fromCode(String? code) {
    for (final day in BusinessDay.values) {
      if (day.code == code) return day;
    }
    return null;
  }

  static BusinessDay? fromLabel(String? label) {
    for (final day in BusinessDay.values) {
      if (day.label == label) return day;
    }
    return null;
  }
}



class StoreInfo {
  const StoreInfo({
    required this.basic,
    required this.operation,
    required this.content,
  });

  factory StoreInfo.empty() => const StoreInfo(
        basic: StoreBasicInfo(),
        operation: StoreOperationInfo(),
        content: StoreContentInfo(),
      );

  final StoreBasicInfo basic;
  final StoreOperationInfo operation;
  final StoreContentInfo content;

  bool get hasAnyWrittenInfo =>
      basic.status.isCompleted ||
      operation.status.isCompleted ||
      content.status.isCompleted;

  bool get isFullyFilled =>
      basic.isFullyFilled && operation.isFullyFilled && content.isFullyFilled;
}

class StoreBasicInfo {
  const StoreBasicInfo({
    this.name,
    this.type,
    this.address,
    this.introduction,
    this.status = StoreInfoStatus.notWritten,
  });

  final String? name;
  final StoreType? type;
  final String? address;
  final String? introduction;
  final StoreInfoStatus status;

  bool get isFullyFilled =>
      name?.trim().isNotEmpty == true &&
      type != null &&
      address?.trim().isNotEmpty == true &&
      introduction?.trim().isNotEmpty == true;
}

class StoreOperationInfo {
  const StoreOperationInfo({
    this.businessDays = const [],
    this.openTime,
    this.closeTime,
    this.signatureMenus = const [],
    this.takeoutAvailable = false,
    this.reservationAvailable = false,
    this.parkingAvailable = false,
    this.status = StoreInfoStatus.notWritten,
  });

  final List<BusinessDay> businessDays;
  final String? openTime;
  final String? closeTime;
  final List<String> signatureMenus;
  final bool takeoutAvailable;
  final bool reservationAvailable;
  final bool parkingAvailable;
  final StoreInfoStatus status;

  bool get isFullyFilled =>
      businessDays.isNotEmpty &&
      openTime?.trim().isNotEmpty == true &&
      closeTime?.trim().isNotEmpty == true &&
      signatureMenus.isNotEmpty;
}

class StoreContentInfo {
  const StoreContentInfo({
    this.strength,
    this.keywords = const [],
    this.forbidden,
    this.tone,
    this.status = StoreInfoStatus.notWritten,
  });

  final String? strength;
  final List<String> keywords;
  final String? forbidden;
  final WritingTone? tone;
  final StoreInfoStatus status;

  bool get isFullyFilled =>
      strength?.trim().isNotEmpty == true &&
      keywords.isNotEmpty &&
      forbidden?.trim().isNotEmpty == true &&
      tone != null;
}

class StoreBasicInfoInput {
  const StoreBasicInfoInput({
    required this.name,
    required this.type,
    required this.address,
    this.introduction,
  });

  final String name;
  final StoreType type;
  final String address;
  final String? introduction;
}

class StoreOperationInfoInput {
  const StoreOperationInfoInput({
    this.businessDays = const [],
    this.openTime,
    this.closeTime,
    this.signatureMenus = const [],
    this.takeoutAvailable = false,
    this.reservationAvailable = false,
    this.parkingAvailable = false,
  });

  final List<BusinessDay> businessDays;
  final String? openTime;
  final String? closeTime;
  final List<String> signatureMenus;
  final bool takeoutAvailable;
  final bool reservationAvailable;
  final bool parkingAvailable;
}

class StoreContentInfoInput {
  const StoreContentInfoInput({
    this.strength,
    this.keywords = const [],
    this.forbidden,
    this.tone,
  });

  final String? strength;
  final List<String> keywords;
  final String? forbidden;
  final WritingTone? tone;
}
