// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_template_save_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SavedTemplateSaveRequest _$SavedTemplateSaveRequestFromJson(
        Map<String, dynamic> json) =>
    _SavedTemplateSaveRequest(
      templateId: (json['templateId'] as num).toInt(),
      body: json['body'] as String,
    );

Map<String, dynamic> _$SavedTemplateSaveRequestToJson(
        _SavedTemplateSaveRequest instance) =>
    <String, dynamic>{
      'templateId': instance.templateId,
      'body': instance.body,
    };
