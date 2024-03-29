/// {@category Domain}
// This file defines the [CropTypes] class with JSON serialization and deserialization functions using manual implementation.

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'crop_types.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CropTypes _$CropTypesFromJson(Map<String, dynamic> json) {
  return _CropTypes.fromJson(json);
}

/// @nodoc
mixin _$CropTypes {
  List<String> get cultivo => throw _privateConstructorUsedError;
  String get tipo => throw _privateConstructorUsedError;
  String? get id => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CropTypesCopyWith<CropTypes> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CropTypesCopyWith<$Res> {
  factory $CropTypesCopyWith(CropTypes value, $Res Function(CropTypes) then) =
      _$CropTypesCopyWithImpl<$Res, CropTypes>;
  @useResult
  $Res call({List<String> cultivo, String tipo, String? id});
}

/// @nodoc
class _$CropTypesCopyWithImpl<$Res, $Val extends CropTypes>
    implements $CropTypesCopyWith<$Res> {
  _$CropTypesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cultivo = null,
    Object? tipo = null,
    Object? id = freezed,
  }) {
    return _then(_value.copyWith(
      cultivo: null == cultivo
          ? _value.cultivo
          : cultivo // ignore: cast_nullable_to_non_nullable
              as List<String>,
      tipo: null == tipo
          ? _value.tipo
          : tipo // ignore: cast_nullable_to_non_nullable
              as String,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CropTypesCopyWith<$Res> implements $CropTypesCopyWith<$Res> {
  factory _$$_CropTypesCopyWith(
          _$_CropTypes value, $Res Function(_$_CropTypes) then) =
      __$$_CropTypesCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<String> cultivo, String tipo, String? id});
}

/// @nodoc
class __$$_CropTypesCopyWithImpl<$Res>
    extends _$CropTypesCopyWithImpl<$Res, _$_CropTypes>
    implements _$$_CropTypesCopyWith<$Res> {
  __$$_CropTypesCopyWithImpl(
      _$_CropTypes _value, $Res Function(_$_CropTypes) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cultivo = null,
    Object? tipo = null,
    Object? id = freezed,
  }) {
    return _then(_$_CropTypes(
      cultivo: null == cultivo
          ? _value._cultivo
          : cultivo // ignore: cast_nullable_to_non_nullable
              as List<String>,
      tipo: null == tipo
          ? _value.tipo
          : tipo // ignore: cast_nullable_to_non_nullable
              as String,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CropTypes implements _CropTypes {
  _$_CropTypes(
      {required final List<String> cultivo, required this.tipo, this.id})
      : _cultivo = cultivo;

  factory _$_CropTypes.fromJson(Map<String, dynamic> json) =>
      _$$_CropTypesFromJson(json);

  final List<String> _cultivo;
  @override
  List<String> get cultivo {
    if (_cultivo is EqualUnmodifiableListView) return _cultivo;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cultivo);
  }

  @override
  final String tipo;
  @override
  final String? id;

  @override
  String toString() {
    return 'CropTypes(cultivo: $cultivo, tipo: $tipo, id: $id)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CropTypes &&
            const DeepCollectionEquality().equals(other._cultivo, _cultivo) &&
            (identical(other.tipo, tipo) || other.tipo == tipo) &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_cultivo), tipo, id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CropTypesCopyWith<_$_CropTypes> get copyWith =>
      __$$_CropTypesCopyWithImpl<_$_CropTypes>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CropTypesToJson(
      this,
    );
  }
}

abstract class _CropTypes implements CropTypes {
  factory _CropTypes(
      {required final List<String> cultivo,
      required final String tipo,
      final String? id}) = _$_CropTypes;

  factory _CropTypes.fromJson(Map<String, dynamic> json) =
      _$_CropTypes.fromJson;

  @override
  List<String> get cultivo;
  @override
  String get tipo;
  @override
  String? get id;
  @override
  @JsonKey(ignore: true)
  _$$_CropTypesCopyWith<_$_CropTypes> get copyWith =>
      throw _privateConstructorUsedError;
}
