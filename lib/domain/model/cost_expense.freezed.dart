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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CostAndExpense _$CostAndExpenseFromJson(Map<String, dynamic> json) {
  return _CostAndExpense.fromJson(json);
}

/// @nodoc
mixin _$CostAndExpense {
  String get uidOwner => throw _privateConstructorUsedError;
  set uidOwner(String value) => throw _privateConstructorUsedError;
  String? get farmingName => throw _privateConstructorUsedError;
  set farmingName(String? value) => throw _privateConstructorUsedError;
  String? get partName => throw _privateConstructorUsedError;
  set partName(String? value) => throw _privateConstructorUsedError;
  String get transitoryFarmingId => throw _privateConstructorUsedError;
  set transitoryFarmingId(String value) => throw _privateConstructorUsedError;
  DateTime get createDate => throw _privateConstructorUsedError;
  set createDate(DateTime value) => throw _privateConstructorUsedError;
  String get productOrService => throw _privateConstructorUsedError;
  set productOrService(String value) => throw _privateConstructorUsedError;
  Description get description => throw _privateConstructorUsedError;
  set description(Description value) => throw _privateConstructorUsedError;
  String get costOrExpense => throw _privateConstructorUsedError;
  set costOrExpense(String value) => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  set type(String value) => throw _privateConstructorUsedError;
  String get quantity => throw _privateConstructorUsedError;
  set quantity(String value) => throw _privateConstructorUsedError;
  String get price => throw _privateConstructorUsedError;
  set price(String value) => throw _privateConstructorUsedError;
  String get comment => throw _privateConstructorUsedError;
  set comment(String value) => throw _privateConstructorUsedError;
  String? get id => throw _privateConstructorUsedError;
  set id(String? value) => throw _privateConstructorUsedError;
  bool? get isAdmin => throw _privateConstructorUsedError;
  set isAdmin(bool? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
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
      {String uidOwner,
      String? farmingName,
      String? partName,
      String transitoryFarmingId,
      DateTime createDate,
      String productOrService,
      Description description,
      String costOrExpense,
      String type,
      String quantity,
      String price,
      String comment,
      String? id,
      bool? isAdmin});
}

