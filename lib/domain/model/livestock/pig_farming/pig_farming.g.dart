// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pig_farming.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PigFarmingImpl _$$PigFarmingImplFromJson(Map<String, dynamic> json) =>
    _$PigFarmingImpl(
      id: json['id'] as String?,
      createDate: DateTime.parse(json['createDate'] as String),
      totalProfit: json['totalProfit'] as String,
      farmName: json['farmName'] as String,
      cropType: json['cropType'] as String,
      crop: json['crop'] as String,
      sownArea: json['sownArea'] as String,
      sownType: json['sownType'] as String,
      format: json['format'] as String,
      amountSown: json['amountSown'] as String,
      value: json['value'] as String,
      uidOwner: json['uidOwner'] as String?,
      comment: json['comment'] as String?,
      costsAndExpenses: (json['costsAndExpenses'] as List<dynamic>?)
          ?.map((e) => CostAndExpense.fromJson(e as Map<String, dynamic>))
          .toList(),
      production: (json['production'] as List<dynamic>?)
          ?.map((e) => Production.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$PigFarmingImplToJson(_$PigFarmingImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createDate': instance.createDate.toIso8601String(),
      'totalProfit': instance.totalProfit,
      'farmName': instance.farmName,
      'cropType': instance.cropType,
      'crop': instance.crop,
      'sownArea': instance.sownArea,
      'sownType': instance.sownType,
      'format': instance.format,
      'amountSown': instance.amountSown,
      'value': instance.value,
      'uidOwner': instance.uidOwner,
      'comment': instance.comment,
      'costsAndExpenses':
          instance.costsAndExpenses?.map((e) => e.toJson()).toList(),
      'production': instance.production?.map((e) => e.toJson()).toList(),
    };
