// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fish_husbandry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FishHusbandry implements DiagnosticableTreeMixin {
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
  String? get fishType;
  set fishType(String? value);
  String? get pondLength;
  set pondLength(String? value);
  String? get pondWidth;
  set pondWidth(String? value);
  String? get pondDepth;
  set pondDepth(String? value);
  String? get pondVolume;
  set pondVolume(String? value);
  List<CostAndExpense>? get costsAndExpenses;
  set costsAndExpenses(List<CostAndExpense>? value);
  Production? get production;
  set production(Production? value);

  /// Create a copy of FishHusbandry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $FishHusbandryCopyWith<FishHusbandry> get copyWith =>
      _$FishHusbandryCopyWithImpl<FishHusbandry>(
          this as FishHusbandry, _$identity);

  /// Serializes this FishHusbandry to a JSON map.
  Map<String, dynamic> toJson();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
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
      ..add(DiagnosticsProperty('pondLength', pondLength))
      ..add(DiagnosticsProperty('pondWidth', pondWidth))
      ..add(DiagnosticsProperty('pondDepth', pondDepth))
      ..add(DiagnosticsProperty('pondVolume', pondVolume))
      ..add(DiagnosticsProperty('costsAndExpenses', costsAndExpenses))
      ..add(DiagnosticsProperty('production', production));
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'FishHusbandry(id: $id, createDate: $createDate, totalProfit: $totalProfit, farmName: $farmName, numberAnimals: $numberAnimals, value: $value, uidOwner: $uidOwner, comment: $comment, fishType: $fishType, pondLength: $pondLength, pondWidth: $pondWidth, pondDepth: $pondDepth, pondVolume: $pondVolume, costsAndExpenses: $costsAndExpenses, production: $production)';
  }
}

/// @nodoc
abstract mixin class $FishHusbandryCopyWith<$Res> {
  factory $FishHusbandryCopyWith(
          FishHusbandry value, $Res Function(FishHusbandry) _then) =
      _$FishHusbandryCopyWithImpl;
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
      String? pondLength,
      String? pondWidth,
      String? pondDepth,
      String? pondVolume,
      List<CostAndExpense>? costsAndExpenses,
      Production? production});

  $ProductionCopyWith<$Res>? get production;
}

/// @nodoc
class _$FishHusbandryCopyWithImpl<$Res>
    implements $FishHusbandryCopyWith<$Res> {
  _$FishHusbandryCopyWithImpl(this._self, this._then);

  final FishHusbandry _self;
  final $Res Function(FishHusbandry) _then;

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
    Object? pondLength = freezed,
    Object? pondWidth = freezed,
    Object? pondDepth = freezed,
    Object? pondVolume = freezed,
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
      fishType: freezed == fishType
          ? _self.fishType
          : fishType // ignore: cast_nullable_to_non_nullable
              as String?,
      pondLength: freezed == pondLength
          ? _self.pondLength
          : pondLength // ignore: cast_nullable_to_non_nullable
              as String?,
      pondWidth: freezed == pondWidth
          ? _self.pondWidth
          : pondWidth // ignore: cast_nullable_to_non_nullable
              as String?,
      pondDepth: freezed == pondDepth
          ? _self.pondDepth
          : pondDepth // ignore: cast_nullable_to_non_nullable
              as String?,
      pondVolume: freezed == pondVolume
          ? _self.pondVolume
          : pondVolume // ignore: cast_nullable_to_non_nullable
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

  /// Create a copy of FishHusbandry
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
class _FishHusbandry extends FishHusbandry with DiagnosticableTreeMixin {
  _FishHusbandry(
      {this.id,
      required this.createDate,
      required this.totalProfit,
      required this.farmName,
      required this.numberAnimals,
      required this.value,
      this.uidOwner,
      this.comment,
      this.fishType,
      this.pondLength,
      this.pondWidth,
      this.pondDepth,
      this.pondVolume,
      this.costsAndExpenses,
      this.production})
      : super._();
  factory _FishHusbandry.fromJson(Map<String, dynamic> json) =>
      _$FishHusbandryFromJson(json);

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
  String? pondLength;
  @override
  String? pondWidth;
  @override
  String? pondDepth;
  @override
  String? pondVolume;
  @override
  List<CostAndExpense>? costsAndExpenses;
  @override
  Production? production;

  /// Create a copy of FishHusbandry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$FishHusbandryCopyWith<_FishHusbandry> get copyWith =>
      __$FishHusbandryCopyWithImpl<_FishHusbandry>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$FishHusbandryToJson(
      this,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
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
      ..add(DiagnosticsProperty('pondLength', pondLength))
      ..add(DiagnosticsProperty('pondWidth', pondWidth))
      ..add(DiagnosticsProperty('pondDepth', pondDepth))
      ..add(DiagnosticsProperty('pondVolume', pondVolume))
      ..add(DiagnosticsProperty('costsAndExpenses', costsAndExpenses))
      ..add(DiagnosticsProperty('production', production));
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'FishHusbandry(id: $id, createDate: $createDate, totalProfit: $totalProfit, farmName: $farmName, numberAnimals: $numberAnimals, value: $value, uidOwner: $uidOwner, comment: $comment, fishType: $fishType, pondLength: $pondLength, pondWidth: $pondWidth, pondDepth: $pondDepth, pondVolume: $pondVolume, costsAndExpenses: $costsAndExpenses, production: $production)';
  }
}

/// @nodoc
abstract mixin class _$FishHusbandryCopyWith<$Res>
    implements $FishHusbandryCopyWith<$Res> {
  factory _$FishHusbandryCopyWith(
          _FishHusbandry value, $Res Function(_FishHusbandry) _then) =
      __$FishHusbandryCopyWithImpl;
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
      String? pondLength,
      String? pondWidth,
      String? pondDepth,
      String? pondVolume,
      List<CostAndExpense>? costsAndExpenses,
      Production? production});

  @override
  $ProductionCopyWith<$Res>? get production;
}

/// @nodoc
class __$FishHusbandryCopyWithImpl<$Res>
    implements _$FishHusbandryCopyWith<$Res> {
  __$FishHusbandryCopyWithImpl(this._self, this._then);

  final _FishHusbandry _self;
  final $Res Function(_FishHusbandry) _then;

  /// Create a copy of FishHusbandry
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
    Object? fishType = freezed,
    Object? pondLength = freezed,
    Object? pondWidth = freezed,
    Object? pondDepth = freezed,
    Object? pondVolume = freezed,
    Object? costsAndExpenses = freezed,
    Object? production = freezed,
  }) {
    return _then(_FishHusbandry(
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
      fishType: freezed == fishType
          ? _self.fishType
          : fishType // ignore: cast_nullable_to_non_nullable
              as String?,
      pondLength: freezed == pondLength
          ? _self.pondLength
          : pondLength // ignore: cast_nullable_to_non_nullable
              as String?,
      pondWidth: freezed == pondWidth
          ? _self.pondWidth
          : pondWidth // ignore: cast_nullable_to_non_nullable
              as String?,
      pondDepth: freezed == pondDepth
          ? _self.pondDepth
          : pondDepth // ignore: cast_nullable_to_non_nullable
              as String?,
      pondVolume: freezed == pondVolume
          ? _self.pondVolume
          : pondVolume // ignore: cast_nullable_to_non_nullable
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

  /// Create a copy of FishHusbandry
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
