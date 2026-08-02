import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:ssoss_flutter/features/credit/domain/entities/credit_ledger.dart';
import 'package:ssoss_flutter/features/credit/domain/entities/credit_ledger_page.dart';
import 'package:ssoss_flutter/features/credit/domain/entities/credit_ledger_type.dart';

part 'credit_ledger_list_response_model.freezed.dart';
part 'credit_ledger_list_response_model.g.dart';

@freezed
abstract class CreditLedgerModel with _$CreditLedgerModel {
  const factory CreditLedgerModel({
    required int ledgerId,
    required String type,
    required String description,
    required int amount,
    required String occurredAt,
  }) = _CreditLedgerModel;

  factory CreditLedgerModel.fromJson(Map<String, dynamic> json) =>
      _$CreditLedgerModelFromJson(json);
}

@freezed
abstract class CreditLedgerListResponseModel
    with _$CreditLedgerListResponseModel {
  const factory CreditLedgerListResponseModel({
    required int totalCount,
    required int page,
    required int size,
    required bool hasNext,
    @Default(<CreditLedgerModel>[]) List<CreditLedgerModel> ledgers,
  }) = _CreditLedgerListResponseModel;

  factory CreditLedgerListResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CreditLedgerListResponseModelFromJson(json);
}

extension CreditLedgerModelX on CreditLedgerModel {
  CreditLedger toEntity() => CreditLedger(
        ledgerId: ledgerId,
        type: CreditLedgerTypeX.fromApi(type),
        description: description,
        amount: amount,
        occurredAt: DateTime.parse(occurredAt).toLocal(),
      );
}

extension CreditLedgerListResponseModelX on CreditLedgerListResponseModel {
  CreditLedgerPage toEntity() => CreditLedgerPage(
        totalCount: totalCount,
        page: page,
        size: size,
        hasNext: hasNext,
        ledgers: ledgers.map((e) => e.toEntity()).toList(growable: false),
      );
}
