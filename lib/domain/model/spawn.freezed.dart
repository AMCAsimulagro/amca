// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'spawn.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Spawn _$SpawnFromJson(Map<String, dynamic> json) {
  return _Spawn.fromJson(json);
}

/// @nodoc
mixin _$Spawn {
  List<String> get tipo => throw _privateConstructorUsedError;

  /// Serializes this Spawn to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Spawn
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SpawnCopyWith<Spawn> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SpawnCopyWith<$Res> {
  factory $SpawnCopyWith(Spawn value, $Res Function(Spawn) then) =
      _$SpawnCopyWithImpl<$Res, Spawn>;
  @useResult
  $Res call({List<String> tipo});
}

/// @nodoc
class _$SpawnCopyWithImpl<$Res, $Val extends Spawn>
    implements $SpawnCopyWith<$Res> {
  _$SpawnCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Spawn
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tipo = null,
  }) {
    return _then(_value.copyWith(
      tipo: null == tipo
          ? _value.tipo
          : tipo // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SpawnImplCopyWith<$Res> implements $SpawnCopyWith<$Res> {
  factory _$$SpawnImplCopyWith(
          _$SpawnImpl value, $Res Function(_$SpawnImpl) then) =
      __$$SpawnImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<String> tipo});
}

/// @nodoc
class __$$SpawnImplCopyWithImpl<$Res>
    extends _$SpawnCopyWithImpl<$Res, _$SpawnImpl>
    implements _$$SpawnImplCopyWith<$Res> {
  __$$SpawnImplCopyWithImpl(
      _$SpawnImpl _value, $Res Function(_$SpawnImpl) _then)
      : super(_value, _then);

  /// Create a copy of Spawn
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tipo = null,
  }) {
    return _then(_$SpawnImpl(
      tipo: null == tipo
          ? _value._tipo
          : tipo // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SpawnImpl implements _Spawn {
  _$SpawnImpl({required final List<String> tipo}) : _tipo = tipo;

  factory _$SpawnImpl.fromJson(Map<String, dynamic> json) =>
      _$$SpawnImplFromJson(json);

  final List<String> _tipo;
  @override
  List<String> get tipo {
    if (_tipo is EqualUnmodifiableListView) return _tipo;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tipo);
  }

  @override
  String toString() {
    return 'Spawn(tipo: $tipo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SpawnImpl &&
            const DeepCollectionEquality().equals(other._tipo, _tipo));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_tipo));

  /// Create a copy of Spawn
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SpawnImplCopyWith<_$SpawnImpl> get copyWith =>
      __$$SpawnImplCopyWithImpl<_$SpawnImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SpawnImplToJson(
      this,
    );
  }
}

abstract class _Spawn implements Spawn {
  factory _Spawn({required final List<String> tipo}) = _$SpawnImpl;

  factory _Spawn.fromJson(Map<String, dynamic> json) = _$SpawnImpl.fromJson;

  @override
  List<String> get tipo;

  /// Create a copy of Spawn
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SpawnImplCopyWith<_$SpawnImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
