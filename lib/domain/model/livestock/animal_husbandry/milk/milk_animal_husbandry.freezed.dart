// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'milk_animal_husbandry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
MilkAnimalHusbandry _$MilkAnimalHusbandryFromJson(Map<String, dynamic> json) {
  return _AnimalHusbandry.fromJson(json);
}

/// @nodoc
mixin _$MilkAnimalHusbandry implements DiagnosticableTreeMixin {
  String? get id;
  set id(String? value);
  DateTime get createDate;
  set createDate(DateTime value);
  String get totalProfit;
  set totalProfit(String value);
  String get farmName;
  set farmName(String value);
  String get numberAnimals;
  set numberAnimals(String value);
  String get value;
  set value(String value);
  String? get area;
  set area(String? value);
  String? get uidOwner;
  set uidOwner(String? value);
  String? get comment;
  set comment(String? value);
  List<CostAndExpense>? get costsAndExpenses;
  set costsAndExpenses(List<CostAndExpense>? value); //Production? production,
  List<Production>? get production; //Production? production,
  set production(List<Production>? value);

  /// Create a copy of MilkAnimalHusbandry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MilkAnimalHusbandryCopyWith<MilkAnimalHusbandry> get copyWith =>
      _$MilkAnimalHusbandryCopyWithImpl<MilkAnimalHusbandry>(
          this as MilkAnimalHusbandry, _$identity);

  /// Serializes this MilkAnimalHusbandry to a JSON map.
  Map<String, dynamic> toJson();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'MilkAnimalHusbandry'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('createDate', createDate))
      ..add(DiagnosticsProperty('totalProfit', totalProfit))
      ..add(DiagnosticsProperty('farmName', farmName))
      ..add(DiagnosticsProperty('numberAnimals', numberAnimals))
      ..add(DiagnosticsProperty('value', value))
      ..add(DiagnosticsProperty('area', area))
      ..add(DiagnosticsProperty('uidOwner', uidOwner))
      ..add(DiagnosticsProperty('comment', comment))
      ..add(DiagnosticsProperty('costsAndExpenses', costsAndExpenses))
      ..add(DiagnosticsProperty('production', production));
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MilkAnimalHusbandry(id: $id, createDate: $createDate, totalProfit: $totalProfit, farmName: $farmName, numberAnimals: $numberAnimals, value: $value, area: $area, uidOwner: $uidOwner, comment: $comment, costsAndExpenses: $costsAndExpenses, production: $production)';
  }
}

/// @nodoc
abstract mixin class $MilkAnimalHusbandryCopyWith<$Res> {
  factory $MilkAnimalHusbandryCopyWith(
          MilkAnimalHusbandry value, $Res Function(MilkAnimalHusbandry) _then) =
      _$MilkAnimalHusbandryCopyWithImpl;
  @useResult
  $Res call(
      {String? id,
      DateTime createDate,
      String totalProfit,
      String farmName,
      String numberAnimals,
      String value,
      String? area,
      String? uidOwner,
      String? comment,
      List<CostAndExpense>? costsAndExpenses,
      List<Production>? production});
}

