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

  List<CostAndExpense>? get costsAndExpenses =>
      throw _privateConstructorUsedError;
  set costsAndExpenses(List<CostAndExpense>? value) =>
      throw _privateConstructorUsedError;

  Production? get production => throw _privateConstructorUsedError;
  set production(Production? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
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
  $Res call({
    String? id,
    DateTime createDate,
    String totalProfit,
    String farmName,
    String numberAnimals,
    String value,
    String? uidOwner,
    String? comment,
    List<CostAndExpense>? costsAndExpenses,
    Production? production,
  });
}

/// @nodoc
class _$FishHusbandryCopyWithImpl<$Res, $Val extends FishHusbandry>
    implements $FishHusbandryCopyWith<$Res> {
  _$FishHusbandryCopyWithImpl(this._value, this._then);

  final $Val _value;
  final $Res Function($Val) _then;

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
      id: freezed == id ? _value.id : id as String?,
      createDate:
          null == createDate ? _value.createDate : createDate as DateTime,
      totalProfit:
          null == totalProfit ? _value.totalProfit : totalProfit as String,
      farmName: null == farmName ? _value.farmName : farmName as String,
      numberAnimals: null == numberAnimals
          ? _value.numberAnimals
          : numberAnimals as String,
      value: null == value ? _value.value : value as String,
      uidOwner: freezed == uidOwner ? _value.uidOwner : uidOwner as String?,
      comment: freezed == comment ? _value.comment : comment as String?,
      costsAndExpenses: freezed == costsAndExpenses
          ? _value.costsAndExpenses
          : costsAndExpenses as List<CostAndExpense>?,
      production:
          freezed == production ? _value.production : production as Production?,
    ) as $Val);
  }
}

/// @nodoc
@JsonSerializable()
class _$FishHusbandryImpl extends _FishHusbandry with DiagnosticableTreeMixin {
  _$FishHusbandryImpl({
    this.id,
    required this.createDate,
    required this.totalProfit,
    required this.farmName,
    required this.numberAnimals,
    required this.value,
    this.uidOwner,
    this.comment,
    this.costsAndExpenses,
    this.production,
  }) : super._();

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
  List<CostAndExpense>? costsAndExpenses;
  @override
  Production? production;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'FishHusbandry(id: $id, createDate: $createDate, totalProfit: $totalProfit, farmName: $farmName, numberAnimals: $numberAnimals, value: $value, uidOwner: $uidOwner, comment: $comment, costsAndExpenses: $costsAndExpenses, production: $production)';
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
      ..add(DiagnosticsProperty('costsAndExpenses', costsAndExpenses))
      ..add(DiagnosticsProperty('production', production));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  @override
  $FishHusbandryCopyWith<FishHusbandry> get copyWith =>
      __$$FishHusbandryImplCopyWithImpl(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FishHusbandryImplToJson(this);
  }
}

abstract class _$$FishHusbandryImplCopyWith<$Res>
    extends $FishHusbandryCopyWith<$Res> {
  factory _$$FishHusbandryImplCopyWith(
          _$FishHusbandryImpl value, $Res Function(_$FishHusbandryImpl) then) =
      __$$FishHusbandryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? id,
    DateTime createDate,
    String totalProfit,
    String farmName,
    String numberAnimals,
    String value,
    String? uidOwner,
    String? comment,
    List<CostAndExpense>? costsAndExpenses,
    Production? production,
  });
}

class __$$FishHusbandryImplCopyWithImpl<$Res>
    extends _$FishHusbandryCopyWithImpl<$Res, _$FishHusbandryImpl>
    implements _$$FishHusbandryImplCopyWith<$Res> {
  __$$FishHusbandryImplCopyWithImpl(
      _$FishHusbandryImpl _value, $Res Function(_$FishHusbandryImpl) _then)
      : super(_value, _then);

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
    return _then(_$FishHusbandryImpl(
      id: freezed == id ? _value.id : id as String?,
      createDate:
          null == createDate ? _value.createDate : createDate as DateTime,
      totalProfit:
          null == totalProfit ? _value.totalProfit : totalProfit as String,
      farmName: null == farmName ? _value.farmName : farmName as String,
      numberAnimals: null == numberAnimals
          ? _value.numberAnimals
          : numberAnimals as String,
      value: null == value ? _value.value : value as String,
      uidOwner: freezed == uidOwner ? _value.uidOwner : uidOwner as String?,
      comment: freezed == comment ? _value.comment : comment as String?,
      costsAndExpenses: freezed == costsAndExpenses
          ? _value.costsAndExpenses
          : costsAndExpenses as List<CostAndExpense>?,
      production:
          freezed == production ? _value.production : production as Production?,
    ));
  }
}

abstract class _FishHusbandry extends FishHusbandry {
  factory _FishHusbandry({
    String? id,
    required DateTime createDate,
    required String totalProfit,
    required String farmName,
    required String numberAnimals,
    required String value,
    String? uidOwner,
    String? comment,
    List<CostAndExpense>? costsAndExpenses,
    Production? production,
  }) = _$FishHusbandryImpl;
  _FishHusbandry._() : super._();

  factory _FishHusbandry.fromJson(Map<String, dynamic> json) =
      _$FishHusbandryImpl.fromJson;
}
