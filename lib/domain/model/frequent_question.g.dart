/// {@category Domain}
/// This file contains the generated code for JSON serialization and deserialization of the FrequentQuestion class.
/// It includes functions to convert FrequentQuestion objects to and from JSON maps.
/// This code is generated automatically by the JsonSerializable package.

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'frequent_question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

/// Function to convert a JSON map to a FrequentQuestion object.
_$_FrequentQuestion _$$_FrequentQuestionFromJson(Map<String, dynamic> json) =>
    _$_FrequentQuestion(
      id: json['id'] as String?,
      title: json['title'] as String,
      content: json['content'] as String,
      createdById: json['createdById'] as String?,
    );

/// Function to convert a FrequentQuestion object to a JSON map.
Map<String, dynamic> _$$_FrequentQuestionToJson(_$_FrequentQuestion instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'createdById': instance.createdById,
    };
