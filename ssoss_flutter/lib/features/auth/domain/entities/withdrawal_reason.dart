/// 탈퇴 사유 코드 (`DELETE /v1/members/me` body `reasonCode`).
enum WithdrawalReasonCode {
  /// 원하는 기능이 없어요
  noFeature,

  /// 콘텐츠 품질이 기대와 달랐어요
  contentQuality,

  /// 사용 방법이 어려웠어요
  hardToUse,

  /// 자주 사용하지 않게 되었어요
  lowUsage,

  /// 기타
  other,
}

extension WithdrawalReasonCodeX on WithdrawalReasonCode {
  String toApi() {
    switch (this) {
      case WithdrawalReasonCode.noFeature:
        return 'NO_FEATURE';
      case WithdrawalReasonCode.contentQuality:
        return 'CONTENT_QUALITY';
      case WithdrawalReasonCode.hardToUse:
        return 'HARD_TO_USE';
      case WithdrawalReasonCode.lowUsage:
        return 'LOW_USAGE';
      case WithdrawalReasonCode.other:
        return 'OTHER';
    }
  }
}

/// 탈퇴 요청 시 함께 전달하는 사유.
///
/// [detail]은 [WithdrawalReasonCode.other] 선택 시 자유 입력(최대 500자).
/// 그 외 코드에서는 null.
class WithdrawalReason {
  const WithdrawalReason({
    required this.code,
    this.detail,
  });

  static const int detailMaxLength = 500;

  final WithdrawalReasonCode code;
  final String? detail;
}
