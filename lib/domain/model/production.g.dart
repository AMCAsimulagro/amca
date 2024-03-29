/// {@category Domain}
/// This file contains the generated code for JSON serialization and deserialization of the Production class.
/// It includes functions to convert Production objects to and from JSON maps.
/// This code is generated automatically by the JsonSerializable package.

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'production.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

/// Function to convert a JSON map to a Production object.
_$_Production _$$_ProductionFromJson(Map<String, dynamic> json) =>
    _$_Production(
      uidOwner: json['uidOwner'] as String?,
      partName: json['partName'] as String?,
      transitoryFarmingId: json['transitoryFarmingId'] as String,
      createDate: DateTime.parse(json['createDate'] as String),
      unitOfMeasurement: json['unitOfMeasurement'] as String,
      quantity: json['quantity'] as String,
      price: json['price'] as String,
      totalValue: json['totalValue'] as String?,
      id: json['id'] as String?,
    );

/// Function to convert a Production object to a JSON map.
Map<String, dynamic> _$$_ProductionToJson(_$_Production instance) =>
    <String, dynamic>{
      'uidOwner': instance.uidOwner,
      'partName': instance.partName,
      'transitoryFarmingId': instance.transitoryFarmingId,
      'createDate': instance.createDate.toIso8601String(),
      'unitOfMeasurement': instance.unitOfMeasurement,
      'quantity': instance.quantity,
      'price': instance.price,
      'totalValue': instance.totalValue,
      'id': instance.id,
    };
