// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'production_permanent.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Production {
  String? get uidOwner;
  set uidOwner(String? value); // Owner UID of the production.
  String? get partName; // Owner UID of the production.
  set partName(String? value); // Part name of the production.
  String get transitoryFarmingId; // Part name of the production.
  set transitoryFarmingId(
      String value); // Transitory farming ID of the production.
  DateTime get createDate; // Transitory farming ID of the production.
  set createDate(DateTime value); // Creation date of the production.
  String get unitOfMeasurement; // Creation date of the production.
  set unitOfMeasurement(String value); // Unit of measurement of the production.
  String get quantity; // Unit of measurement of the production.
  set quantity(String value); // Quantity of the production.
  String get price; // Quantity of the production.
  set price(String value); // Price of the production.
  String? get totalValue; // Price of the production.
  set totalValue(String? value); // Total value of the production.
  String? get id; // Total value of the production.
  set id(String? value);

  /// Create a copy of Production
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ProductionCopyWith<Production> get copyWith =>
      _$ProductionCopyWithImpl<Production>(this as Production, _$identity);

  /// Serializes this Production to a JSON map.
  Map<String, dynamic> toJson();

  @override
  String toString() {
    return 'Production(uidOwner: $uidOwner, partName: $partName, transitoryFarmingId: $transitoryFarmingId, createDate: $createDate, unitOfMeasurement: $unitOfMeasurement, quantity: $quantity, price: $price, totalValue: $totalValue, id: $id)';
  }
}

/// @nodoc
abstract mixin class $ProductionCopyWith<$Res> {
  factory $ProductionCopyWith(
          Production value, $Res Function(Production) _then) =
      _$ProductionCopyWithImpl;
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
class _$ProductionCopyWithImpl<$Res> implements $ProductionCopyWith<$Res> {
  _$ProductionCopyWithImpl(this._self, this._then);

  final Production _self;
  final $Res Function(Production) _then;

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
    Object? totalValue = freezed,
    Object? id = freezed,
  }) {
    return _then(_self.copyWith(
      uidOwner: freezed == uidOwner
          ? _self.uidOwner
          : uidOwner // ignore: cast_nullable_to_non_nullable
              as String?,
      partName: freezed == partName
          ? _self.partName
          : partName // ignore: cast_nullable_to_non_nullable
              as String?,
      transitoryFarmingId: null == transitoryFarmingId
          ? _self.transitoryFarmingId
          : transitoryFarmingId // ignore: cast_nullable_to_non_nullable
              as String,
      createDate: null == createDate
          ? _self.createDate
          : createDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      unitOfMeasurement: null == unitOfMeasurement
          ? _self.unitOfMeasurement
          : unitOfMeasurement // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _self.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _self.price
          : price // ignore: cast_nullable_to_non_nullable
              as String,
      totalValue: freezed == totalValue
          ? _self.totalValue
          : totalValue // ignore: cast_nullable_to_non_nullable
              as String?,
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _Production implements Production {
  _Production(
      {this.uidOwner,
      this.partName,
      required this.transitoryFarmingId,
      required this.createDate,
      required this.unitOfMeasurement,
      required this.quantity,
      required this.price,
      this.totalValue,
      this.id});
  factory _Production.fromJson(Map<String, dynamic> json) =>
      _$ProductionFromJson(json);

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
  String? totalValue;
// Total value of the production.
  @override
  String? id;

  /// Create a copy of Production
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ProductionCopyWith<_Production> get copyWith =>
      __$ProductionCopyWithImpl<_Production>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ProductionToJson(
      this,
    );
  }

  @override
  String toString() {
    return 'Production(uidOwner: $uidOwner, partName: $partName, transitoryFarmingId: $transitoryFarmingId, createDate: $createDate, unitOfMeasurement: $unitOfMeasurement, quantity: $quantity, price: $price, totalValue: $totalValue, id: $id)';
  }
}

/// @nodoc
abstract mixin class _$ProductionCopyWith<$Res>
    implements $ProductionCopyWith<$Res> {
  factory _$ProductionCopyWith(
          _Production value, $Res Function(_Production) _then) =
      __$ProductionCopyWithImpl;
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
class __$ProductionCopyWithImpl<$Res> implements _$ProductionCopyWith<$Res> {
  __$ProductionCopyWithImpl(this._self, this._then);

  final _Production _self;
  final $Res Function(_Production) _then;

  /// Create a copy of Production
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
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
    return _then(_Production(
      uidOwner: freezed == uidOwner
          ? _self.uidOwner
          : uidOwner // ignore: cast_nullable_to_non_nullable
              as String?,
      partName: freezed == partName
          ? _self.partName
          : partName // ignore: cast_nullable_to_non_nullable
              as String?,
      transitoryFarmingId: null == transitoryFarmingId
          ? _self.transitoryFarmingId
          : transitoryFarmingId // ignore: cast_nullable_to_non_nullable
              as String,
      createDate: null == createDate
          ? _self.createDate
          : createDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      unitOfMeasurement: null == unitOfMeasurement
          ? _self.unitOfMeasurement
          : unitOfMeasurement // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _self.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _self.price
          : price // ignore: cast_nullable_to_non_nullable
              as String,
      totalValue: freezed == totalValue
          ? _self.totalValue
          : totalValue // ignore: cast_nullable_to_non_nullable
              as String?,
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
