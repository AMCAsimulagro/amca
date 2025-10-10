// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transitory_farming.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TransitoryFarmingImpl _$$TransitoryFarmingImplFromJson(
        Map<String, dynamic> json) =>
    _$TransitoryFarmingImpl(
      id: json['id'] as String?,
      createDate: DateTime.parse(json['createDate'] as String),
      partName: json['partName'] as String,
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
      production: json['production'] == null
          ? null
          : Production.fromJson(json['production'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$TransitoryFarmingImplToJson(
        _$TransitoryFarmingImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createDate': instance.createDate.toIso8601String(),
      'partName': instance.partName,
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
      'production': instance.production?.toJson(),
    };
