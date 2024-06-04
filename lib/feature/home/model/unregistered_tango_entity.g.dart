// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unregistered_tango_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UnregisteredTangoEntityImpl _$$UnregisteredTangoEntityImplFromJson(
        Map<String, dynamic> json) =>
    _$UnregisteredTangoEntityImpl(
      id: (json['id'] as num?)?.toInt(),
      indonesian: json['indonesian'] as String,
      japanese: json['japanese'] as String,
      english: json['english'] as String,
      example: json['example'] as String?,
      exampleJp: json['example_jp'] as String?,
      partOfSpeech: json['part_of_speech'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$$UnregisteredTangoEntityImplToJson(
        _$UnregisteredTangoEntityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'indonesian': instance.indonesian,
      'japanese': instance.japanese,
      'english': instance.english,
      'example': instance.example,
      'example_jp': instance.exampleJp,
      'part_of_speech': instance.partOfSpeech,
      'description': instance.description,
    };
