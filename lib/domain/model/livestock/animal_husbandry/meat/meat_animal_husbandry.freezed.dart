// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'meat_animal_husbandry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MeatAnimalHusbandry _$MeatAnimalHusbandryFromJson(Map<String, dynamic> json) {
  return _MeetAnimalHusbandry.fromJson(json);
}

/// @nodoc
mixin _$MeatAnimalHusbandry {
  String? get id => throw _privateConstructorUsedError;
  set id(String? value) => throw _privateConstructorUsedError;
  DateTime get createDate => throw _privateConstructorUsedError;
  set createDate(DateTime value) => throw _privateConstructorUsedError;
  String get totalProfit => throw _privateConstructorUsedError;
  set totalProfit(String value) => throw _privateConstructorUsedError;
  String get farmName => throw _privateConstructorUsedError;
  set farmName(String value) => throw _privateConstructorUsedError;
  String get numberAnimals => throw _privateConstructorUsedError;
  set numberAnimals(String value) => throw _privateConstructorUsedError;
  String get value => throw _privateConstructorUsedError;
  set value(String value) => throw _privateConstructorUsedError;
  String? get uidOwner => throw _privateConstructorUsedError;
  set uidOwner(String? value) => throw _privateConstructorUsedError;
  String? get comment => throw _privateConstructorUsedError;
  set comment(String? value) => throw _privateConstructorUsedError;
  List<CostAndExpense>? get costsAndExpenses =>
      throw _privateConstructorUsedError;
  set costsAndExpenses(List<CostAndExpense>? value) =>
      throw _privateConstructorUsedError;
  Production? get production => throw _privateConstructorUsedError;
  set production(Production? value) => throw _privateConstructorUsedError;

  /// Serializes this MeatAnimalHusbandry to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MeatAnimalHusbandry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MeatAnimalHusbandryCopyWith<MeatAnimalHusbandry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MeatAnimalHusbandryCopyWith<$Res> {
  factory $MeatAnimalHusbandryCopyWith(
          MeatAnimalHusbandry value, $Res Function(MeatAnimalHusbandry) then) =
      _$MeatAnimalHusbandryCopyWithImpl<$Res, MeatAnimalHusbandry>;
  @useResult
  $Res call(
      {String? id,
      DateTime createDate,
      String totalProfit,
      String farmName,
      String numberAnimals,
      String value,
      String? uidOwner,
      String? comment,
      List<CostAndExpense>? costsAndExpenses,
      Production? production});

  $ProductionCopyWith<$Res>? get production;
}

