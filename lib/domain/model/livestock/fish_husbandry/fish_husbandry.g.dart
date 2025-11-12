// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fish_husbandry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FishHusbandryImpl _$$FishHusbandryImplFromJson(Map<String, dynamic> json) =>
    _$FishHusbandryImpl(
      id: json['id'] as String?,
      createDate: DateTime.parse(json['createDate'] as String),
      totalProfit: json['totalProfit'] as String,
      farmName: json['farmName'] as String,
      numberAnimals: json['numberAnimals'] as String,
      value: json['value'] as String,
      uidOwner: json['uidOwner'] as String?,
      comment: json['comment'] as String?,
      fishType: json['fishType'] as String?,
      pondLength: json['pondLength'] as String?,
      pondWidth: json['pondWidth'] as String?,
      pondDepth: json['pondDepth'] as String?,
      costsAndExpenses: (json['costsAndExpenses'] as List<dynamic>?)
          ?.map((e) => CostAndExpense.fromJson(e as Map<String, dynamic>))
          .toList(),
      production: json['production'] == null
          ? null
          : Production.fromJson(json['production'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$FishHusbandryImplToJson(_$FishHusbandryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createDate': instance.createDate.toIso8601String(),
      'totalProfit': instance.totalProfit,
      'farmName': instance.farmName,
      'numberAnimals': instance.numberAnimals,
      'value': instance.value,
      'uidOwner': instance.uidOwner,
      'comment': instance.comment,
      'fishType': instance.fishType,
      'pondLength': instance.pondLength,
      'pondWidth': instance.pondWidth,
      'pondDepth': instance.pondDepth,
      'costsAndExpenses':
          instance.costsAndExpenses?.map((e) => e.toJson()).toList(),
      'production': instance.production?.toJson(),
    };
