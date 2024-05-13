/// {@category Domain}
// This file contains the definition of the PermanentFarming class, which represents an object related to permanent farming.
// It includes serialization and deserialization of PermanentFarming instances to/from JSON, as well as methods for calculating the total cost and expenses.
// Additionally, it is automatically generated using Freezed and JsonSerializable for immutability and serialization/deserialization of objects.
// copyWith and toString methods are provided for ease of instance management and debugging.

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'permanent_farming.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PermanentFarming _$PermanentFarmingFromJson(Map<String, dynamic> json) {
  return _PermanentFarming.fromJson(json);
}

/// @nodoc
mixin _$PermanentFarming {
  String? get id => throw _privateConstructorUsedError;
  set id(String? value) => throw _privateConstructorUsedError;
  DateTime get createDate => throw _privateConstructorUsedError;
  set createDate(DateTime value) => throw _privateConstructorUsedError;
  String get partName => throw _privateConstructorUsedError;
  set partName(String value) => throw _privateConstructorUsedError;

  String get cropType => throw _privateConstructorUsedError;
  set cropType(String value) => throw _privateConstructorUsedError;

  String get totalProfit => throw _privateConstructorUsedError;
  set totalProfit(String value) => throw _privateConstructorUsedError;

  String get crop => throw _privateConstructorUsedError;
  set crop(String value) => throw _privateConstructorUsedError;
  String get sownArea => throw _privateConstructorUsedError;
  set sownArea(String value) => throw _privateConstructorUsedError;
  String get sownType => throw _privateConstructorUsedError;
  set sownType(String value) => throw _privateConstructorUsedError;
  String get format => throw _privateConstructorUsedError;
  set format(String value) => throw _privateConstructorUsedError;
  String get amountSown => throw _privateConstructorUsedError;
  set amountSown(String value) => throw _privateConstructorUsedError;
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

  List<Production>? get production => throw _privateConstructorUsedError;
  set production(List<Production>? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PermanentFarmingCopyWith<PermanentFarming> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PermanentFarmingCopyWith<$Res> {
  factory $PermanentFarmingCopyWith(
          PermanentFarming value, $Res Function(PermanentFarming) then) =
      _$PermanentFarmingCopyWithImpl<$Res, PermanentFarming>;
  @useResult
  $Res call({
    String? id,
    DateTime createDate,
    String partName,
    String cropType,
    String totalProfit,
    String crop,
    String sownArea,
    String sownType,
    String format,
    String amountSown,
    String value,
    String? uidOwner,
    String? comment,
    List<CostAndExpense>? costsAndExpenses,
    List<Production>? production,
    //Production? production
  });

  $ProductionCopyWith<$Res>? get production;
}

/// @nodoc
class _$PermanentFarmingCopyWithImpl<$Res, $Val extends PermanentFarming>
    implements $PermanentFarmingCopyWith<$Res> {
  _$PermanentFarmingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? createDate = null,
    Object? partName = null,
    Object? cropType = null,
    Object? crop = null,
    Object? totalProfit = null,
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
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      createDate: null == createDate
          ? _value.createDate
          : createDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      partName: null == partName
          ? _value.partName
          : partName // ignore: cast_nullable_to_non_nullable
              as String,
      cropType: null == cropType
          ? _value.cropType
          : cropType // ignore: cast_nullable_to_non_nullable
              as String,
      crop: null == crop
          ? _value.crop
          : crop // ignore: cast_nullable_to_non_nullable
              as String,
      totalProfit:
          null == totalProfit ? _value.totalProfit : totalProfit as String,
      sownArea: null == sownArea
          ? _value.sownArea
          : sownArea // ignore: cast_nullable_to_non_nullable
              as String,
      sownType: null == sownType
          ? _value.sownType
          : sownType // ignore: cast_nullable_to_non_nullable
              as String,
      format: null == format
          ? _value.format
          : format // ignore: cast_nullable_to_non_nullable
              as String,
      amountSown: null == amountSown
          ? _value.amountSown
          : amountSown // ignore: cast_nullable_to_non_nullable
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
          : production as List<Production>?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ProductionCopyWith<$Res>? get production {
    if (_value.production == null) {
      return null;
    }

    // return $ProductionCopyWith<$Res>(_value.production!, (value) {
    //   return _then(_value.copyWith(production: value) as $Val);
    // });
  }
}

/// @nodoc
abstract class _$$_PermanentFarmingCopyWith<$Res>
    implements $PermanentFarmingCopyWith<$Res> {
  factory _$$_PermanentFarmingCopyWith(
          _$_PermanentFarming value, $Res Function(_$_PermanentFarming) then) =
      __$$_PermanentFarmingCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? id,
    DateTime createDate,
    String partName,
    String cropType,
    String crop,
    String totalProfit,
    String sownArea,
    String sownType,
    String format,
    String amountSown,
    String value,
    String? uidOwner,
    String? comment,
    List<CostAndExpense>? costsAndExpenses,
    List<Production>? production,
    //Production? production
  });

  @override
  $ProductionCopyWith<$Res>? get production;
}

