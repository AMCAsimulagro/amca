/// {@category Domain}
/// This file defines a Production class using Freezed and JsonSerializable annotations.
/// The Production class represents a production with various attributes such as uidOwner, partName, transitoryFarmingId, etc.
/// It is designed to be immutable and provides methods for JSON serialization and deserialization.
/// This file includes both the definition of the Production class and the generated code for JSON serialization/deserialization.
/// Freezed annotations are used to generate constructors and equality checks for the class, while JsonSerializable annotations
/// are used to generate toJson() and fromJson() methods for serialization and deserialization.

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'production.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Production _$ProductionFromJson(Map<String, dynamic> json) {
  return _Production.fromJson(json);
}

/// @nodoc
mixin _$Production {
  String? get uidOwner => throw _privateConstructorUsedError;
  set uidOwner(String? value) => throw _privateConstructorUsedError;
  String? get partName => throw _privateConstructorUsedError;
  set partName(String? value) => throw _privateConstructorUsedError;
  String get transitoryFarmingId => throw _privateConstructorUsedError;
  set transitoryFarmingId(String value) => throw _privateConstructorUsedError;
  DateTime get createDate => throw _privateConstructorUsedError;
  set createDate(DateTime value) => throw _privateConstructorUsedError;
  String get unitOfMeasurement => throw _privateConstructorUsedError;
  set unitOfMeasurement(String value) => throw _privateConstructorUsedError;
  String get quantity => throw _privateConstructorUsedError;
  set quantity(String value) => throw _privateConstructorUsedError;
  String get price => throw _privateConstructorUsedError;
  set price(String value) => throw _privateConstructorUsedError;
  String? get totalValue => throw _privateConstructorUsedError;
  set totalValue(String? value) => throw _privateConstructorUsedError;
  String? get id => throw _privateConstructorUsedError;
  set id(String? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProductionCopyWith<Production> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductionCopyWith<$Res> {
  factory $ProductionCopyWith(
          Production value, $Res Function(Production) then) =
      _$ProductionCopyWithImpl<$Res, Production>;
  @useResult
  $Res call(
      {String? uidOwner,
      String? partName,
      String transitoryFarmingId,
      DateTime createDate,
      String unitOfMeasurement,
      String quantity,
      String price,
      String? totalValue,
      String? id});
}

/// @nodoc
class _$ProductionCopyWithImpl<$Res, $Val extends Production>
    implements $ProductionCopyWith<$Res> {
  _$ProductionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uidOwner = freezed,
    Object? partName = freezed,
    Object? transitoryFarmingId = null,
    Object? createDate = null,
    Object? unitOfMeasurement = null,
    Object? quantity = null,
    Object? price = null,
    Object? totalValue = freezed,
    Object? id = freezed,
  }) {
    return _then(_value.copyWith(
      uidOwner: freezed == uidOwner
          ? _value.uidOwner
          : uidOwner // ignore: cast_nullable_to_non_nullable
              as String?,
      partName: freezed == partName
          ? _value.partName
          : partName // ignore: cast_nullable_to_non_nullable
              as String?,
      transitoryFarmingId: null == transitoryFarmingId
          ? _value.transitoryFarmingId
          : transitoryFarmingId // ignore: cast_nullable_to_non_nullable
              as String,
      createDate: null == createDate
          ? _value.createDate
          : createDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      unitOfMeasurement: null == unitOfMeasurement
          ? _value.unitOfMeasurement
          : unitOfMeasurement // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as String,
      totalValue: freezed == totalValue
          ? _value.totalValue
          : totalValue // ignore: cast_nullable_to_non_nullable
              as String?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ProductionCopyWith<$Res>
    implements $ProductionCopyWith<$Res> {
  factory _$$_ProductionCopyWith(
          _$_Production value, $Res Function(_$_Production) then) =
      __$$_ProductionCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? uidOwner,
      String? partName,
      String transitoryFarmingId,
      DateTime createDate,
      String unitOfMeasurement,
      String quantity,
      String price,
      String? totalValue,
      String? id});
}

/// @nodoc
class __$$_ProductionCopyWithImpl<$Res>
    extends _$ProductionCopyWithImpl<$Res, _$_Production>
    implements _$$_ProductionCopyWith<$Res> {
  __$$_ProductionCopyWithImpl(
      _$_Production _value, $Res Function(_$_Production) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uidOwner = freezed,
    Object? partName = freezed,
    Object? transitoryFarmingId = null,
    Object? createDate = null,
    Object? unitOfMeasurement = null,
    Object? quantity = null,
    Object? price = null,
    Object? totalValue = freezed,
    Object? id = freezed,
  }) {
    return _then(_$_Production(
      uidOwner: freezed == uidOwner
          ? _value.uidOwner
          : uidOwner // ignore: cast_nullable_to_non_nullable
              as String?,
      partName: freezed == partName
          ? _value.partName
          : partName // ignore: cast_nullable_to_non_nullable
              as String?,
      transitoryFarmingId: null == transitoryFarmingId
          ? _value.transitoryFarmingId
          : transitoryFarmingId // ignore: cast_nullable_to_non_nullable
              as String,
      createDate: null == createDate
          ? _value.createDate
          : createDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      unitOfMeasurement: null == unitOfMeasurement
          ? _value.unitOfMeasurement
          : unitOfMeasurement // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as String,
      totalValue: freezed == totalValue
          ? _value.totalValue
          : totalValue // ignore: cast_nullable_to_non_nullable
              as String?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Production implements _Production {
  _$_Production(
      {this.uidOwner,
      this.partName,
      required this.transitoryFarmingId,
      required this.createDate,
      required this.unitOfMeasurement,
      required this.quantity,
      required this.price,
      this.totalValue,
      this.id});

  factory _$_Production.fromJson(Map<String, dynamic> json) =>
      _$$_ProductionFromJson(json);

  @override
  String? uidOwner;
  @override
  String? partName;
  @override
  String transitoryFarmingId;
  @override
  DateTime createDate;
  @override
  String unitOfMeasurement;
  @override
  String quantity;
  @override
  String price;
  @override
  String? totalValue;
  @override
  String? id;

  @override
  String toString() {
    return 'Production(uidOwner: $uidOwner, partName: $partName, transitoryFarmingId: $transitoryFarmingId, createDate: $createDate, unitOfMeasurement: $unitOfMeasurement, quantity: $quantity, price: $price, totalValue: $totalValue, id: $id)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ProductionCopyWith<_$_Production> get copyWith =>
      __$$_ProductionCopyWithImpl<_$_Production>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ProductionToJson(
      this,
    );
  }
}

abstract class _Production implements Production {
  factory _Production(
      {String? uidOwner,
      String? partName,
      required String transitoryFarmingId,
      required DateTime createDate,
      required String unitOfMeasurement,
      required String quantity,
      required String price,
      String? totalValue,
      String? id}) = _$_Production;

  factory _Production.fromJson(Map<String, dynamic> json) =
      _$_Production.fromJson;

  @override
  String? get uidOwner;
  set uidOwner(String? value);
  @override
  String? get partName;
  set partName(String? value);
  @override
  String get transitoryFarmingId;
  set transitoryFarmingId(String value);
  @override
  DateTime get createDate;
  set createDate(DateTime value);
  @override
  String get unitOfMeasurement;
  set unitOfMeasurement(String value);
  @override
  String get quantity;
  set quantity(String value);
  @override
  String get price;
  set price(String value);
  @override
  String? get totalValue;
  set totalValue(String? value);
  @override
  String? get id;
  set id(String? value);
  @override
  @JsonKey(ignore: true)
  _$$_ProductionCopyWith<_$_Production> get copyWith =>
      throw _privateConstructorUsedError;
}