/// @nodoc
class _$CostAndExpenseCopyWithImpl<$Res, $Val extends CostAndExpense>
    implements $CostAndExpenseCopyWith<$Res> {
  _$CostAndExpenseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uidOwner = null,
    Object? farmingName = freezed,
    Object? partName = freezed,
    Object? transitoryFarmingId = null,
    Object? createDate = null,
    Object? productOrService = null,
    Object? description = freezed,
    Object? costOrExpense = null,
    Object? type = null,
    Object? quantity = null,
    Object? price = null,
    Object? comment = null,
    Object? id = freezed,
    Object? isAdmin = freezed,
  }) {
    return _then(_value.copyWith(
      uidOwner: null == uidOwner
          ? _value.uidOwner
          : uidOwner // ignore: cast_nullable_to_non_nullable
              as String,
      farmingName: freezed == farmingName
          ? _value.farmingName
          : farmingName // ignore: cast_nullable_to_non_nullable
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
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as Description,
      costOrExpense: null == costOrExpense
          ? _value.costOrExpense
          : costOrExpense // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
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
      isAdmin: freezed == isAdmin
          ? _value.isAdmin
          : isAdmin // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CostAndExpenseCopyWith<$Res>
    implements $CostAndExpenseCopyWith<$Res> {
  factory _$$_CostAndExpenseCopyWith(
          _$_CostAndExpense value, $Res Function(_$_CostAndExpense) then) =
      __$$_CostAndExpenseCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String uidOwner,
      String? farmingName,
      String? partName,
      String transitoryFarmingId,
      DateTime createDate,
      String productOrService,
      Description description,
      String costOrExpense,
      String type,
      String quantity,
      String price,
      String comment,
      String? id,
      bool? isAdmin});
}

/// @nodoc
class __$$_CostAndExpenseCopyWithImpl<$Res>
    extends _$CostAndExpenseCopyWithImpl<$Res, _$_CostAndExpense>
    implements _$$_CostAndExpenseCopyWith<$Res> {
  __$$_CostAndExpenseCopyWithImpl(
      _$_CostAndExpense _value, $Res Function(_$_CostAndExpense) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uidOwner = null,
    Object? farmingName = freezed,
    Object? partName = freezed,
    Object? transitoryFarmingId = null,
    Object? createDate = null,
    Object? productOrService = null,
    Object? description = freezed,
    Object? costOrExpense = null,
    Object? type = null,
    Object? quantity = null,
    Object? price = null,
    Object? comment = null,
    Object? id = freezed,
    Object? isAdmin = freezed,
  }) {
    return _then(_$_CostAndExpense(
      uidOwner: null == uidOwner
          ? _value.uidOwner
          : uidOwner // ignore: cast_nullable_to_non_nullable
              as String,
      farmingName: freezed == farmingName
          ? _value.farmingName
          : farmingName // ignore: cast_nullable_to_non_nullable
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
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as Description,
      costOrExpense: null == costOrExpense
          ? _value.costOrExpense
          : costOrExpense // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
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
      isAdmin: freezed == isAdmin
          ? _value.isAdmin
          : isAdmin // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CostAndExpense implements _CostAndExpense {
  _$_CostAndExpense(
      {required this.uidOwner,
      this.farmingName,
      this.partName,
      required this.transitoryFarmingId,
      required this.createDate,
      required this.productOrService,
      required this.description,
      required this.costOrExpense,
      required this.type,
      required this.quantity,
      required this.price,
      required this.comment,
      this.id,
      this.isAdmin = false});

  factory _$_CostAndExpense.fromJson(Map<String, dynamic> json) =>
      _$$_CostAndExpenseFromJson(json);

  @override
  String uidOwner;
  @override
  String? farmingName;
  @override
  String? partName;
  @override
  String transitoryFarmingId;
  @override
  DateTime createDate;
  @override
  String productOrService;
  @override
  Description description;
  @override
  String costOrExpense;
  @override
  String type;
  @override
  String quantity;
  @override
  String price;
  @override
  String comment;
  @override
  String? id;
  @override
  @JsonKey()
  bool? isAdmin;

  @override
  String toString() {
    return 'CostAndExpense(uidOwner: $uidOwner, farmingName: $farmingName, partName: $partName, transitoryFarmingId: $transitoryFarmingId, createDate: $createDate, productOrService: $productOrService, description: $description, costOrExpense: $costOrExpense, type: $type, quantity: $quantity, price: $price, comment: $comment, id: $id, isAdmin: $isAdmin)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CostAndExpenseCopyWith<_$_CostAndExpense> get copyWith =>
      __$$_CostAndExpenseCopyWithImpl<_$_CostAndExpense>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CostAndExpenseToJson(
      this,
    );
  }
}

abstract class _CostAndExpense implements CostAndExpense {
  factory _CostAndExpense(
      {required String uidOwner,
      String? farmingName,
      String? partName,
      required String transitoryFarmingId,
      required DateTime createDate,
      required String productOrService,
      required Description description,
      required String costOrExpense,
      required String type,
      required String quantity,
      required String price,
      required String comment,
      String? id,
      bool? isAdmin}) = _$_CostAndExpense;

  factory _CostAndExpense.fromJson(Map<String, dynamic> json) =
      _$_CostAndExpense.fromJson;

  @override
  String get uidOwner;
  set uidOwner(String value);
  @override
  String? get farmingName;
  set farmingName(String? value);
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
  String get productOrService;
  set productOrService(String value);
  @override
  Description get description;
  set description(Description value);
  @override
  String get costOrExpense;
  set costOrExpense(String value);
  @override
  String get type;
  set type(String value);
  @override
  String get quantity;
  set quantity(String value);
  @override
  String get price;
  set price(String value);
  @override
  String get comment;
  set comment(String value);
  @override
  String? get id;
  set id(String? value);
  @override
  bool? get isAdmin;
  set isAdmin(bool? value);
  @override
  @JsonKey(ignore: true)
  _$$_CostAndExpenseCopyWith<_$_CostAndExpense> get copyWith =>
      throw _privateConstructorUsedError;
}
