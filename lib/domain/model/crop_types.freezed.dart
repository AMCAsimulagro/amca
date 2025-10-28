// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'crop_types.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CropTypes {
  List<String> get cultivo;
  String get tipo;
  String? get id;

  /// Create a copy of CropTypes
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CropTypesCopyWith<CropTypes> get copyWith =>
      _$CropTypesCopyWithImpl<CropTypes>(this as CropTypes, _$identity);

  /// Serializes this CropTypes to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CropTypes &&
            const DeepCollectionEquality().equals(other.cultivo, cultivo) &&
            (identical(other.tipo, tipo) || other.tipo == tipo) &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(cultivo), tipo, id);

  @override
  String toString() {
    return 'CropTypes(cultivo: $cultivo, tipo: $tipo, id: $id)';
  }
}

/// @nodoc
abstract mixin class $CropTypesCopyWith<$Res> {
  factory $CropTypesCopyWith(CropTypes value, $Res Function(CropTypes) _then) =
      _$CropTypesCopyWithImpl;
  @useResult
  $Res call({List<String> cultivo, String tipo, String? id});
}

/// @nodoc
class _$CropTypesCopyWithImpl<$Res> implements $CropTypesCopyWith<$Res> {
  _$CropTypesCopyWithImpl(this._self, this._then);

  final CropTypes _self;
  final $Res Function(CropTypes) _then;

  /// Create a copy of CropTypes
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cultivo = null,
    Object? tipo = null,
    Object? id = freezed,
  }) {
    return _then(_self.copyWith(
      cultivo: null == cultivo
          ? _self.cultivo
          : cultivo // ignore: cast_nullable_to_non_nullable
              as List<String>,
      tipo: null == tipo
          ? _self.tipo
          : tipo // ignore: cast_nullable_to_non_nullable
              as String,
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _CropTypes implements CropTypes {
  _CropTypes({required final List<String> cultivo, required this.tipo, this.id})
      : _cultivo = cultivo;
  factory _CropTypes.fromJson(Map<String, dynamic> json) =>
      _$CropTypesFromJson(json);

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

  /// Create a copy of CropTypes
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CropTypesCopyWith<_CropTypes> get copyWith =>
      __$CropTypesCopyWithImpl<_CropTypes>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CropTypesToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CropTypes &&
            const DeepCollectionEquality().equals(other._cultivo, _cultivo) &&
            (identical(other.tipo, tipo) || other.tipo == tipo) &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_cultivo), tipo, id);

  @override
  String toString() {
    return 'CropTypes(cultivo: $cultivo, tipo: $tipo, id: $id)';
  }
}

/// @nodoc
abstract mixin class _$CropTypesCopyWith<$Res>
    implements $CropTypesCopyWith<$Res> {
  factory _$CropTypesCopyWith(
          _CropTypes value, $Res Function(_CropTypes) _then) =
      __$CropTypesCopyWithImpl;
  @override
  @useResult
  $Res call({List<String> cultivo, String tipo, String? id});
}

/// @nodoc
class __$CropTypesCopyWithImpl<$Res> implements _$CropTypesCopyWith<$Res> {
  __$CropTypesCopyWithImpl(this._self, this._then);

  final _CropTypes _self;
  final $Res Function(_CropTypes) _then;

  /// Create a copy of CropTypes
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? cultivo = null,
    Object? tipo = null,
    Object? id = freezed,
  }) {
    return _then(_CropTypes(
      cultivo: null == cultivo
          ? _self._cultivo
          : cultivo // ignore: cast_nullable_to_non_nullable
              as List<String>,
      tipo: null == tipo
          ? _self.tipo
          : tipo // ignore: cast_nullable_to_non_nullable
              as String,
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
