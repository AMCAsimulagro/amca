// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'frequent_question.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FrequentQuestion {
  String? get id;
  set id(String? value); // ID of the question.
  String get title; // ID of the question.
  set title(String value); // Title of the question.
  String get content; // Title of the question.
  set content(String value); // Content of the question.
  String? get createdById; // Content of the question.
  set createdById(String? value);

  /// Create a copy of FrequentQuestion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $FrequentQuestionCopyWith<FrequentQuestion> get copyWith =>
      _$FrequentQuestionCopyWithImpl<FrequentQuestion>(
          this as FrequentQuestion, _$identity);

  /// Serializes this FrequentQuestion to a JSON map.
  Map<String, dynamic> toJson();

  @override
  String toString() {
    return 'FrequentQuestion(id: $id, title: $title, content: $content, createdById: $createdById)';
  }
}

/// @nodoc
abstract mixin class $FrequentQuestionCopyWith<$Res> {
  factory $FrequentQuestionCopyWith(
          FrequentQuestion value, $Res Function(FrequentQuestion) _then) =
      _$FrequentQuestionCopyWithImpl;
  @useResult
  $Res call({String? id, String title, String content, String? createdById});
}

/// @nodoc
class _$FrequentQuestionCopyWithImpl<$Res>
    implements $FrequentQuestionCopyWith<$Res> {
  _$FrequentQuestionCopyWithImpl(this._self, this._then);

  final FrequentQuestion _self;
  final $Res Function(FrequentQuestion) _then;

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
    return _then(_self.copyWith(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _self.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      createdById: freezed == createdById
          ? _self.createdById
          : createdById // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _FrequentQuestion implements FrequentQuestion {
  _FrequentQuestion(
      {this.id, required this.title, required this.content, this.createdById});
  factory _FrequentQuestion.fromJson(Map<String, dynamic> json) =>
      _$FrequentQuestionFromJson(json);

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

  /// Create a copy of FrequentQuestion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$FrequentQuestionCopyWith<_FrequentQuestion> get copyWith =>
      __$FrequentQuestionCopyWithImpl<_FrequentQuestion>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$FrequentQuestionToJson(
      this,
    );
  }

  @override
  String toString() {
    return 'FrequentQuestion(id: $id, title: $title, content: $content, createdById: $createdById)';
  }
}

/// @nodoc
abstract mixin class _$FrequentQuestionCopyWith<$Res>
    implements $FrequentQuestionCopyWith<$Res> {
  factory _$FrequentQuestionCopyWith(
          _FrequentQuestion value, $Res Function(_FrequentQuestion) _then) =
      __$FrequentQuestionCopyWithImpl;
  @override
  @useResult
  $Res call({String? id, String title, String content, String? createdById});
}

/// @nodoc
class __$FrequentQuestionCopyWithImpl<$Res>
    implements _$FrequentQuestionCopyWith<$Res> {
  __$FrequentQuestionCopyWithImpl(this._self, this._then);

  final _FrequentQuestion _self;
  final $Res Function(_FrequentQuestion) _then;

  /// Create a copy of FrequentQuestion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = freezed,
    Object? title = null,
    Object? content = null,
    Object? createdById = freezed,
  }) {
    return _then(_FrequentQuestion(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _self.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      createdById: freezed == createdById
          ? _self.createdById
          : createdById // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
