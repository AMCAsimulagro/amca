/// {@category Domain}
/// This file contains the generated JSON serialization/deserialization code for the Spawn class.
/// The code is generated based on the fields of the Spawn class and is used to convert Spawn objects to/from JSON.

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spawn.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

/// Converts JSON data to a Spawn object.
_$_Spawn _$$_SpawnFromJson(Map<String, dynamic> json) => _$_Spawn(
      tipo: (json['tipo'] as List<dynamic>).map((e) => e as String).toList(),
    );

/// Converts a Spawn object to JSON data.
Map<String, dynamic> _$$_SpawnToJson(_$_Spawn instance) => <String, dynamic>{
      'tipo': instance.tipo,
    };
