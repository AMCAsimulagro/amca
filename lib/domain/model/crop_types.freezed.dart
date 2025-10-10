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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CropTypes _$CropTypesFromJson(Map<String, dynamic> json) {
  return _CropTypes.fromJson(json);
}

/// @nodoc
mixin _$CropTypes {
  List<String> get cultivo => throw _privateConstructorUsedError;
  String get tipo => throw _privateConstructorUsedError;
  String? get id => throw _privateConstructorUsedError;

  /// Serializes this CropTypes to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CropTypes
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Create a copy of CropTypes
  /// with the given fields replaced by the non-null parameter values.
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
abstract class _$$CropTypesImplCopyWith<$Res>
    implements $CropTypesCopyWith<$Res> {
  factory _$$CropTypesImplCopyWith(
          _$CropTypesImpl value, $Res Function(_$CropTypesImpl) then) =
      __$$CropTypesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<String> cultivo, String tipo, String? id});
}

/// @nodoc
class __$$CropTypesImplCopyWithImpl<$Res>
    extends _$CropTypesCopyWithImpl<$Res, _$CropTypesImpl>
    implements _$$CropTypesImplCopyWith<$Res> {
  __$$CropTypesImplCopyWithImpl(
      _$CropTypesImpl _value, $Res Function(_$CropTypesImpl) _then)
      : super(_value, _then);

  /// Create a copy of CropTypes
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cultivo = null,
    Object? tipo = null,
    Object? id = freezed,
  }) {
    return _then(_$CropTypesImpl(
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
class _$CropTypesImpl implements _CropTypes {
  _$CropTypesImpl(
      {required final List<String> cultivo, required this.tipo, this.id})
      : _cultivo = cultivo;

  factory _$CropTypesImpl.fromJson(Map<String, dynamic> json) =>
      _$$CropTypesImplFromJson(json);

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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CropTypesImpl &&
            const DeepCollectionEquality().equals(other._cultivo, _cultivo) &&
            (identical(other.tipo, tipo) || other.tipo == tipo) &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_cultivo), tipo, id);

  /// Create a copy of CropTypes
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CropTypesImplCopyWith<_$CropTypesImpl> get copyWith =>
      __$$CropTypesImplCopyWithImpl<_$CropTypesImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CropTypesImplToJson(
      this,
    );
  }
}

abstract class _CropTypes implements CropTypes {
  factory _CropTypes(
      {required final List<String> cultivo,
      required final String tipo,
      final String? id}) = _$CropTypesImpl;

  factory _CropTypes.fromJson(Map<String, dynamic> json) =
      _$CropTypesImpl.fromJson;

  @override
  List<String> get cultivo;
  @override
  String get tipo;
  @override
  String? get id;

  /// Create a copy of CropTypes
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CropTypesImplCopyWith<_$CropTypesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
