// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'description.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Description {
  String get description; // Description of the object.
  String get costOrExpense; // Cost or expense associated with the object.
  String get type;

  /// Create a copy of Description
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DescriptionCopyWith<Description> get copyWith =>
      _$DescriptionCopyWithImpl<Description>(this as Description, _$identity);

  /// Serializes this Description to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Description &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.costOrExpense, costOrExpense) ||
                other.costOrExpense == costOrExpense) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, description, costOrExpense, type);

  @override
  String toString() {
    return 'Description(description: $description, costOrExpense: $costOrExpense, type: $type)';
  }
}

/// @nodoc
abstract mixin class $DescriptionCopyWith<$Res> {
  factory $DescriptionCopyWith(
          Description value, $Res Function(Description) _then) =
      _$DescriptionCopyWithImpl;
  @useResult
  $Res call({String description, String costOrExpense, String type});
}

/// @nodoc
class _$DescriptionCopyWithImpl<$Res> implements $DescriptionCopyWith<$Res> {
  _$DescriptionCopyWithImpl(this._self, this._then);

  final Description _self;
  final $Res Function(Description) _then;

  /// Create a copy of Description
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? description = null,
    Object? costOrExpense = null,
    Object? type = null,
  }) {
    return _then(_self.copyWith(
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      costOrExpense: null == costOrExpense
          ? _self.costOrExpense
          : costOrExpense // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _Description implements Description {
  _Description(
      {required this.description,
      required this.costOrExpense,
      required this.type});
  factory _Description.fromJson(Map<String, dynamic> json) =>
      _$DescriptionFromJson(json);

  @override
  final String description;
// Description of the object.
  @override
  final String costOrExpense;
// Cost or expense associated with the object.
  @override
  final String type;

  /// Create a copy of Description
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DescriptionCopyWith<_Description> get copyWith =>
      __$DescriptionCopyWithImpl<_Description>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$DescriptionToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Description &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.costOrExpense, costOrExpense) ||
                other.costOrExpense == costOrExpense) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, description, costOrExpense, type);

  @override
  String toString() {
    return 'Description(description: $description, costOrExpense: $costOrExpense, type: $type)';
  }
}

/// @nodoc
abstract mixin class _$DescriptionCopyWith<$Res>
    implements $DescriptionCopyWith<$Res> {
  factory _$DescriptionCopyWith(
          _Description value, $Res Function(_Description) _then) =
      __$DescriptionCopyWithImpl;
  @override
  @useResult
  $Res call({String description, String costOrExpense, String type});
}

/// @nodoc
class __$DescriptionCopyWithImpl<$Res> implements _$DescriptionCopyWith<$Res> {
  __$DescriptionCopyWithImpl(this._self, this._then);

  final _Description _self;
  final $Res Function(_Description) _then;

  /// Create a copy of Description
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? description = null,
    Object? costOrExpense = null,
    Object? type = null,
  }) {
    return _then(_Description(
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      costOrExpense: null == costOrExpense
          ? _self.costOrExpense
          : costOrExpense // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
