// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'translate_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TranslateResponseImpl _$$TranslateResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$TranslateResponseImpl(
      code: (json['code'] as num).toInt(),
      text: json['text'] as String,
    );

Map<String, dynamic> _$$TranslateResponseImplToJson(
        _$TranslateResponseImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'text': instance.text,
    };
