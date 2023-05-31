// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crop_types.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CropTypes _$$_CropTypesFromJson(Map<String, dynamic> json) => _$_CropTypes(
      cultivo:
          (json['cultivo'] as List<dynamic>).map((e) => e as String).toList(),
      tipo: json['tipo'] as String,
      id: json['id'] as String?,
    );

Map<String, dynamic> _$$_CropTypesToJson(_$_CropTypes instance) =>
    <String, dynamic>{
      'cultivo': instance.cultivo,
      'tipo': instance.tipo,
      'id': instance.id,
    };
