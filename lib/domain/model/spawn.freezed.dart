// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'spawn.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Spawn {
  List<String> get tipo;

  /// Create a copy of Spawn
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SpawnCopyWith<Spawn> get copyWith =>
      _$SpawnCopyWithImpl<Spawn>(this as Spawn, _$identity);

  /// Serializes this Spawn to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Spawn &&
            const DeepCollectionEquality().equals(other.tipo, tipo));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(tipo));

  @override
  String toString() {
    return 'Spawn(tipo: $tipo)';
  }
}

/// @nodoc
abstract mixin class $SpawnCopyWith<$Res> {
  factory $SpawnCopyWith(Spawn value, $Res Function(Spawn) _then) =
      _$SpawnCopyWithImpl;
  @useResult
  $Res call({List<String> tipo});
}

/// @nodoc
class _$SpawnCopyWithImpl<$Res> implements $SpawnCopyWith<$Res> {
  _$SpawnCopyWithImpl(this._self, this._then);

  final Spawn _self;
  final $Res Function(Spawn) _then;

  /// Create a copy of Spawn
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tipo = null,
  }) {
    return _then(_self.copyWith(
      tipo: null == tipo
          ? _self.tipo
          : tipo // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _Spawn implements Spawn {
  _Spawn({required final List<String> tipo}) : _tipo = tipo;
  factory _Spawn.fromJson(Map<String, dynamic> json) => _$SpawnFromJson(json);

  final List<String> _tipo;
  @override
  List<String> get tipo {
    if (_tipo is EqualUnmodifiableListView) return _tipo;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tipo);
  }

  /// Create a copy of Spawn
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SpawnCopyWith<_Spawn> get copyWith =>
      __$SpawnCopyWithImpl<_Spawn>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SpawnToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Spawn &&
            const DeepCollectionEquality().equals(other._tipo, _tipo));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_tipo));

  @override
  String toString() {
    return 'Spawn(tipo: $tipo)';
  }
}

/// @nodoc
abstract mixin class _$SpawnCopyWith<$Res> implements $SpawnCopyWith<$Res> {
  factory _$SpawnCopyWith(_Spawn value, $Res Function(_Spawn) _then) =
      __$SpawnCopyWithImpl;
  @override
  @useResult
  $Res call({List<String> tipo});
}

/// @nodoc
class __$SpawnCopyWithImpl<$Res> implements _$SpawnCopyWith<$Res> {
  __$SpawnCopyWithImpl(this._self, this._then);

  final _Spawn _self;
  final $Res Function(_Spawn) _then;

  /// Create a copy of Spawn
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? tipo = null,
  }) {
    return _then(_Spawn(
      tipo: null == tipo
          ? _self._tipo
          : tipo // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

// dart format on
