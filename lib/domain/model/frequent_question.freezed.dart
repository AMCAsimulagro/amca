/// {@category Domain}
/// This file contains the generated code for JSON serialization and deserialization of the FrequentQuestion class.
/// It includes functions to convert FrequentQuestion objects to and from JSON maps.
/// This code is generated automatically by the Freezed package.

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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FrequentQuestion _$FrequentQuestionFromJson(Map<String, dynamic> json) {
  return _FrequentQuestion.fromJson(json);
}

/// @nodoc
mixin _$FrequentQuestion {
  String? get id => throw _privateConstructorUsedError;
  set id(String? value) => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  set title(String value) => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  set content(String value) => throw _privateConstructorUsedError;
  String? get createdById => throw _privateConstructorUsedError;
  set createdById(String? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
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
abstract class _$$_FrequentQuestionCopyWith<$Res>
    implements $FrequentQuestionCopyWith<$Res> {
  factory _$$_FrequentQuestionCopyWith(
          _$_FrequentQuestion value, $Res Function(_$_FrequentQuestion) then) =
      __$$_FrequentQuestionCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? id, String title, String content, String? createdById});
}

/// @nodoc
class __$$_FrequentQuestionCopyWithImpl<$Res>
    extends _$FrequentQuestionCopyWithImpl<$Res, _$_FrequentQuestion>
    implements _$$_FrequentQuestionCopyWith<$Res> {
  __$$_FrequentQuestionCopyWithImpl(
      _$_FrequentQuestion _value, $Res Function(_$_FrequentQuestion) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = null,
    Object? content = null,
    Object? createdById = freezed,
  }) {
    return _then(_$_FrequentQuestion(
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
class _$_FrequentQuestion implements _FrequentQuestion {
  _$_FrequentQuestion(
      {this.id, required this.title, required this.content, this.createdById});

  factory _$_FrequentQuestion.fromJson(Map<String, dynamic> json) =>
      _$$_FrequentQuestionFromJson(json);

  @override
  String? id;
  @override
  String title;
  @override
  String content;
  @override
  String? createdById;

  @override
  String toString() {
    return 'FrequentQuestion(id: $id, title: $title, content: $content, createdById: $createdById)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FrequentQuestionCopyWith<_$_FrequentQuestion> get copyWith =>
      __$$_FrequentQuestionCopyWithImpl<_$_FrequentQuestion>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FrequentQuestionToJson(
      this,
    );
  }
}

abstract class _FrequentQuestion implements FrequentQuestion {
  factory _FrequentQuestion(
      {String? id,
      required String title,
      required String content,
      String? createdById}) = _$_FrequentQuestion;

  factory _FrequentQuestion.fromJson(Map<String, dynamic> json) =
      _$_FrequentQuestion.fromJson;

  @override
  String? get id;
  set id(String? value);
  @override
  String get title;
  set title(String value);
  @override
  String get content;
  set content(String value);
  @override
  String? get createdById;
  set createdById(String? value);
  @override
  @JsonKey(ignore: true)
  _$$_FrequentQuestionCopyWith<_$_FrequentQuestion> get copyWith =>
      throw _privateConstructorUsedError;
}
