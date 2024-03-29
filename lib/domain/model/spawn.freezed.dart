/// {@category Domain}
/// This file defines a Spawn class using Freezed and JsonSerializable annotations.
/// The Spawn class represents a spawn with a list of types.
/// It is designed to be immutable and provides methods for JSON serialization and deserialization.
/// This file includes both the definition of the Spawn class and the generated code for JSON serialization/deserialization.
/// Freezed annotations are used to generate constructors and equality checks for the class, while JsonSerializable annotations
/// are used to generate toJson() and fromJson() methods for serialization and deserialization.

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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Spawn _$SpawnFromJson(Map<String, dynamic> json) {
  return _Spawn.fromJson(json);
}

/// @nodoc
mixin _$Spawn {
  List<String> get tipo => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
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
abstract class _$$_SpawnCopyWith<$Res> implements $SpawnCopyWith<$Res> {
  factory _$$_SpawnCopyWith(_$_Spawn value, $Res Function(_$_Spawn) then) =
      __$$_SpawnCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<String> tipo});
}

/// @nodoc
class __$$_SpawnCopyWithImpl<$Res> extends _$SpawnCopyWithImpl<$Res, _$_Spawn>
    implements _$$_SpawnCopyWith<$Res> {
  __$$_SpawnCopyWithImpl(_$_Spawn _value, $Res Function(_$_Spawn) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tipo = null,
  }) {
    return _then(_$_Spawn(
      tipo: null == tipo
          ? _value._tipo
          : tipo // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Spawn implements _Spawn {
  _$_Spawn({required final List<String> tipo}) : _tipo = tipo;

  factory _$_Spawn.fromJson(Map<String, dynamic> json) =>
      _$$_SpawnFromJson(json);

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
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Spawn &&
            const DeepCollectionEquality().equals(other._tipo, _tipo));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_tipo));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SpawnCopyWith<_$_Spawn> get copyWith =>
      __$$_SpawnCopyWithImpl<_$_Spawn>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SpawnToJson(
      this,
    );
  }
}

abstract class _Spawn implements Spawn {
  factory _Spawn({required final List<String> tipo}) = _$_Spawn;

  factory _Spawn.fromJson(Map<String, dynamic> json) = _$_Spawn.fromJson;

  @override
  List<String> get tipo;
  @override
  @JsonKey(ignore: true)
  _$$_SpawnCopyWith<_$_Spawn> get copyWith =>
      throw _privateConstructorUsedError;
}
