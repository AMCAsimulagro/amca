/// {@category Domain}
/// This file contains the generated code for JSON serialization and deserialization of the Description class.
/// It includes functions to convert Description objects to and from JSON maps.
/// This code is generated automatically by the JsonSerializable package.

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'description.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Description _$$_DescriptionFromJson(Map<String, dynamic> json) =>
    _$_Description(
      description: json['description'] as String,
      costOrExpense: json['costOrExpense'] as String,
      type: json['type'] as String,
    );

Map<String, dynamic> _$$_DescriptionToJson(_$_Description instance) =>
    <String, dynamic>{
      'description': instance.description,
      'costOrExpense': instance.costOrExpense,
      'type': instance.type,
    };
