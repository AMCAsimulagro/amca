// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cost_expense.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CostAndExpense {
  String? get uidOwner;
  set uidOwner(String? value); // Owner's UID
  String? get partName; // Owner's UID
  set partName(String? value); // Name of the part
  String get transitoryFarmingId; // Name of the part
  set transitoryFarmingId(String value); // ID of the transitory farming
  DateTime get createDate; // ID of the transitory farming
  set createDate(DateTime value); // ID of the transitory farming
  String get productOrService; // ID of the transitory farming
  set productOrService(String value); // Product or service name
  Description get description; // Product or service name
  set description(
      Description
          value); // Description object containing cost or expense details
  String get quantity; // Description object containing cost or expense details
  set quantity(String value); // Quantity of the product or service
  String get price; // Quantity of the product or service
  set price(String value); // Price of the product or service
  String get comment; // Price of the product or service
  set comment(String value); // Additional comments
  String? get id; // Additional comments
  set id(String? value);

  /// Create a copy of CostAndExpense
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CostAndExpenseCopyWith<CostAndExpense> get copyWith =>
      _$CostAndExpenseCopyWithImpl<CostAndExpense>(
          this as CostAndExpense, _$identity);

  /// Serializes this CostAndExpense to a JSON map.
  Map<String, dynamic> toJson();

  @override
  String toString() {
    return 'CostAndExpense(uidOwner: $uidOwner, partName: $partName, transitoryFarmingId: $transitoryFarmingId, createDate: $createDate, productOrService: $productOrService, description: $description, quantity: $quantity, price: $price, comment: $comment, id: $id)';
  }
}

/// @nodoc
abstract mixin class $CostAndExpenseCopyWith<$Res> {
  factory $CostAndExpenseCopyWith(
          CostAndExpense value, $Res Function(CostAndExpense) _then) =
      _$CostAndExpenseCopyWithImpl;
  @useResult
  $Res call(
      {String? uidOwner,
      String? partName,
      String transitoryFarmingId,
      DateTime createDate,
      String productOrService,
      Description description,
      String quantity,
      String price,
      String comment,
      String? id});

  $DescriptionCopyWith<$Res> get description;
}

/// @nodoc
class _$CostAndExpenseCopyWithImpl<$Res>
    implements $CostAndExpenseCopyWith<$Res> {
  _$CostAndExpenseCopyWithImpl(this._self, this._then);

  final CostAndExpense _self;
  final $Res Function(CostAndExpense) _then;

  /// Create a copy of CostAndExpense
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uidOwner = freezed,
    Object? partName = freezed,
    Object? transitoryFarmingId = null,
    Object? createDate = null,
    Object? productOrService = null,
    Object? description = null,
    Object? quantity = null,
    Object? price = null,
    Object? comment = null,
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
      productOrService: null == productOrService
          ? _self.productOrService
          : productOrService // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as Description,
      quantity: null == quantity
          ? _self.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _self.price
          : price // ignore: cast_nullable_to_non_nullable
              as String,
      comment: null == comment
          ? _self.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String,
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  /// Create a copy of CostAndExpense
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DescriptionCopyWith<$Res> get description {
    return $DescriptionCopyWith<$Res>(_self.description, (value) {
      return _then(_self.copyWith(description: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _CostAndExpense implements CostAndExpense {
  _CostAndExpense(
      {this.uidOwner,
      this.partName,
      required this.transitoryFarmingId,
      required this.createDate,
      required this.productOrService,
      required this.description,
      required this.quantity,
      required this.price,
      required this.comment,
      this.id});
  factory _CostAndExpense.fromJson(Map<String, dynamic> json) =>
      _$CostAndExpenseFromJson(json);

  @override
  String? uidOwner;
// Owner's UID
  @override
  String? partName;
// Name of the part
  @override
  String transitoryFarmingId;
// ID of the transitory farming
  @override
  DateTime createDate;
// ID of the transitory farming
  @override
  String productOrService;
// Product or service name
  @override
  Description description;
// Description object containing cost or expense details
  @override
  String quantity;
// Quantity of the product or service
  @override
  String price;
// Price of the product or service
  @override
  String comment;
// Additional comments
  @override
  String? id;

  /// Create a copy of CostAndExpense
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CostAndExpenseCopyWith<_CostAndExpense> get copyWith =>
      __$CostAndExpenseCopyWithImpl<_CostAndExpense>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CostAndExpenseToJson(
      this,
    );
  }

  @override
  String toString() {
    return 'CostAndExpense(uidOwner: $uidOwner, partName: $partName, transitoryFarmingId: $transitoryFarmingId, createDate: $createDate, productOrService: $productOrService, description: $description, quantity: $quantity, price: $price, comment: $comment, id: $id)';
  }
}

/// @nodoc
abstract mixin class _$CostAndExpenseCopyWith<$Res>
    implements $CostAndExpenseCopyWith<$Res> {
  factory _$CostAndExpenseCopyWith(
          _CostAndExpense value, $Res Function(_CostAndExpense) _then) =
      __$CostAndExpenseCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String? uidOwner,
      String? partName,
      String transitoryFarmingId,
      DateTime createDate,
      String productOrService,
      Description description,
      String quantity,
      String price,
      String comment,
      String? id});

  @override
  $DescriptionCopyWith<$Res> get description;
}

/// @nodoc
class __$CostAndExpenseCopyWithImpl<$Res>
    implements _$CostAndExpenseCopyWith<$Res> {
  __$CostAndExpenseCopyWithImpl(this._self, this._then);

  final _CostAndExpense _self;
  final $Res Function(_CostAndExpense) _then;

  /// Create a copy of CostAndExpense
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? uidOwner = freezed,
    Object? partName = freezed,
    Object? transitoryFarmingId = null,
    Object? createDate = null,
    Object? productOrService = null,
    Object? description = null,
    Object? quantity = null,
    Object? price = null,
    Object? comment = null,
    Object? id = freezed,
  }) {
    return _then(_CostAndExpense(
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
      productOrService: null == productOrService
          ? _self.productOrService
          : productOrService // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as Description,
      quantity: null == quantity
          ? _self.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _self.price
          : price // ignore: cast_nullable_to_non_nullable
              as String,
      comment: null == comment
          ? _self.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String,
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  /// Create a copy of CostAndExpense
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DescriptionCopyWith<$Res> get description {
    return $DescriptionCopyWith<$Res>(_self.description, (value) {
      return _then(_self.copyWith(description: value));
    });
  }
}

// dart format on
