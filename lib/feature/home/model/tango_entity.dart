import 'package:freezed_annotation/freezed_annotation.dart';

part 'tango_entity.freezed.dart';
part 'tango_entity.g.dart';

@freezed
class TangoEntity with _$TangoEntity {

  const factory TangoEntity({
    required String indonesian, required String japanese, required String english, required String? example, @JsonKey(name: 'example_jp') required String? exampleJp, int? id,
    int? level,
    @JsonKey(name: 'part_of_speech') int? partOfSpeech,
    String? description,
    int? category,
    int? frequency,
    @JsonKey(name: 'ranking_frequency') int? rankFrequency,
  }) = _TangoEntity;

  factory TangoEntity.fromJson(Map<String, dynamic> json) =>
      _$TangoEntityFromJson(json);
}
