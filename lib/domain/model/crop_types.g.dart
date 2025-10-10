// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crop_types.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CropTypesImpl _$$CropTypesImplFromJson(Map<String, dynamic> json) =>
    _$CropTypesImpl(
      cultivo:
          (json['cultivo'] as List<dynamic>).map((e) => e as String).toList(),
      tipo: json['tipo'] as String,
      id: json['id'] as String?,
    );

Map<String, dynamic> _$$CropTypesImplToJson(_$CropTypesImpl instance) =>
    <String, dynamic>{
      'cultivo': instance.cultivo,
      'tipo': instance.tipo,
      'id': instance.id,
    };
