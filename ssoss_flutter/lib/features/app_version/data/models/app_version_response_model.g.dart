// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_version_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppVersionResponseModel _$AppVersionResponseModelFromJson(
        Map<String, dynamic> json) =>
    _AppVersionResponseModel(
      minimumVersion: json['minimumVersion'] as String,
      updateRequired: json['updateRequired'] as bool,
    );

Map<String, dynamic> _$AppVersionResponseModelToJson(
        _AppVersionResponseModel instance) =>
    <String, dynamic>{
      'minimumVersion': instance.minimumVersion,
      'updateRequired': instance.updateRequired,
    };
