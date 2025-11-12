// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'amca_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AmcaUser {
  String get names;
  set names(String value);
  String get firstLastName;
  set firstLastName(String value);
  String get secondLastName;
  set secondLastName(String value);
  String get identification;
  String get state;
  set state(String value);
  String get town;
  set town(String value);
  String get email;
  set email(String value);
  String? get uid;
  set uid(String? value);
  bool? get isAdmin;
  set isAdmin(bool? value);

  /// Create a copy of AmcaUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AmcaUserCopyWith<AmcaUser> get copyWith =>
      _$AmcaUserCopyWithImpl<AmcaUser>(this as AmcaUser, _$identity);

  /// Serializes this AmcaUser to a JSON map.
  Map<String, dynamic> toJson();

  @override
  String toString() {
    return 'AmcaUser(names: $names, firstLastName: $firstLastName, secondLastName: $secondLastName, identification: $identification, state: $state, town: $town, email: $email, uid: $uid, isAdmin: $isAdmin)';
  }
}

/// @nodoc
abstract mixin class $AmcaUserCopyWith<$Res> {
  factory $AmcaUserCopyWith(AmcaUser value, $Res Function(AmcaUser) _then) =
      _$AmcaUserCopyWithImpl;
  @useResult
  $Res call(
      {String names,
      String firstLastName,
      String secondLastName,
      String identification,
      String state,
      String town,
      String email,
      String? uid,
      bool? isAdmin});
}

/// @nodoc
class _$AmcaUserCopyWithImpl<$Res> implements $AmcaUserCopyWith<$Res> {
  _$AmcaUserCopyWithImpl(this._self, this._then);

  final AmcaUser _self;
  final $Res Function(AmcaUser) _then;

  /// Create a copy of AmcaUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? names = null,
    Object? firstLastName = null,
    Object? secondLastName = null,
    Object? identification = null,
    Object? state = null,
    Object? town = null,
    Object? email = null,
    Object? uid = freezed,
    Object? isAdmin = freezed,
  }) {
    return _then(_self.copyWith(
      names: null == names
          ? _self.names
          : names // ignore: cast_nullable_to_non_nullable
              as String,
      firstLastName: null == firstLastName
          ? _self.firstLastName
          : firstLastName // ignore: cast_nullable_to_non_nullable
              as String,
      secondLastName: null == secondLastName
          ? _self.secondLastName
          : secondLastName // ignore: cast_nullable_to_non_nullable
              as String,
      identification: null == identification
          ? _self.identification
          : identification // ignore: cast_nullable_to_non_nullable
              as String,
      state: null == state
          ? _self.state
          : state // ignore: cast_nullable_to_non_nullable
              as String,
      town: null == town
          ? _self.town
          : town // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      uid: freezed == uid
          ? _self.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String?,
      isAdmin: freezed == isAdmin
          ? _self.isAdmin
          : isAdmin // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _AmcaUser implements AmcaUser {
  _AmcaUser(
      {required this.names,
      required this.firstLastName,
      required this.secondLastName,
      required this.identification,
      required this.state,
      required this.town,
      required this.email,
      this.uid,
      this.isAdmin = false});
  factory _AmcaUser.fromJson(Map<String, dynamic> json) =>
      _$AmcaUserFromJson(json);

  @override
  String names;
  @override
  String firstLastName;
  @override
  String secondLastName;
  @override
  final String identification;
  @override
  String state;
  @override
  String town;
  @override
  String email;
  @override
  String? uid;
  @override
  @JsonKey()
  bool? isAdmin;

  /// Create a copy of AmcaUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AmcaUserCopyWith<_AmcaUser> get copyWith =>
      __$AmcaUserCopyWithImpl<_AmcaUser>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AmcaUserToJson(
      this,
    );
  }

  @override
  String toString() {
    return 'AmcaUser(names: $names, firstLastName: $firstLastName, secondLastName: $secondLastName, identification: $identification, state: $state, town: $town, email: $email, uid: $uid, isAdmin: $isAdmin)';
  }
}

/// @nodoc
abstract mixin class _$AmcaUserCopyWith<$Res>
    implements $AmcaUserCopyWith<$Res> {
  factory _$AmcaUserCopyWith(_AmcaUser value, $Res Function(_AmcaUser) _then) =
      __$AmcaUserCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String names,
      String firstLastName,
      String secondLastName,
      String identification,
      String state,
      String town,
      String email,
      String? uid,
      bool? isAdmin});
}

/// @nodoc
class __$AmcaUserCopyWithImpl<$Res> implements _$AmcaUserCopyWith<$Res> {
  __$AmcaUserCopyWithImpl(this._self, this._then);

  final _AmcaUser _self;
  final $Res Function(_AmcaUser) _then;

  /// Create a copy of AmcaUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? names = null,
    Object? firstLastName = null,
    Object? secondLastName = null,
    Object? identification = null,
    Object? state = null,
    Object? town = null,
    Object? email = null,
    Object? uid = freezed,
    Object? isAdmin = freezed,
  }) {
    return _then(_AmcaUser(
      names: null == names
          ? _self.names
          : names // ignore: cast_nullable_to_non_nullable
              as String,
      firstLastName: null == firstLastName
          ? _self.firstLastName
          : firstLastName // ignore: cast_nullable_to_non_nullable
              as String,
      secondLastName: null == secondLastName
          ? _self.secondLastName
          : secondLastName // ignore: cast_nullable_to_non_nullable
              as String,
      identification: null == identification
          ? _self.identification
          : identification // ignore: cast_nullable_to_non_nullable
              as String,
      state: null == state
          ? _self.state
          : state // ignore: cast_nullable_to_non_nullable
              as String,
      town: null == town
          ? _self.town
          : town // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      uid: freezed == uid
          ? _self.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String?,
      isAdmin: freezed == isAdmin
          ? _self.isAdmin
          : isAdmin // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

// dart format on
