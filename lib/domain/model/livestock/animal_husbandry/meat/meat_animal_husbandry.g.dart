// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meat_animal_husbandry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MeatAnimalHusbandry _$MeatAnimalHusbandryFromJson(Map<String, dynamic> json) =>
    _MeatAnimalHusbandry(
      id: json['id'] as String?,
      createDate: DateTime.parse(json['createDate'] as String),
      totalProfit: json['totalProfit'] as String,
      farmName: json['farmName'] as String,
      numberAnimals: json['numberAnimals'] as String,
      value: json['value'] as String,
      area: json['area'] as String?,
      uidOwner: json['uidOwner'] as String?,
      comment: json['comment'] as String?,
      costsAndExpenses: (json['costsAndExpenses'] as List<dynamic>?)
          ?.map((e) => CostAndExpense.fromJson(e as Map<String, dynamic>))
          .toList(),
      production: json['production'] == null
          ? null
          : Production.fromJson(json['production'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MeatAnimalHusbandryToJson(
        _MeatAnimalHusbandry instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createDate': instance.createDate.toIso8601String(),
      'totalProfit': instance.totalProfit,
      'farmName': instance.farmName,
      'numberAnimals': instance.numberAnimals,
      'value': instance.value,
      'area': instance.area,
      'uidOwner': instance.uidOwner,
      'comment': instance.comment,
      'costsAndExpenses':
          instance.costsAndExpenses?.map((e) => e.toJson()).toList(),
      'production': instance.production?.toJson(),
    };
