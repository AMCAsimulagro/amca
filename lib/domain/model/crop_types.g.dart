/// {@category Domain}
///This file contains the generated code for serialization and deserialization of CropTypes objects using the json_serializable library. 
///The CropTypes class represents different types of crops and their identifiers.

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crop_types.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

/// Function to convert a JSON map to a CropTypes object.
_$_CropTypes _$$_CropTypesFromJson(Map<String, dynamic> json) => _$_CropTypes(
      cultivo:
          (json['cultivo'] as List<dynamic>).map((e) => e as String).toList(),
      tipo: json['tipo'] as String,
      id: json['id'] as String?,
    );

/// Function to convert a CropTypes object to a JSON map.
Map<String, dynamic> _$$_CropTypesToJson(_$_CropTypes instance) =>
    <String, dynamic>{
      'cultivo': instance.cultivo,
      'tipo': instance.tipo,
      'id': instance.id,
    };
