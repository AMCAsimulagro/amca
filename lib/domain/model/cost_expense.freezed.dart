// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cost_expense.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CostAndExpense _$CostAndExpenseFromJson(Map<String, dynamic> json) {
  return _CostAndExpense.fromJson(json);
}

/// @nodoc
mixin _$CostAndExpense {
  String? get uidOwner => throw _privateConstructorUsedError;
  set uidOwner(String? value) =>
      throw _privateConstructorUsedError; // Owner's UID
  String? get partName => throw _privateConstructorUsedError; // Owner's UID
  set partName(String? value) =>
      throw _privateConstructorUsedError; // Name of the part
  String get transitoryFarmingId =>
      throw _privateConstructorUsedError; // Name of the part
  set transitoryFarmingId(String value) =>
      throw _privateConstructorUsedError; // ID of the transitory farming
  DateTime get createDate =>
      throw _privateConstructorUsedError; // ID of the transitory farming
  set createDate(DateTime value) =>
      throw _privateConstructorUsedError; // ID of the transitory farming
  String get productOrService =>
      throw _privateConstructorUsedError; // ID of the transitory farming
  set productOrService(String value) =>
      throw _privateConstructorUsedError; // Product or service name
  Description get description =>
      throw _privateConstructorUsedError; // Product or service name
  set description(Description value) =>
      throw _privateConstructorUsedError; // Description object containing cost or expense details
  String get quantity =>
      throw _privateConstructorUsedError; // Description object containing cost or expense details
  set quantity(String value) =>
      throw _privateConstructorUsedError; // Quantity of the product or service
  String get price =>
      throw _privateConstructorUsedError; // Quantity of the product or service
  set price(String value) =>
      throw _privateConstructorUsedError; // Price of the product or service
  String get comment =>
      throw _privateConstructorUsedError; // Price of the product or service
  set comment(String value) =>
      throw _privateConstructorUsedError; // Additional comments
  String? get id => throw _privateConstructorUsedError; // Additional comments
  set id(String? value) => throw _privateConstructorUsedError;

  /// Serializes this CostAndExpense to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CostAndExpense
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CostAndExpenseCopyWith<CostAndExpense> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CostAndExpenseCopyWith<$Res> {
  factory $CostAndExpenseCopyWith(
          CostAndExpense value, $Res Function(CostAndExpense) then) =
      _$CostAndExpenseCopyWithImpl<$Res, CostAndExpense>;
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
class _$CostAndExpenseCopyWithImpl<$Res, $Val extends CostAndExpense>
    implements $CostAndExpenseCopyWith<$Res> {
  _$CostAndExpenseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
      productOrService: null == productOrService
          ? _value.productOrService
          : productOrService // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as Description,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as String,
      comment: null == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of CostAndExpense
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DescriptionCopyWith<$Res> get description {
    return $DescriptionCopyWith<$Res>(_value.description, (value) {
      return _then(_value.copyWith(description: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CostAndExpenseImplCopyWith<$Res>
    implements $CostAndExpenseCopyWith<$Res> {
  factory _$$CostAndExpenseImplCopyWith(_$CostAndExpenseImpl value,
          $Res Function(_$CostAndExpenseImpl) then) =
      __$$CostAndExpenseImplCopyWithImpl<$Res>;
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
class __$$CostAndExpenseImplCopyWithImpl<$Res>
    extends _$CostAndExpenseCopyWithImpl<$Res, _$CostAndExpenseImpl>
    implements _$$CostAndExpenseImplCopyWith<$Res> {
  __$$CostAndExpenseImplCopyWithImpl(
      _$CostAndExpenseImpl _value, $Res Function(_$CostAndExpenseImpl) _then)
      : super(_value, _then);

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
    return _then(_$CostAndExpenseImpl(
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
      productOrService: null == productOrService
          ? _value.productOrService
          : productOrService // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as Description,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as String,
      comment: null == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CostAndExpenseImpl implements _CostAndExpense {
  _$CostAndExpenseImpl(
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

  factory _$CostAndExpenseImpl.fromJson(Map<String, dynamic> json) =>
      _$$CostAndExpenseImplFromJson(json);

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

  @override
  String toString() {
    return 'CostAndExpense(uidOwner: $uidOwner, partName: $partName, transitoryFarmingId: $transitoryFarmingId, createDate: $createDate, productOrService: $productOrService, description: $description, quantity: $quantity, price: $price, comment: $comment, id: $id)';
  }

  /// Create a copy of CostAndExpense
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CostAndExpenseImplCopyWith<_$CostAndExpenseImpl> get copyWith =>
      __$$CostAndExpenseImplCopyWithImpl<_$CostAndExpenseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CostAndExpenseImplToJson(
      this,
    );
  }
}

abstract class _CostAndExpense implements CostAndExpense {
  factory _CostAndExpense(
      {String? uidOwner,
      String? partName,
      required String transitoryFarmingId,
      required DateTime createDate,
      required String productOrService,
      required Description description,
      required String quantity,
      required String price,
      required String comment,
      String? id}) = _$CostAndExpenseImpl;

  factory _CostAndExpense.fromJson(Map<String, dynamic> json) =
      _$CostAndExpenseImpl.fromJson;

  @override
  String? get uidOwner;
  set uidOwner(String? value); // Owner's UID
  @override
  String? get partName; // Owner's UID
  set partName(String? value); // Name of the part
  @override
  String get transitoryFarmingId; // Name of the part
  set transitoryFarmingId(String value); // ID of the transitory farming
  @override
  DateTime get createDate; // ID of the transitory farming
  set createDate(DateTime value); // ID of the transitory farming
  @override
  String get productOrService; // ID of the transitory farming
  set productOrService(String value); // Product or service name
  @override
  Description get description; // Product or service name
  set description(
      Description
          value); // Description object containing cost or expense details
  @override
  String get quantity; // Description object containing cost or expense details
  set quantity(String value); // Quantity of the product or service
  @override
  String get price; // Quantity of the product or service
  set price(String value); // Price of the product or service
  @override
  String get comment; // Price of the product or service
  set comment(String value); // Additional comments
  @override
  String? get id; // Additional comments
  set id(String? value);

  /// Create a copy of CostAndExpense
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CostAndExpenseImplCopyWith<_$CostAndExpenseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
