// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'frequent_question.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FrequentQuestion _$FrequentQuestionFromJson(Map<String, dynamic> json) {
  return _FrequentQuestion.fromJson(json);
}

/// @nodoc
mixin _$FrequentQuestion {
  String? get id => throw _privateConstructorUsedError;
  set id(String? value) =>
      throw _privateConstructorUsedError; // ID of the question.
  String get title => throw _privateConstructorUsedError; // ID of the question.
  set title(String value) =>
      throw _privateConstructorUsedError; // Title of the question.
  String get content =>
      throw _privateConstructorUsedError; // Title of the question.
  set content(String value) =>
      throw _privateConstructorUsedError; // Content of the question.
  String? get createdById =>
      throw _privateConstructorUsedError; // Content of the question.
  set createdById(String? value) => throw _privateConstructorUsedError;

  /// Serializes this FrequentQuestion to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FrequentQuestion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FrequentQuestionCopyWith<FrequentQuestion> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FrequentQuestionCopyWith<$Res> {
  factory $FrequentQuestionCopyWith(
          FrequentQuestion value, $Res Function(FrequentQuestion) then) =
      _$FrequentQuestionCopyWithImpl<$Res, FrequentQuestion>;
  @useResult
  $Res call({String? id, String title, String content, String? createdById});
}

/// @nodoc
class _$FrequentQuestionCopyWithImpl<$Res, $Val extends FrequentQuestion>
    implements $FrequentQuestionCopyWith<$Res> {
  _$FrequentQuestionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FrequentQuestion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = null,
    Object? content = null,
    Object? createdById = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      createdById: freezed == createdById
          ? _value.createdById
          : createdById // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FrequentQuestionImplCopyWith<$Res>
    implements $FrequentQuestionCopyWith<$Res> {
  factory _$$FrequentQuestionImplCopyWith(_$FrequentQuestionImpl value,
          $Res Function(_$FrequentQuestionImpl) then) =
      __$$FrequentQuestionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? id, String title, String content, String? createdById});
}

/// @nodoc
class __$$FrequentQuestionImplCopyWithImpl<$Res>
    extends _$FrequentQuestionCopyWithImpl<$Res, _$FrequentQuestionImpl>
    implements _$$FrequentQuestionImplCopyWith<$Res> {
  __$$FrequentQuestionImplCopyWithImpl(_$FrequentQuestionImpl _value,
      $Res Function(_$FrequentQuestionImpl) _then)
      : super(_value, _then);

  /// Create a copy of FrequentQuestion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = null,
    Object? content = null,
    Object? createdById = freezed,
  }) {
    return _then(_$FrequentQuestionImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      createdById: freezed == createdById
          ? _value.createdById
          : createdById // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FrequentQuestionImpl implements _FrequentQuestion {
  _$FrequentQuestionImpl(
      {this.id, required this.title, required this.content, this.createdById});

  factory _$FrequentQuestionImpl.fromJson(Map<String, dynamic> json) =>
      _$$FrequentQuestionImplFromJson(json);

  @override
  String? id;
// ID of the question.
  @override
  String title;
// Title of the question.
  @override
  String content;
// Content of the question.
  @override
  String? createdById;

  @override
  String toString() {
    return 'FrequentQuestion(id: $id, title: $title, content: $content, createdById: $createdById)';
  }

  /// Create a copy of FrequentQuestion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FrequentQuestionImplCopyWith<_$FrequentQuestionImpl> get copyWith =>
      __$$FrequentQuestionImplCopyWithImpl<_$FrequentQuestionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FrequentQuestionImplToJson(
      this,
    );
  }
}

abstract class _FrequentQuestion implements FrequentQuestion {
  factory _FrequentQuestion(
      {String? id,
      required String title,
      required String content,
      String? createdById}) = _$FrequentQuestionImpl;

  factory _FrequentQuestion.fromJson(Map<String, dynamic> json) =
      _$FrequentQuestionImpl.fromJson;

  @override
  String? get id;
  set id(String? value); // ID of the question.
  @override
  String get title; // ID of the question.
  set title(String value); // Title of the question.
  @override
  String get content; // Title of the question.
  set content(String value); // Content of the question.
  @override
  String? get createdById; // Content of the question.
  set createdById(String? value);

  /// Create a copy of FrequentQuestion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FrequentQuestionImplCopyWith<_$FrequentQuestionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
