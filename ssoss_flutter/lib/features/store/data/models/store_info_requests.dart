import 'package:ssoss_flutter/features/store/domain/entities/store_info.dart';

String? _blankToNull(String? value) {
  final trimmed = value?.trim();
  if (trimmed == null || trimmed.isEmpty) return null;
  return trimmed;
}

String? _timeToApi(String? value) {
  final trimmed = _blankToNull(value);
  if (trimmed == null) return null;

  final apiMatch = RegExp(r'^([01]?\d|2[0-3]):([0-5]\d)$').firstMatch(trimmed);
  if (apiMatch != null) {
    final hour = int.parse(apiMatch.group(1)!);
    final minute = apiMatch.group(2)!;
    return '${hour.toString().padLeft(2, '0')}:$minute';
  }

  final koreanMatch =
      RegExp(r'^(오전|오후)\s*(\d{1,2}):([0-5]\d)$').firstMatch(trimmed);
  if (koreanMatch == null) return trimmed;

  final period = koreanMatch.group(1)!;
  var hour = int.parse(koreanMatch.group(2)!);
  final minute = koreanMatch.group(3)!;

  if (period == '오전' && hour == 12) {
    hour = 0;
  } else if (period == '오후' && hour != 12) {
    hour += 12;
  }

  return '${hour.toString().padLeft(2, '0')}:$minute';
}

class StoreBasicInfoRequest {
  const StoreBasicInfoRequest({
    required this.name,
    required this.type,
    required this.address,
    this.introduction,
  });

  factory StoreBasicInfoRequest.fromInput(StoreBasicInfoInput input) {
    return StoreBasicInfoRequest(
      name: input.name.trim(),
      type: input.type.code,
      address: input.address.trim(),
      introduction: _blankToNull(input.introduction),
    );
  }

  final String name;
  final String type;
  final String address;
  final String? introduction;

  Map<String, dynamic> toJson() => {
        'name': name,
        'type': type,
        'address': address,
        if (introduction != null) 'introduction': introduction,
      };
}

class StoreOperationInfoRequest {
  const StoreOperationInfoRequest({
    this.businessDays = const [],
    this.openTime,
    this.closeTime,
    this.signatureMenus = const [],
    this.takeoutAvailable = false,
    this.reservationAvailable = false,
    this.parkingAvailable = false,
  });

  factory StoreOperationInfoRequest.fromInput(StoreOperationInfoInput input) {
    return StoreOperationInfoRequest(
      businessDays: input.businessDays.map((day) => day.code).toList(),
      openTime: _timeToApi(input.openTime),
      closeTime: _timeToApi(input.closeTime),
      signatureMenus: [
        for (final menu in input.signatureMenus)
          if (_blankToNull(menu) != null) _blankToNull(menu)!,
      ],
      takeoutAvailable: input.takeoutAvailable,
      reservationAvailable: input.reservationAvailable,
      parkingAvailable: input.parkingAvailable,
    );
  }

  final List<String> businessDays;
  final String? openTime;
  final String? closeTime;
  final List<String> signatureMenus;
  final bool takeoutAvailable;
  final bool reservationAvailable;
  final bool parkingAvailable;

  Map<String, dynamic> toJson() => {
        'businessDays': businessDays,
        if (openTime != null && closeTime != null) 'openTime': openTime,
        if (openTime != null && closeTime != null) 'closeTime': closeTime,
        'signatureMenus': signatureMenus,
        'takeoutAvailable': takeoutAvailable,
        'reservationAvailable': reservationAvailable,
        'parkingAvailable': parkingAvailable,
      };
}

class StoreContentInfoRequest {
  const StoreContentInfoRequest({
    this.strength,
    this.keywords = const [],
    this.forbidden,
    this.tone,
  });

  factory StoreContentInfoRequest.fromInput(StoreContentInfoInput input) {
    return StoreContentInfoRequest(
      strength: _blankToNull(input.strength),
      keywords: [
        for (final keyword in input.keywords)
          if (_blankToNull(keyword) != null) _blankToNull(keyword)!,
      ],
      forbidden: _blankToNull(input.forbidden),
      tone: input.tone?.code,
    );
  }

  final String? strength;
  final List<String> keywords;
  final String? forbidden;
  final String? tone;

  Map<String, dynamic> toJson() => {
        if (strength != null) 'strength': strength,
        'keywords': keywords,
        if (forbidden != null) 'forbidden': forbidden,
        if (tone != null) 'tone': tone,
      };
}
