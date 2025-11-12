// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'description.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Description _$DescriptionFromJson(Map<String, dynamic> json) => _Description(
      description: json['description'] as String,
      costOrExpense: json['costOrExpense'] as String,
      type: json['type'] as String,
    );

Map<String, dynamic> _$DescriptionToJson(_Description instance) =>
    <String, dynamic>{
      'description': instance.description,
      'costOrExpense': instance.costOrExpense,
      'type': instance.type,
    };
