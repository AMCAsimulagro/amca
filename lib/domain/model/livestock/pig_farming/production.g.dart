// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'production.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Production _$ProductionFromJson(Map<String, dynamic> json) => _Production(
      uidOwner: json['uidOwner'] as String?,
      partName: json['partName'] as String?,
      transitoryFarmingId: json['transitoryFarmingId'] as String,
      createDate: DateTime.parse(json['createDate'] as String),
      unitOfMeasurement: json['unitOfMeasurement'] as String,
      quantity: json['quantity'] as String,
      price: json['price'] as String,
      average: json['average'] as String?,
      totalValue: json['totalValue'] as String?,
      id: json['id'] as String?,
    );

Map<String, dynamic> _$ProductionToJson(_Production instance) =>
    <String, dynamic>{
      'uidOwner': instance.uidOwner,
      'partName': instance.partName,
      'transitoryFarmingId': instance.transitoryFarmingId,
      'createDate': instance.createDate.toIso8601String(),
      'unitOfMeasurement': instance.unitOfMeasurement,
      'quantity': instance.quantity,
      'price': instance.price,
      'average': instance.average,
      'totalValue': instance.totalValue,
      'id': instance.id,
    };
