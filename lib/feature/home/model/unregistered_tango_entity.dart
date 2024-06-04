import 'package:bintango_indonesian_dictionary/feature/home/model/tango_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'unregistered_tango_entity.freezed.dart';
part 'unregistered_tango_entity.g.dart';

@freezed
abstract class UnregisteredTangoEntity implements _$UnregisteredTangoEntity {

  const factory UnregisteredTangoEntity({
    required String indonesian, required String japanese, required String english, required String? example, @JsonKey(name: 'example_jp') required String? exampleJp, int? id,
    @JsonKey(name: 'part_of_speech') String? partOfSpeech,
    String? description,
  }) = _UnregisteredTangoEntity;
  const UnregisteredTangoEntity._();

  factory UnregisteredTangoEntity.fromJson(Map<String, dynamic> json) =>
      _$UnregisteredTangoEntityFromJson(json);

  TangoEntity toTangoEntity() {
    return TangoEntity(
        indonesian: indonesian,
        japanese: japanese,
        english: english,
        example: example,
        exampleJp: exampleJp,
        description: description,
    );
  }
}
