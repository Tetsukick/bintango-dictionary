import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bintango_indonesian_dictionary/shared/http/app_exception.dart';

part 'api_response.freezed.dart';

@freezed
class APIResponse<T> with _$APIResponse<T> {
  const factory APIResponse.success(T value) = APISuccess<T>;

  const factory APIResponse.error(AppException exception) = APIError;
}