/// @nodoc
class __$$_PermanentFarmingCopyWithImpl<$Res>
    extends _$PermanentFarmingCopyWithImpl<$Res, _$_PermanentFarming>
    implements _$$_PermanentFarmingCopyWith<$Res> {
  __$$_PermanentFarmingCopyWithImpl(
      _$_PermanentFarming _value, $Res Function(_$_PermanentFarming) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? createDate = null,
    Object? partName = null,
    Object? cropType = null,
    Object? crop = null,
    Object? totalProfit = null,
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
    return _then(_$_PermanentFarming(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      createDate: null == createDate
          ? _value.createDate
          : createDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      partName: null == partName
          ? _value.partName
          : partName // ignore: cast_nullable_to_non_nullable
              as String,
      cropType: null == cropType
          ? _value.cropType
          : cropType // ignore: cast_nullable_to_non_nullable
              as String,
      crop: null == crop
          ? _value.crop
          : crop // ignore: cast_nullable_to_non_nullable
              as String,
      totalProfit:
          null == totalProfit ? _value.totalProfit : totalProfit as String,
      sownArea: null == sownArea
          ? _value.sownArea
          : sownArea // ignore: cast_nullable_to_non_nullable
              as String,
      sownType: null == sownType
          ? _value.sownType
          : sownType // ignore: cast_nullable_to_non_nullable
              as String,
      format: null == format
          ? _value.format
          : format // ignore: cast_nullable_to_non_nullable
              as String,
      amountSown: null == amountSown
          ? _value.amountSown
          : amountSown // ignore: cast_nullable_to_non_nullable
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
              as List<Production>?,

      // production: freezed == production
      //     ? _value.production
      //     : production // ignore: cast_nullable_to_non_nullable
      //         as Production?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PermanentFarming extends _PermanentFarming {
  _$_PermanentFarming(
      {this.id,
      required this.createDate,
      required this.partName,
      required this.cropType,
      required this.crop,
      required this.totalProfit,
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

  factory _$_PermanentFarming.fromJson(Map<String, dynamic> json) =>
      _$$_PermanentFarmingFromJson(json);

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
  String totalProfit;
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
  List<Production>? production;
  //Production? production;

  @override
  String toString() {
    return 'PermanentFarming(id: $id, createDate: $createDate, partName: $partName, cropType: $cropType, crop: $crop, sownArea: $sownArea, sownType: $sownType, format: $format, amountSown: $amountSown, value: $value, uidOwner: $uidOwner, comment: $comment, costsAndExpenses: $costsAndExpenses, production: $production)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PermanentFarmingCopyWith<_$_PermanentFarming> get copyWith =>
      __$$_PermanentFarmingCopyWithImpl<_$_PermanentFarming>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PermanentFarmingToJson(
      this,
    );
  }
}

abstract class _PermanentFarming extends PermanentFarming {
  factory _PermanentFarming({
    String? id,
    required DateTime createDate,
    required String partName,
    required String cropType,
    required String crop,
    required String totalProfit,
    required String sownArea,
    required String sownType,
    required String format,
    required String amountSown,
    required String value,
    String? uidOwner,
    String? comment,
    List<CostAndExpense>? costsAndExpenses,
    List<Production>? production,
    /*Production? production*/
  }) = _$_PermanentFarming;
  _PermanentFarming._() : super._();

  factory _PermanentFarming.fromJson(Map<String, dynamic> json) =
      _$_PermanentFarming.fromJson;

  @override
  String? get id;
  set id(String? value);
  @override
  DateTime get createDate;
  set createDate(DateTime value);
  @override
  String get partName;
  set partName(String value);
  @override
  String get cropType;
  set cropType(String value);

  @override
  String get crop;
  set crop(String value);

  @override
  String get totalProfit;
  set totalProfit(String value);
  @override
  String get sownArea;
  set sownArea(String value);
  @override
  String get sownType;
  set sownType(String value);
  @override
  String get format;
  set format(String value);
  @override
  String get amountSown;
  set amountSown(String value);
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
  //Production? get production;
  //set production(Production? value);
  List<Production>? get production;
  set production(List<Production>? value);

  @override
  @JsonKey(ignore: true)
  _$$_PermanentFarmingCopyWith<_$_PermanentFarming> get copyWith =>
      throw _privateConstructorUsedError;
}
