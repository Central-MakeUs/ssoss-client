// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SignupRequestModel _$SignupRequestModelFromJson(Map<String, dynamic> json) =>
    _SignupRequestModel(
      serviceTermsAgreed: json['serviceTermsAgreed'] as bool,
      privacyPolicyAgreed: json['privacyPolicyAgreed'] as bool,
      marketingAgreed: json['marketingAgreed'] as bool,
    );

Map<String, dynamic> _$SignupRequestModelToJson(_SignupRequestModel instance) =>
    <String, dynamic>{
      'serviceTermsAgreed': instance.serviceTermsAgreed,
      'privacyPolicyAgreed': instance.privacyPolicyAgreed,
      'marketingAgreed': instance.marketingAgreed,
    };
