// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'withdrawal_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WithdrawalRequestModel _$WithdrawalRequestModelFromJson(
        Map<String, dynamic> json) =>
    _WithdrawalRequestModel(
      reasonCode: json['reasonCode'] as String,
      reasonDetail: json['reasonDetail'] as String?,
    );

Map<String, dynamic> _$WithdrawalRequestModelToJson(
        _WithdrawalRequestModel instance) =>
    <String, dynamic>{
      'reasonCode': instance.reasonCode,
      'reasonDetail': instance.reasonDetail,
    };
