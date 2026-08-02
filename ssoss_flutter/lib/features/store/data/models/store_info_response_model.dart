import 'package:ssoss_flutter/features/store/domain/entities/store_info.dart';

class StoreInfoResponseModel {
  const StoreInfoResponseModel({
    required this.basic,
    required this.operation,
    required this.content,
  });

  factory StoreInfoResponseModel.fromJson(Map<String, dynamic> json) {
    return StoreInfoResponseModel(
      basic: StoreBasicInfoResponseModel.fromJson(
        Map<String, dynamic>.from(json['basic'] as Map? ?? const {}),
      ),
      operation: StoreOperationInfoResponseModel.fromJson(
        Map<String, dynamic>.from(json['operation'] as Map? ?? const {}),
      ),
      content: StoreContentInfoResponseModel.fromJson(
        Map<String, dynamic>.from(json['content'] as Map? ?? const {}),
      ),
    );
  }

  final StoreBasicInfoResponseModel basic;
  final StoreOperationInfoResponseModel operation;
  final StoreContentInfoResponseModel content;

  StoreInfo toEntity() => StoreInfo(
        basic: basic.toEntity(),
        operation: operation.toEntity(),
        content: content.toEntity(),
      );
}

class StoreBasicInfoResponseModel {
  const StoreBasicInfoResponseModel({
    this.name,
    this.type,
    this.address,
    this.introduction,
    this.status,
  });

  factory StoreBasicInfoResponseModel.fromJson(Map<String, dynamic> json) {
    return StoreBasicInfoResponseModel(
      name: json['name'] as String?,
      type: json['type'] as String?,
      address: json['address'] as String?,
      introduction: json['introduction'] as String?,
      status: json['status'] as String?,
    );
  }

  final String? name;
  final String? type;
  final String? address;
  final String? introduction;
  final String? status;

  StoreBasicInfo toEntity() => StoreBasicInfo(
        name: name,
        type: StoreType.fromCode(type),
        address: address,
        introduction: introduction,
        status: StoreInfoStatus.fromCode(status),
      );
}

class StoreOperationInfoResponseModel {
  const StoreOperationInfoResponseModel({
    this.businessDays = const [],
    this.openTime,
    this.closeTime,
    this.signatureMenus = const [],
    this.takeoutAvailable = false,
    this.reservationAvailable = false,
    this.parkingAvailable = false,
    this.status,
  });

  factory StoreOperationInfoResponseModel.fromJson(Map<String, dynamic> json) {
    return StoreOperationInfoResponseModel(
      businessDays: [
        for (final value in json['businessDays'] as List? ?? const [])
          if (value is String) value,
      ],
      openTime: json['openTime'] as String?,
      closeTime: json['closeTime'] as String?,
      signatureMenus: [
        for (final value in json['signatureMenus'] as List? ?? const [])
          if (value is String) value,
      ],
      takeoutAvailable: json['takeoutAvailable'] as bool? ?? false,
      reservationAvailable: json['reservationAvailable'] as bool? ?? false,
      parkingAvailable: json['parkingAvailable'] as bool? ?? false,
      status: json['status'] as String?,
    );
  }

  final List<String> businessDays;
  final String? openTime;
  final String? closeTime;
  final List<String> signatureMenus;
  final bool takeoutAvailable;
  final bool reservationAvailable;
  final bool parkingAvailable;
  final String? status;

  StoreOperationInfo toEntity() => StoreOperationInfo(
        businessDays: [
          for (final code in businessDays)
            if (BusinessDay.fromCode(code) != null) BusinessDay.fromCode(code)!,
        ],
        openTime: openTime,
        closeTime: closeTime,
        signatureMenus: signatureMenus,
        takeoutAvailable: takeoutAvailable,
        reservationAvailable: reservationAvailable,
        parkingAvailable: parkingAvailable,
        status: StoreInfoStatus.fromCode(status),
      );
}

class StoreContentInfoResponseModel {
  const StoreContentInfoResponseModel({
    this.strength,
    this.keywords = const [],
    this.forbidden,
    this.tone,
    this.status,
  });

  factory StoreContentInfoResponseModel.fromJson(Map<String, dynamic> json) {
    return StoreContentInfoResponseModel(
      strength: json['strength'] as String?,
      keywords: [
        for (final value in json['keywords'] as List? ?? const [])
          if (value is String) value,
      ],
      forbidden: json['forbidden'] as String?,
      tone: json['tone'] as String?,
      status: json['status'] as String?,
    );
  }

  final String? strength;
  final List<String> keywords;
  final String? forbidden;
  final String? tone;
  final String? status;

  StoreContentInfo toEntity() => StoreContentInfo(
        strength: strength,
        keywords: keywords,
        forbidden: forbidden,
        tone: StoreTone.fromCode(tone),
        status: StoreInfoStatus.fromCode(status),
      );
}
