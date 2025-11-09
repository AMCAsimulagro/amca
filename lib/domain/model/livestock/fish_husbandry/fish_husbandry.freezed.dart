// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fish_husbandry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FishHusbandry _$FishHusbandryFromJson(Map<String, dynamic> json) {
  return _FishHusbandry.fromJson(json);
}

/// @nodoc
mixin _$FishHusbandry {
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
  String? get fishType => throw _privateConstructorUsedError;
  set fishType(String? value) => throw _privateConstructorUsedError;
  List<CostAndExpense>? get costsAndExpenses =>
      throw _privateConstructorUsedError;
  set costsAndExpenses(List<CostAndExpense>? value) =>
      throw _privateConstructorUsedError;
  Production? get production => throw _privateConstructorUsedError;
  set production(Production? value) => throw _privateConstructorUsedError;

  /// Serializes this FishHusbandry to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FishHusbandry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FishHusbandryCopyWith<FishHusbandry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FishHusbandryCopyWith<$Res> {
  factory $FishHusbandryCopyWith(
          FishHusbandry value, $Res Function(FishHusbandry) then) =
      _$FishHusbandryCopyWithImpl<$Res, FishHusbandry>;
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
      String? fishType,
      List<CostAndExpense>? costsAndExpenses,
      Production? production});

  $ProductionCopyWith<$Res>? get production;
}

/// @nodoc
class _$FishHusbandryCopyWithImpl<$Res, $Val extends FishHusbandry>
    implements $FishHusbandryCopyWith<$Res> {
  _$FishHusbandryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FishHusbandry
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
    Object? fishType = freezed,
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
      fishType: freezed == fishType
          ? _value.fishType
          : fishType // ignore: cast_nullable_to_non_nullable
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

  /// Create a copy of FishHusbandry
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
abstract class _$$FishHusbandryImplCopyWith<$Res>
    implements $FishHusbandryCopyWith<$Res> {
  factory _$$FishHusbandryImplCopyWith(
          _$FishHusbandryImpl value, $Res Function(_$FishHusbandryImpl) then) =
      __$$FishHusbandryImplCopyWithImpl<$Res>;
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
      String? fishType,
      List<CostAndExpense>? costsAndExpenses,
      Production? production});

  @override
  $ProductionCopyWith<$Res>? get production;
}

/// @nodoc
class __$$FishHusbandryImplCopyWithImpl<$Res>
    extends _$FishHusbandryCopyWithImpl<$Res, _$FishHusbandryImpl>
    implements _$$FishHusbandryImplCopyWith<$Res> {
  __$$FishHusbandryImplCopyWithImpl(
      _$FishHusbandryImpl _value, $Res Function(_$FishHusbandryImpl) _then)
      : super(_value, _then);

  /// Create a copy of FishHusbandry
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
    Object? fishType = freezed,
    Object? costsAndExpenses = freezed,
    Object? production = freezed,
  }) {
    return _then(_$FishHusbandryImpl(
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
      fishType: freezed == fishType
          ? _value.fishType
          : fishType // ignore: cast_nullable_to_non_nullable
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
class _$FishHusbandryImpl extends _FishHusbandry with DiagnosticableTreeMixin {
  _$FishHusbandryImpl(
      {this.id,
      required this.createDate,
      required this.totalProfit,
      required this.farmName,
      required this.numberAnimals,
      required this.value,
      this.uidOwner,
      this.comment,
      this.fishType,
      this.costsAndExpenses,
      this.production})
      : super._();

  factory _$FishHusbandryImpl.fromJson(Map<String, dynamic> json) =>
      _$$FishHusbandryImplFromJson(json);

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
  String? fishType;
  @override
  List<CostAndExpense>? costsAndExpenses;
  @override
  Production? production;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'FishHusbandry(id: $id, createDate: $createDate, totalProfit: $totalProfit, farmName: $farmName, numberAnimals: $numberAnimals, value: $value, uidOwner: $uidOwner, comment: $comment, fishType: $fishType, costsAndExpenses: $costsAndExpenses, production: $production)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'FishHusbandry'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('createDate', createDate))
      ..add(DiagnosticsProperty('totalProfit', totalProfit))
      ..add(DiagnosticsProperty('farmName', farmName))
      ..add(DiagnosticsProperty('numberAnimals', numberAnimals))
      ..add(DiagnosticsProperty('value', value))
      ..add(DiagnosticsProperty('uidOwner', uidOwner))
      ..add(DiagnosticsProperty('comment', comment))
      ..add(DiagnosticsProperty('fishType', fishType))
      ..add(DiagnosticsProperty('costsAndExpenses', costsAndExpenses))
      ..add(DiagnosticsProperty('production', production));
  }

  /// Create a copy of FishHusbandry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FishHusbandryImplCopyWith<_$FishHusbandryImpl> get copyWith =>
      __$$FishHusbandryImplCopyWithImpl<_$FishHusbandryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FishHusbandryImplToJson(
      this,
    );
  }
}

abstract class _FishHusbandry extends FishHusbandry {
  factory _FishHusbandry(
      {String? id,
      required DateTime createDate,
      required String totalProfit,
      required String farmName,
      required String numberAnimals,
      required String value,
      String? uidOwner,
      String? comment,
      String? fishType,
      List<CostAndExpense>? costsAndExpenses,
      Production? production}) = _$FishHusbandryImpl;
  _FishHusbandry._() : super._();

  factory _FishHusbandry.fromJson(Map<String, dynamic> json) =
      _$FishHusbandryImpl.fromJson;

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
  String? get fishType;
  set fishType(String? value);
  @override
  List<CostAndExpense>? get costsAndExpenses;
  set costsAndExpenses(List<CostAndExpense>? value);
  @override
  Production? get production;
  set production(Production? value);

  /// Create a copy of FishHusbandry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FishHusbandryImplCopyWith<_$FishHusbandryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
