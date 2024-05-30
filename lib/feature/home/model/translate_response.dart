import 'package:freezed_annotation/freezed_annotation.dart';

part 'translate_response.freezed.dart';
part 'translate_response.g.dart';

@freezed
class TranslateResponse with _$TranslateResponse {
  const factory TranslateResponse({
    required int code,
    required String text,
  }) = _TranslateResponse;

  factory TranslateResponse.fromJson(Map<String, dynamic> json) => _$TranslateResponseFromJson(json);
}