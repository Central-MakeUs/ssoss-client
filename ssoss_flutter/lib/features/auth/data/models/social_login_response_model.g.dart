// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'social_login_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SocialLoginResponseModel _$SocialLoginResponseModelFromJson(
        Map<String, dynamic> json) =>
    _SocialLoginResponseModel(
      status: _memberStatusFromJson(json['status'] as String),
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
    );

Map<String, dynamic> _$SocialLoginResponseModelToJson(
        _SocialLoginResponseModel instance) =>
    <String, dynamic>{
      'status': _memberStatusToJson(instance.status),
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
    };
