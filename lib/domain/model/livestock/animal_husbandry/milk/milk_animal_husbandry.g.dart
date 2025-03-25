// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'milk_animal_husbandry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AnimalHusbandryImpl _$$AnimalHusbandryImplFromJson(
        Map<String, dynamic> json) =>
    _$AnimalHusbandryImpl(
      id: json['id'] as String?,
      createDate: DateTime.parse(json['createDate'] as String),
      totalProfit: json['totalProfit'] as String,
      farmName: json['farmName'] as String,
      productionType: json['productionType'] as String,
      descriptionType: json['descriptionType'] as String,
      expensiveType: json['expensiveType'] as String,
      format: json['format'] as String,
      numberAnimals: json['numberAnimals'] as String,
      amount: json['amount'] as String,
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

Map<String, dynamic> _$$AnimalHusbandryImplToJson(
        _$AnimalHusbandryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createDate': instance.createDate.toIso8601String(),
      'totalProfit': instance.totalProfit,
      'farmName': instance.farmName,
      'productionType': instance.productionType,
      'descriptionType': instance.descriptionType,
      'expensiveType': instance.expensiveType,
      'format': instance.format,
      'numberAnimals': instance.numberAnimals,
      'amount': instance.amount,
      'value': instance.value,
      'uidOwner': instance.uidOwner,
      'comment': instance.comment,
      'costsAndExpenses':
          instance.costsAndExpenses?.map((e) => e.toJson()).toList(),
      'production': instance.production?.map((e) => e.toJson()).toList(),
    };
