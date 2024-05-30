// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'translate_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TranslateResponse _$TranslateResponseFromJson(Map<String, dynamic> json) {
  return _TranslateResponse.fromJson(json);
}

/// @nodoc
mixin _$TranslateResponse {
  int get code => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TranslateResponseCopyWith<TranslateResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TranslateResponseCopyWith<$Res> {
  factory $TranslateResponseCopyWith(
          TranslateResponse value, $Res Function(TranslateResponse) then) =
      _$TranslateResponseCopyWithImpl<$Res, TranslateResponse>;
  @useResult
  $Res call({int code, String text});
}

/// @nodoc
class _$TranslateResponseCopyWithImpl<$Res, $Val extends TranslateResponse>
    implements $TranslateResponseCopyWith<$Res> {
  _$TranslateResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? text = null,
  }) {
    return _then(_value.copyWith(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as int,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TranslateResponseImplCopyWith<$Res>
    implements $TranslateResponseCopyWith<$Res> {
  factory _$$TranslateResponseImplCopyWith(_$TranslateResponseImpl value,
          $Res Function(_$TranslateResponseImpl) then) =
      __$$TranslateResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int code, String text});
}

/// @nodoc
class __$$TranslateResponseImplCopyWithImpl<$Res>
    extends _$TranslateResponseCopyWithImpl<$Res, _$TranslateResponseImpl>
    implements _$$TranslateResponseImplCopyWith<$Res> {
  __$$TranslateResponseImplCopyWithImpl(_$TranslateResponseImpl _value,
      $Res Function(_$TranslateResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? text = null,
  }) {
    return _then(_$TranslateResponseImpl(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as int,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TranslateResponseImpl implements _TranslateResponse {
  const _$TranslateResponseImpl({required this.code, required this.text});

  factory _$TranslateResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$TranslateResponseImplFromJson(json);

  @override
  final int code;
  @override
  final String text;

  @override
  String toString() {
    return 'TranslateResponse(code: $code, text: $text)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TranslateResponseImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.text, text) || other.text == text));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, code, text);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TranslateResponseImplCopyWith<_$TranslateResponseImpl> get copyWith =>
      __$$TranslateResponseImplCopyWithImpl<_$TranslateResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TranslateResponseImplToJson(
      this,
    );
  }
}

abstract class _TranslateResponse implements TranslateResponse {
  const factory _TranslateResponse(
      {required final int code,
      required final String text}) = _$TranslateResponseImpl;

  factory _TranslateResponse.fromJson(Map<String, dynamic> json) =
      _$TranslateResponseImpl.fromJson;

  @override
  int get code;
  @override
  String get text;
  @override
  @JsonKey(ignore: true)
  _$$TranslateResponseImplCopyWith<_$TranslateResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
