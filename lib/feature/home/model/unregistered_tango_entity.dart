import 'package:freezed_annotation/freezed_annotation.dart';

part 'unregistered_tango_entity.freezed.dart';
part 'unregistered_tango_entity.g.dart';

@freezed
class UnregisteredTangoEntity with _$UnregisteredTangoEntity {

  const factory UnregisteredTangoEntity({
    int? id,
    required String indonesian,
    required String japanese,
    required String english,
    required String? example,
    @JsonKey(name: 'example_jp') required String? exampleJp,
    String? description,
  }) = _UnregisteredTangoEntity;

  factory UnregisteredTangoEntity.fromJson(Map<String, dynamic> json) =>
      _$UnregisteredTangoEntityFromJson(json);
}
