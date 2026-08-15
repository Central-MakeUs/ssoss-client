// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SignupRequestModel _$SignupRequestModelFromJson(Map<String, dynamic> json) =>
    _SignupRequestModel(
      ageOver14Agreed: json['ageOver14Agreed'] as bool,
      serviceTermsAgreed: json['serviceTermsAgreed'] as bool,
      privacyPolicyAgreed: json['privacyPolicyAgreed'] as bool,
    );

Map<String, dynamic> _$SignupRequestModelToJson(_SignupRequestModel instance) =>
    <String, dynamic>{
      'ageOver14Agreed': instance.ageOver14Agreed,
      'serviceTermsAgreed': instance.serviceTermsAgreed,
      'privacyPolicyAgreed': instance.privacyPolicyAgreed,
    };
