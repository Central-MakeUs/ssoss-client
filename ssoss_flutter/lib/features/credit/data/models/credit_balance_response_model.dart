import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:ssoss_flutter/features/credit/domain/entities/credit_balance.dart';

part 'credit_balance_response_model.freezed.dart';
part 'credit_balance_response_model.g.dart';

@freezed
abstract class CreditBalanceResponseModel with _$CreditBalanceResponseModel {
  const factory CreditBalanceResponseModel({
    required int balance,
  }) = _CreditBalanceResponseModel;

  factory CreditBalanceResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CreditBalanceResponseModelFromJson(json);
}

extension CreditBalanceResponseModelX on CreditBalanceResponseModel {
  CreditBalance toEntity() => CreditBalance(balance: balance);
}
