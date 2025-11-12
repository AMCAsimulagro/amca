// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crop_types.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CropTypes _$CropTypesFromJson(Map<String, dynamic> json) => _CropTypes(
      cultivo:
          (json['cultivo'] as List<dynamic>).map((e) => e as String).toList(),
      tipo: json['tipo'] as String,
      id: json['id'] as String?,
    );

Map<String, dynamic> _$CropTypesToJson(_CropTypes instance) =>
    <String, dynamic>{
      'cultivo': instance.cultivo,
      'tipo': instance.tipo,
      'id': instance.id,
    };