/// @nodoc
class _$MeatAnimalHusbandryCopyWithImpl<$Res, $Val extends MeatAnimalHusbandry>
    implements $MeatAnimalHusbandryCopyWith<$Res> {
  _$MeatAnimalHusbandryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MeatAnimalHusbandry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? createDate = null,
    Object? totalProfit = null,
    Object? farmName = null,
    Object? numberAnimals = null,
    Object? value = null,
    Object? uidOwner = freezed,
    Object? comment = freezed,
    Object? costsAndExpenses = freezed,
    Object? production = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      createDate: null == createDate
          ? _value.createDate
          : createDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      totalProfit: null == totalProfit
          ? _value.totalProfit
          : totalProfit // ignore: cast_nullable_to_non_nullable
              as String,
      farmName: null == farmName
          ? _value.farmName
          : farmName // ignore: cast_nullable_to_non_nullable
              as String,
      numberAnimals: null == numberAnimals
          ? _value.numberAnimals
          : numberAnimals // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
      uidOwner: freezed == uidOwner
          ? _value.uidOwner
          : uidOwner // ignore: cast_nullable_to_non_nullable
              as String?,
      comment: freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
      costsAndExpenses: freezed == costsAndExpenses
          ? _value.costsAndExpenses
          : costsAndExpenses // ignore: cast_nullable_to_non_nullable
              as List<CostAndExpense>?,
      production: freezed == production
          ? _value.production
          : production // ignore: cast_nullable_to_non_nullable
              as Production?,
    ) as $Val);
  }

  /// Create a copy of MeatAnimalHusbandry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProductionCopyWith<$Res>? get production {
    if (_value.production == null) {
      return null;
    }

    return $ProductionCopyWith<$Res>(_value.production!, (value) {
      return _then(_value.copyWith(production: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MeetAnimalHusbandryImplCopyWith<$Res>
    implements $MeatAnimalHusbandryCopyWith<$Res> {
  factory _$$MeetAnimalHusbandryImplCopyWith(_$MeetAnimalHusbandryImpl value,
          $Res Function(_$MeetAnimalHusbandryImpl) then) =
      __$$MeetAnimalHusbandryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      DateTime createDate,
      String totalProfit,
      String farmName,
      String numberAnimals,
      String value,
      String? uidOwner,
      String? comment,
      List<CostAndExpense>? costsAndExpenses,
      Production? production});

  @override
  $ProductionCopyWith<$Res>? get production;
}

/// @nodoc
class __$$MeetAnimalHusbandryImplCopyWithImpl<$Res>
    extends _$MeatAnimalHusbandryCopyWithImpl<$Res, _$MeetAnimalHusbandryImpl>
    implements _$$MeetAnimalHusbandryImplCopyWith<$Res> {
  __$$MeetAnimalHusbandryImplCopyWithImpl(_$MeetAnimalHusbandryImpl _value,
      $Res Function(_$MeetAnimalHusbandryImpl) _then)
      : super(_value, _then);

  /// Create a copy of MeatAnimalHusbandry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? createDate = null,
    Object? totalProfit = null,
    Object? farmName = null,
    Object? numberAnimals = null,
    Object? value = null,
    Object? uidOwner = freezed,
    Object? comment = freezed,
    Object? costsAndExpenses = freezed,
    Object? production = freezed,
  }) {
    return _then(_$MeetAnimalHusbandryImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      createDate: null == createDate
          ? _value.createDate
          : createDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      totalProfit: null == totalProfit
          ? _value.totalProfit
          : totalProfit // ignore: cast_nullable_to_non_nullable
              as String,
      farmName: null == farmName
          ? _value.farmName
          : farmName // ignore: cast_nullable_to_non_nullable
              as String,
      numberAnimals: null == numberAnimals
          ? _value.numberAnimals
          : numberAnimals // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
      uidOwner: freezed == uidOwner
          ? _value.uidOwner
          : uidOwner // ignore: cast_nullable_to_non_nullable
              as String?,
      comment: freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
      costsAndExpenses: freezed == costsAndExpenses
          ? _value.costsAndExpenses
          : costsAndExpenses // ignore: cast_nullable_to_non_nullable
              as List<CostAndExpense>?,
      production: freezed == production
          ? _value.production
          : production // ignore: cast_nullable_to_non_nullable
              as Production?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MeetAnimalHusbandryImpl extends _MeetAnimalHusbandry
    with DiagnosticableTreeMixin {
  _$MeetAnimalHusbandryImpl(
      {this.id,
      required this.createDate,
      required this.totalProfit,
      required this.farmName,
      required this.numberAnimals,
      required this.value,
      this.uidOwner,
      this.comment,
      this.costsAndExpenses,
      this.production})
      : super._();

  factory _$MeetAnimalHusbandryImpl.fromJson(Map<String, dynamic> json) =>
      _$$MeetAnimalHusbandryImplFromJson(json);

  @override
  String? id;
  @override
  DateTime createDate;
  @override
  String totalProfit;
  @override
  String farmName;
  @override
  String numberAnimals;
  @override
  String value;
  @override
  String? uidOwner;
  @override
  String? comment;
  @override
  List<CostAndExpense>? costsAndExpenses;
  @override
  Production? production;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MeatAnimalHusbandry(id: $id, createDate: $createDate, totalProfit: $totalProfit, farmName: $farmName, numberAnimals: $numberAnimals, value: $value, uidOwner: $uidOwner, comment: $comment, costsAndExpenses: $costsAndExpenses, production: $production)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'MeatAnimalHusbandry'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('createDate', createDate))
      ..add(DiagnosticsProperty('totalProfit', totalProfit))
      ..add(DiagnosticsProperty('farmName', farmName))
      ..add(DiagnosticsProperty('numberAnimals', numberAnimals))
      ..add(DiagnosticsProperty('value', value))
      ..add(DiagnosticsProperty('uidOwner', uidOwner))
      ..add(DiagnosticsProperty('comment', comment))
      ..add(DiagnosticsProperty('costsAndExpenses', costsAndExpenses))
      ..add(DiagnosticsProperty('production', production));
  }

  /// Create a copy of MeatAnimalHusbandry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MeetAnimalHusbandryImplCopyWith<_$MeetAnimalHusbandryImpl> get copyWith =>
      __$$MeetAnimalHusbandryImplCopyWithImpl<_$MeetAnimalHusbandryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MeetAnimalHusbandryImplToJson(
      this,
    );
  }
}

abstract class _MeetAnimalHusbandry extends MeatAnimalHusbandry {
  factory _MeetAnimalHusbandry(
      {String? id,
      required DateTime createDate,
      required String totalProfit,
      required String farmName,
      required String numberAnimals,
      required String value,
      String? uidOwner,
      String? comment,
      List<CostAndExpense>? costsAndExpenses,
      Production? production}) = _$MeetAnimalHusbandryImpl;
  _MeetAnimalHusbandry._() : super._();

  factory _MeetAnimalHusbandry.fromJson(Map<String, dynamic> json) =
      _$MeetAnimalHusbandryImpl.fromJson;

  @override
  String? get id;
  set id(String? value);
  @override
  DateTime get createDate;
  set createDate(DateTime value);
  @override
  String get totalProfit;
  set totalProfit(String value);
  @override
  String get farmName;
  set farmName(String value);
  @override
  String get numberAnimals;
  set numberAnimals(String value);
  @override
  String get value;
  set value(String value);
  @override
  String? get uidOwner;
  set uidOwner(String? value);
  @override
  String? get comment;
  set comment(String? value);
  @override
  List<CostAndExpense>? get costsAndExpenses;
  set costsAndExpenses(List<CostAndExpense>? value);
  @override
  Production? get production;
  set production(Production? value);

  /// Create a copy of MeatAnimalHusbandry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MeetAnimalHusbandryImplCopyWith<_$MeetAnimalHusbandryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
