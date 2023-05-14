// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cost_expense.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CostAndExpense _$$_CostAndExpenseFromJson(Map<String, dynamic> json) =>
    _$_CostAndExpense(
      uidOwner: json['uidOwner'] as String?,
      partName: json['partName'] as String?,
      transitoryFarmingId: json['transitoryFarmingId'] as String,
      createDate: DateTime.parse(json['createDate'] as String),
      productOrService: json['productOrService'] as String,
      description:
          Description.fromJson(json['description'] as Map<String, dynamic>),
      quantity: json['quantity'] as String,
      price: json['price'] as String,
      comment: json['comment'] as String,
      id: json['id'] as String?,
    );

Map<String, dynamic> _$$_CostAndExpenseToJson(_$_CostAndExpense instance) =>
    <String, dynamic>{
      'uidOwner': instance.uidOwner,
      'partName': instance.partName,
      'transitoryFarmingId': instance.transitoryFarmingId,
      'createDate': instance.createDate.toIso8601String(),
      'productOrService': instance.productOrService,
      'description': instance.description.toJson(),
      'quantity': instance.quantity,
      'price': instance.price,
      'comment': instance.comment,
      'id': instance.id,
    };
