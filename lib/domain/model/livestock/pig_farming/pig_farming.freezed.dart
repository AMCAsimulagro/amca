// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pig_farming.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PigFarming implements DiagnosticableTreeMixin {
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
  String? get uidOwner;
  set uidOwner(String? value);
  String? get comment;
  set comment(String? value);
  List<CostAndExpense>? get costsAndExpenses;
  set costsAndExpenses(List<CostAndExpense>? value);
  Production? get production;
  set production(Production? value);

  /// Create a copy of PigFarming
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PigFarmingCopyWith<PigFarming> get copyWith =>
      _$PigFarmingCopyWithImpl<PigFarming>(this as PigFarming, _$identity);

  /// Serializes this PigFarming to a JSON map.
  Map<String, dynamic> toJson();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'PigFarming'))
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

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PigFarming(id: $id, createDate: $createDate, totalProfit: $totalProfit, farmName: $farmName, numberAnimals: $numberAnimals, value: $value, uidOwner: $uidOwner, comment: $comment, costsAndExpenses: $costsAndExpenses, production: $production)';
  }
}

/// @nodoc
abstract mixin class $PigFarmingCopyWith<$Res> {
  factory $PigFarmingCopyWith(
          PigFarming value, $Res Function(PigFarming) _then) =
      _$PigFarmingCopyWithImpl;
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
class _$PigFarmingCopyWithImpl<$Res> implements $PigFarmingCopyWith<$Res> {
  _$PigFarmingCopyWithImpl(this._self, this._then);

  final PigFarming _self;
  final $Res Function(PigFarming) _then;

  /// Create a copy of PigFarming
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
              as Production?,
    ));
  }

  /// Create a copy of PigFarming
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProductionCopyWith<$Res>? get production {
    if (_self.production == null) {
      return null;
    }

    return $ProductionCopyWith<$Res>(_self.production!, (value) {
      return _then(_self.copyWith(production: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _PigFarming extends PigFarming with DiagnosticableTreeMixin {
  _PigFarming(
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
  factory _PigFarming.fromJson(Map<String, dynamic> json) =>
      _$PigFarmingFromJson(json);

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

  /// Create a copy of PigFarming
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PigFarmingCopyWith<_PigFarming> get copyWith =>
      __$PigFarmingCopyWithImpl<_PigFarming>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PigFarmingToJson(
      this,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'PigFarming'))
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

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PigFarming(id: $id, createDate: $createDate, totalProfit: $totalProfit, farmName: $farmName, numberAnimals: $numberAnimals, value: $value, uidOwner: $uidOwner, comment: $comment, costsAndExpenses: $costsAndExpenses, production: $production)';
  }
}

/// @nodoc
abstract mixin class _$PigFarmingCopyWith<$Res>
    implements $PigFarmingCopyWith<$Res> {
  factory _$PigFarmingCopyWith(
          _PigFarming value, $Res Function(_PigFarming) _then) =
      __$PigFarmingCopyWithImpl;
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
class __$PigFarmingCopyWithImpl<$Res> implements _$PigFarmingCopyWith<$Res> {
  __$PigFarmingCopyWithImpl(this._self, this._then);

  final _PigFarming _self;
  final $Res Function(_PigFarming) _then;

  /// Create a copy of PigFarming
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
    Object? uidOwner = freezed,
    Object? comment = freezed,
    Object? costsAndExpenses = freezed,
    Object? production = freezed,
  }) {
    return _then(_PigFarming(
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
              as Production?,
    ));
  }

  /// Create a copy of PigFarming
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProductionCopyWith<$Res>? get production {
    if (_self.production == null) {
      return null;
    }

    return $ProductionCopyWith<$Res>(_self.production!, (value) {
      return _then(_self.copyWith(production: value));
    });
  }
}

// dart format on
