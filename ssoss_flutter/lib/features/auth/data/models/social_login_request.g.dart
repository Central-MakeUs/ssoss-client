// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'social_login_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SocialLoginRequest _$SocialLoginRequestFromJson(Map<String, dynamic> json) =>
    _SocialLoginRequest(
      provider: json['provider'] as String,
      accessToken: json['accessToken'] as String,
    );

Map<String, dynamic> _$SocialLoginRequestToJson(_SocialLoginRequest instance) =>
    <String, dynamic>{
      'provider': instance.provider,
      'accessToken': instance.accessToken,
    };