/// @nodoc
class _$MilkAnimalHusbandryCopyWithImpl<$Res>
    implements $MilkAnimalHusbandryCopyWith<$Res> {
  _$MilkAnimalHusbandryCopyWithImpl(this._self, this._then);

  final MilkAnimalHusbandry _self;
  final $Res Function(MilkAnimalHusbandry) _then;

  /// Create a copy of MilkAnimalHusbandry
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
    Object? area = freezed,
    Object? uidOwner = freezed,
    Object? comment = freezed,
    Object? costsAndExpenses = freezed,
    Object? production = freezed,
  }) {
    return _then(_self.copyWith(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      createDate: null == createDate
          ? _self.createDate
          : createDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      totalProfit: null == totalProfit
          ? _self.totalProfit
          : totalProfit // ignore: cast_nullable_to_non_nullable
              as String,
      farmName: null == farmName
          ? _self.farmName
          : farmName // ignore: cast_nullable_to_non_nullable
              as String,
      numberAnimals: null == numberAnimals
          ? _self.numberAnimals
          : numberAnimals // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
      area: freezed == area
          ? _self.area
          : area // ignore: cast_nullable_to_non_nullable
              as String?,
      uidOwner: freezed == uidOwner
          ? _self.uidOwner
          : uidOwner // ignore: cast_nullable_to_non_nullable
              as String?,
      comment: freezed == comment
          ? _self.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
      costsAndExpenses: freezed == costsAndExpenses
          ? _self.costsAndExpenses
          : costsAndExpenses // ignore: cast_nullable_to_non_nullable
              as List<CostAndExpense>?,
      production: freezed == production
          ? _self.production
          : production // ignore: cast_nullable_to_non_nullable
              as List<Production>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _AnimalHusbandry extends MilkAnimalHusbandry
    with DiagnosticableTreeMixin {
  _AnimalHusbandry(
      {this.id,
      required this.createDate,
      required this.totalProfit,
      required this.farmName,
      required this.numberAnimals,
      required this.value,
      this.area,
      this.uidOwner,
      this.comment,
      this.costsAndExpenses,
      this.production})
      : super._();
  factory _AnimalHusbandry.fromJson(Map<String, dynamic> json) =>
      _$AnimalHusbandryFromJson(json);

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
  String? area;
  @override
  String? uidOwner;
  @override
  String? comment;
  @override
  List<CostAndExpense>? costsAndExpenses;
//Production? production,
  @override
  List<Production>? production;

  /// Create a copy of MilkAnimalHusbandry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AnimalHusbandryCopyWith<_AnimalHusbandry> get copyWith =>
      __$AnimalHusbandryCopyWithImpl<_AnimalHusbandry>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AnimalHusbandryToJson(
      this,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'MilkAnimalHusbandry'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('createDate', createDate))
      ..add(DiagnosticsProperty('totalProfit', totalProfit))
      ..add(DiagnosticsProperty('farmName', farmName))
      ..add(DiagnosticsProperty('numberAnimals', numberAnimals))
      ..add(DiagnosticsProperty('value', value))
      ..add(DiagnosticsProperty('area', area))
      ..add(DiagnosticsProperty('uidOwner', uidOwner))
      ..add(DiagnosticsProperty('comment', comment))
      ..add(DiagnosticsProperty('costsAndExpenses', costsAndExpenses))
      ..add(DiagnosticsProperty('production', production));
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MilkAnimalHusbandry(id: $id, createDate: $createDate, totalProfit: $totalProfit, farmName: $farmName, numberAnimals: $numberAnimals, value: $value, area: $area, uidOwner: $uidOwner, comment: $comment, costsAndExpenses: $costsAndExpenses, production: $production)';
  }
}

/// @nodoc
abstract mixin class _$AnimalHusbandryCopyWith<$Res>
    implements $MilkAnimalHusbandryCopyWith<$Res> {
  factory _$AnimalHusbandryCopyWith(
          _AnimalHusbandry value, $Res Function(_AnimalHusbandry) _then) =
      __$AnimalHusbandryCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String? id,
      DateTime createDate,
      String totalProfit,
      String farmName,
      String numberAnimals,
      String value,
      String? area,
      String? uidOwner,
      String? comment,
      List<CostAndExpense>? costsAndExpenses,
      List<Production>? production});
}

/// @nodoc
class __$AnimalHusbandryCopyWithImpl<$Res>
    implements _$AnimalHusbandryCopyWith<$Res> {
  __$AnimalHusbandryCopyWithImpl(this._self, this._then);

  final _AnimalHusbandry _self;
  final $Res Function(_AnimalHusbandry) _then;

  /// Create a copy of MilkAnimalHusbandry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = freezed,
    Object? createDate = null,
    Object? totalProfit = null,
    Object? farmName = null,
    Object? numberAnimals = null,
    Object? value = null,
    Object? area = freezed,
    Object? uidOwner = freezed,
    Object? comment = freezed,
    Object? costsAndExpenses = freezed,
    Object? production = freezed,
  }) {
    return _then(_AnimalHusbandry(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      createDate: null == createDate
          ? _self.createDate
          : createDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      totalProfit: null == totalProfit
          ? _self.totalProfit
          : totalProfit // ignore: cast_nullable_to_non_nullable
              as String,
      farmName: null == farmName
          ? _self.farmName
          : farmName // ignore: cast_nullable_to_non_nullable
              as String,
      numberAnimals: null == numberAnimals
          ? _self.numberAnimals
          : numberAnimals // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
      area: freezed == area
          ? _self.area
          : area // ignore: cast_nullable_to_non_nullable
              as String?,
      uidOwner: freezed == uidOwner
          ? _self.uidOwner
          : uidOwner // ignore: cast_nullable_to_non_nullable
              as String?,
      comment: freezed == comment
          ? _self.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
      costsAndExpenses: freezed == costsAndExpenses
          ? _self.costsAndExpenses
          : costsAndExpenses // ignore: cast_nullable_to_non_nullable
              as List<CostAndExpense>?,
      production: freezed == production
          ? _self.production
          : production // ignore: cast_nullable_to_non_nullable
              as List<Production>?,
    ));
  }
}

// dart format on
