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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Production _$ProductionFromJson(Map<String, dynamic> json) {
  return _Production.fromJson(json);
}

/// @nodoc
mixin _$Production {
  String? get uidOwner => throw _privateConstructorUsedError;
  set uidOwner(String? value) =>
      throw _privateConstructorUsedError; // Owner UID of the production.
  String? get partName =>
      throw _privateConstructorUsedError; // Owner UID of the production.
  set partName(String? value) =>
      throw _privateConstructorUsedError; // Part name of the production.
  String get transitoryFarmingId =>
      throw _privateConstructorUsedError; // Part name of the production.
  set transitoryFarmingId(String value) =>
      throw _privateConstructorUsedError; // Transitory farming ID of the production.
  DateTime get createDate =>
      throw _privateConstructorUsedError; // Transitory farming ID of the production.
  set createDate(DateTime value) =>
      throw _privateConstructorUsedError; // Creation date of the production.
  String get unitOfMeasurement =>
      throw _privateConstructorUsedError; // Creation date of the production.
  set unitOfMeasurement(String value) =>
      throw _privateConstructorUsedError; // Unit of measurement of the production.
  String get quantity =>
      throw _privateConstructorUsedError; // Unit of measurement of the production.
  set quantity(String value) =>
      throw _privateConstructorUsedError; // Quantity of the production.
  String get price =>
      throw _privateConstructorUsedError; // Quantity of the production.
  set price(String value) =>
      throw _privateConstructorUsedError; // Price of the production.
  String? get average =>
      throw _privateConstructorUsedError; // Price of the production.
  set average(String? value) => throw _privateConstructorUsedError;
  String? get totalValue => throw _privateConstructorUsedError;
  set totalValue(String? value) =>
      throw _privateConstructorUsedError; // Total value of the production.
  String? get id =>
      throw _privateConstructorUsedError; // Total value of the production.
  set id(String? value) => throw _privateConstructorUsedError;

  /// Serializes this Production to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Production
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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
      String? average,
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

  /// Create a copy of Production
  /// with the given fields replaced by the non-null parameter values.
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
    Object? average = freezed,
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
      average: freezed == average
          ? _value.average
          : average // ignore: cast_nullable_to_non_nullable
              as String?,
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
abstract class _$$ProductionImplCopyWith<$Res>
    implements $ProductionCopyWith<$Res> {
  factory _$$ProductionImplCopyWith(
          _$ProductionImpl value, $Res Function(_$ProductionImpl) then) =
      __$$ProductionImplCopyWithImpl<$Res>;
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
      String? average,
      String? totalValue,
      String? id});
}

/// @nodoc
class __$$ProductionImplCopyWithImpl<$Res>
    extends _$ProductionCopyWithImpl<$Res, _$ProductionImpl>
    implements _$$ProductionImplCopyWith<$Res> {
  __$$ProductionImplCopyWithImpl(
      _$ProductionImpl _value, $Res Function(_$ProductionImpl) _then)
      : super(_value, _then);

  /// Create a copy of Production
  /// with the given fields replaced by the non-null parameter values.
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
    Object? average = freezed,
    Object? totalValue = freezed,
    Object? id = freezed,
  }) {
    return _then(_$ProductionImpl(
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
      average: freezed == average
          ? _value.average
          : average // ignore: cast_nullable_to_non_nullable
              as String?,
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
class _$ProductionImpl implements _Production {
  _$ProductionImpl(
      {this.uidOwner,
      this.partName,
      required this.transitoryFarmingId,
      required this.createDate,
      required this.unitOfMeasurement,
      required this.quantity,
      required this.price,
      this.average,
      this.totalValue,
      this.id});

  factory _$ProductionImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductionImplFromJson(json);

  @override
  String? uidOwner;
// Owner UID of the production.
  @override
  String? partName;
// Part name of the production.
  @override
  String transitoryFarmingId;
// Transitory farming ID of the production.
  @override
  DateTime createDate;
// Creation date of the production.
  @override
  String unitOfMeasurement;
// Unit of measurement of the production.
  @override
  String quantity;
// Quantity of the production.
  @override
  String price;
// Price of the production.
  @override
  String? average;
  @override
  String? totalValue;
// Total value of the production.
  @override
  String? id;

  @override
  String toString() {
    return 'Production(uidOwner: $uidOwner, partName: $partName, transitoryFarmingId: $transitoryFarmingId, createDate: $createDate, unitOfMeasurement: $unitOfMeasurement, quantity: $quantity, price: $price, average: $average, totalValue: $totalValue, id: $id)';
  }

  /// Create a copy of Production
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductionImplCopyWith<_$ProductionImpl> get copyWith =>
      __$$ProductionImplCopyWithImpl<_$ProductionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductionImplToJson(
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
      String? average,
      String? totalValue,
      String? id}) = _$ProductionImpl;

  factory _Production.fromJson(Map<String, dynamic> json) =
      _$ProductionImpl.fromJson;

  @override
  String? get uidOwner;
  set uidOwner(String? value); // Owner UID of the production.
  @override
  String? get partName; // Owner UID of the production.
  set partName(String? value); // Part name of the production.
  @override
  String get transitoryFarmingId; // Part name of the production.
  set transitoryFarmingId(
      String value); // Transitory farming ID of the production.
  @override
  DateTime get createDate; // Transitory farming ID of the production.
  set createDate(DateTime value); // Creation date of the production.
  @override
  String get unitOfMeasurement; // Creation date of the production.
  set unitOfMeasurement(String value); // Unit of measurement of the production.
  @override
  String get quantity; // Unit of measurement of the production.
  set quantity(String value); // Quantity of the production.
  @override
  String get price; // Quantity of the production.
  set price(String value); // Price of the production.
  @override
  String? get average; // Price of the production.
  set average(String? value);
  @override
  String? get totalValue;
  set totalValue(String? value); // Total value of the production.
  @override
  String? get id; // Total value of the production.
  set id(String? value);

  /// Create a copy of Production
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProductionImplCopyWith<_$ProductionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
