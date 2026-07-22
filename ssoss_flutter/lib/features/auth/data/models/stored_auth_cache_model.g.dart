// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stored_auth_cache_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StoredAuthCacheModel _$StoredAuthCacheModelFromJson(
        Map<String, dynamic> json) =>
    _StoredAuthCacheModel(
      token: AuthTokenModel.fromJson(json['token'] as Map<String, dynamic>),
      provider: json['provider'] as String,
      userId: json['userId'] as String,
      nickname: json['nickname'] as String,
      email: json['email'] as String?,
      memberStatus: json['memberStatus'] == null
          ? MemberStatus.active
          : _memberStatusFromJson(json['memberStatus']),
    );

Map<String, dynamic> _$StoredAuthCacheModelToJson(
        _StoredAuthCacheModel instance) =>
    <String, dynamic>{
      'token': instance.token,
      'provider': instance.provider,
      'userId': instance.userId,
      'nickname': instance.nickname,
      'email': instance.email,
      'memberStatus': _memberStatusToJson(instance.memberStatus),
    };
