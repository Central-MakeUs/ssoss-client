// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credit_ledger_list_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CreditLedgerModel _$CreditLedgerModelFromJson(Map<String, dynamic> json) =>
    _CreditLedgerModel(
      ledgerId: (json['ledgerId'] as num).toInt(),
      type: json['type'] as String,
      description: json['description'] as String,
      amount: (json['amount'] as num).toInt(),
      occurredAt: json['occurredAt'] as String,
    );

Map<String, dynamic> _$CreditLedgerModelToJson(_CreditLedgerModel instance) =>
    <String, dynamic>{
      'ledgerId': instance.ledgerId,
      'type': instance.type,
      'description': instance.description,
      'amount': instance.amount,
      'occurredAt': instance.occurredAt,
    };

_CreditLedgerListResponseModel _$CreditLedgerListResponseModelFromJson(
        Map<String, dynamic> json) =>
    _CreditLedgerListResponseModel(
      totalCount: (json['totalCount'] as num).toInt(),
      page: (json['page'] as num).toInt(),
      size: (json['size'] as num).toInt(),
      hasNext: json['hasNext'] as bool,
      ledgers: (json['ledgers'] as List<dynamic>?)
              ?.map(
                  (e) => CreditLedgerModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <CreditLedgerModel>[],
    );

Map<String, dynamic> _$CreditLedgerListResponseModelToJson(
        _CreditLedgerListResponseModel instance) =>
    <String, dynamic>{
      'totalCount': instance.totalCount,
      'page': instance.page,
      'size': instance.size,
      'hasNext': instance.hasNext,
      'ledgers': instance.ledgers,
    };
