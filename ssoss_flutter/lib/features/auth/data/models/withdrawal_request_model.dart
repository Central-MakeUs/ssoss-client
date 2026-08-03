import 'package:freezed_annotation/freezed_annotation.dart';

part 'withdrawal_request_model.freezed.dart';
part 'withdrawal_request_model.g.dart';

/// `DELETE /v1/members/me` 요청 바디 (`WithdrawalRequest`).
@freezed
abstract class WithdrawalRequestModel with _$WithdrawalRequestModel {
  const factory WithdrawalRequestModel({
    required String reasonCode,
    String? reasonDetail,
  }) = _WithdrawalRequestModel;

  factory WithdrawalRequestModel.fromJson(Map<String, dynamic> json) =>
      _$WithdrawalRequestModelFromJson(json);
}
