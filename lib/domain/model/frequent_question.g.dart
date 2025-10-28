// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'frequent_question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FrequentQuestion _$FrequentQuestionFromJson(Map<String, dynamic> json) =>
    _FrequentQuestion(
      id: json['id'] as String?,
      title: json['title'] as String,
      content: json['content'] as String,
      createdById: json['createdById'] as String?,
    );

Map<String, dynamic> _$FrequentQuestionToJson(_FrequentQuestion instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'createdById': instance.createdById,
    };
