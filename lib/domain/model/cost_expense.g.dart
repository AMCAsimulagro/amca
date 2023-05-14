// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cost_expense.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CostAndExpense _$$_CostAndExpenseFromJson(Map<String, dynamic> json) =>
    _$_CostAndExpense(
      uidOwner: json['uidOwner'] as String,
      farmingName: json['farmingName'] as String?,
      partName: json['partName'] as String?,
      transitoryFarmingId: json['transitoryFarmingId'] as String,
      createDate: DateTime.parse(json['createDate'] as String),
      productOrService: json['productOrService'] as String,
      description: json['description'],
      costOrExpense: json['costOrExpense'] as String,
      type: json['type'] as String,
      quantity: json['quantity'] as String,
      price: json['price'] as String,
      comment: json['comment'] as String,
      id: json['id'] as String?,
      isAdmin: json['isAdmin'] as bool? ?? false,
    );

Map<String, dynamic> _$$_CostAndExpenseToJson(_$_CostAndExpense instance) =>
    <String, dynamic>{
      'uidOwner': instance.uidOwner,
      'farmingName': instance.farmingName,
      'partName': instance.partName,
      'transitoryFarmingId': instance.transitoryFarmingId,
      'createDate': instance.createDate.toIso8601String(),
      'productOrService': instance.productOrService,
      'description': instance.description,
      'costOrExpense': instance.costOrExpense,
      'type': instance.type,
      'quantity': instance.quantity,
      'price': instance.price,
      'comment': instance.comment,
      'id': instance.id,
      'isAdmin': instance.isAdmin,
    };
