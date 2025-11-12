// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transitory_farming.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TransitoryFarming {
  String? get id;
  set id(String? value);
  DateTime get createDate;
  set createDate(DateTime value);
  String get partName;
  set partName(String value);
  String get cropType;
  set cropType(String value);
  String get crop;
  set crop(String value);
  String get sownArea;
  set sownArea(String value);
  String get sownType;
  set sownType(String value);
  String get format;
  set format(String value);
  String get amountSown;
  set amountSown(String value);
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

  /// Create a copy of TransitoryFarming
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TransitoryFarmingCopyWith<TransitoryFarming> get copyWith =>
      _$TransitoryFarmingCopyWithImpl<TransitoryFarming>(
          this as TransitoryFarming, _$identity);

  /// Serializes this TransitoryFarming to a JSON map.
  Map<String, dynamic> toJson();

  @override
  String toString() {
    return 'TransitoryFarming(id: $id, createDate: $createDate, partName: $partName, cropType: $cropType, crop: $crop, sownArea: $sownArea, sownType: $sownType, format: $format, amountSown: $amountSown, value: $value, uidOwner: $uidOwner, comment: $comment, costsAndExpenses: $costsAndExpenses, production: $production)';
  }
}

/// @nodoc
abstract mixin class $TransitoryFarmingCopyWith<$Res> {
  factory $TransitoryFarmingCopyWith(
          TransitoryFarming value, $Res Function(TransitoryFarming) _then) =
      _$TransitoryFarmingCopyWithImpl;
  @useResult
  $Res call(
      {String? id,
      DateTime createDate,
      String partName,
      String cropType,
      String crop,
      String sownArea,
      String sownType,
      String format,
      String amountSown,
      String value,
      String? uidOwner,
      String? comment,
      List<CostAndExpense>? costsAndExpenses,
      Production? production});

  $ProductionCopyWith<$Res>? get production;
}

/// @nodoc
class _$TransitoryFarmingCopyWithImpl<$Res>
    implements $TransitoryFarmingCopyWith<$Res> {
  _$TransitoryFarmingCopyWithImpl(this._self, this._then);

  final TransitoryFarming _self;
  final $Res Function(TransitoryFarming) _then;

  /// Create a copy of TransitoryFarming
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? createDate = null,
    Object? partName = null,
    Object? cropType = null,
    Object? crop = null,
    Object? sownArea = null,
    Object? sownType = null,
    Object? format = null,
    Object? amountSown = null,
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
      partName: null == partName
          ? _self.partName
          : partName // ignore: cast_nullable_to_non_nullable
              as String,
      cropType: null == cropType
          ? _self.cropType
          : cropType // ignore: cast_nullable_to_non_nullable
              as String,
      crop: null == crop
          ? _self.crop
          : crop // ignore: cast_nullable_to_non_nullable
              as String,
      sownArea: null == sownArea
          ? _self.sownArea
          : sownArea // ignore: cast_nullable_to_non_nullable
              as String,
      sownType: null == sownType
          ? _self.sownType
          : sownType // ignore: cast_nullable_to_non_nullable
              as String,
      format: null == format
          ? _self.format
          : format // ignore: cast_nullable_to_non_nullable
              as String,
      amountSown: null == amountSown
          ? _self.amountSown
          : amountSown // ignore: cast_nullable_to_non_nullable
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

  /// Create a copy of TransitoryFarming
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
class _TransitoryFarming extends TransitoryFarming {
  _TransitoryFarming(
      {this.id,
      required this.createDate,
      required this.partName,
      required this.cropType,
      required this.crop,
      required this.sownArea,
      required this.sownType,
      required this.format,
      required this.amountSown,
      required this.value,
      this.uidOwner,
      this.comment,
      this.costsAndExpenses,
      this.production})
      : super._();
  factory _TransitoryFarming.fromJson(Map<String, dynamic> json) =>
      _$TransitoryFarmingFromJson(json);

  @override
  String? id;
  @override
  DateTime createDate;
  @override
  String partName;
  @override
  String cropType;
  @override
  String crop;
  @override
  String sownArea;
  @override
  String sownType;
  @override
  String format;
  @override
  String amountSown;
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

  /// Create a copy of TransitoryFarming
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TransitoryFarmingCopyWith<_TransitoryFarming> get copyWith =>
      __$TransitoryFarmingCopyWithImpl<_TransitoryFarming>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TransitoryFarmingToJson(
      this,
    );
  }

  @override
  String toString() {
    return 'TransitoryFarming(id: $id, createDate: $createDate, partName: $partName, cropType: $cropType, crop: $crop, sownArea: $sownArea, sownType: $sownType, format: $format, amountSown: $amountSown, value: $value, uidOwner: $uidOwner, comment: $comment, costsAndExpenses: $costsAndExpenses, production: $production)';
  }
}

/// @nodoc
abstract mixin class _$TransitoryFarmingCopyWith<$Res>
    implements $TransitoryFarmingCopyWith<$Res> {
  factory _$TransitoryFarmingCopyWith(
          _TransitoryFarming value, $Res Function(_TransitoryFarming) _then) =
      __$TransitoryFarmingCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String? id,
      DateTime createDate,
      String partName,
      String cropType,
      String crop,
      String sownArea,
      String sownType,
      String format,
      String amountSown,
      String value,
      String? uidOwner,
      String? comment,
      List<CostAndExpense>? costsAndExpenses,
      Production? production});

  @override
  $ProductionCopyWith<$Res>? get production;
}

/// @nodoc
class __$TransitoryFarmingCopyWithImpl<$Res>
    implements _$TransitoryFarmingCopyWith<$Res> {
  __$TransitoryFarmingCopyWithImpl(this._self, this._then);

  final _TransitoryFarming _self;
  final $Res Function(_TransitoryFarming) _then;

  /// Create a copy of TransitoryFarming
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = freezed,
    Object? createDate = null,
    Object? partName = null,
    Object? cropType = null,
    Object? crop = null,
    Object? sownArea = null,
    Object? sownType = null,
    Object? format = null,
    Object? amountSown = null,
    Object? value = null,
    Object? uidOwner = freezed,
    Object? comment = freezed,
    Object? costsAndExpenses = freezed,
    Object? production = freezed,
  }) {
    return _then(_TransitoryFarming(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      createDate: null == createDate
          ? _self.createDate
          : createDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      partName: null == partName
          ? _self.partName
          : partName // ignore: cast_nullable_to_non_nullable
              as String,
      cropType: null == cropType
          ? _self.cropType
          : cropType // ignore: cast_nullable_to_non_nullable
              as String,
      crop: null == crop
          ? _self.crop
          : crop // ignore: cast_nullable_to_non_nullable
              as String,
      sownArea: null == sownArea
          ? _self.sownArea
          : sownArea // ignore: cast_nullable_to_non_nullable
              as String,
      sownType: null == sownType
          ? _self.sownType
          : sownType // ignore: cast_nullable_to_non_nullable
              as String,
      format: null == format
          ? _self.format
          : format // ignore: cast_nullable_to_non_nullable
              as String,
      amountSown: null == amountSown
          ? _self.amountSown
          : amountSown // ignore: cast_nullable_to_non_nullable
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

  /// Create a copy of TransitoryFarming
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
