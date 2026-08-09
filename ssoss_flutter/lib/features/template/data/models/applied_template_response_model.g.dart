// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'applied_template_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppliedTemplateResponseModel _$AppliedTemplateResponseModelFromJson(
        Map<String, dynamic> json) =>
    _AppliedTemplateResponseModel(
      id: (json['id'] as num).toInt(),
      body: json['body'] as String,
    );

Map<String, dynamic> _$AppliedTemplateResponseModelToJson(
        _AppliedTemplateResponseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'body': instance.body,
    };
