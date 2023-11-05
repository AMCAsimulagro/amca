// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'frequent_question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_FrequentQuestion _$$_FrequentQuestionFromJson(Map<String, dynamic> json) =>
    _$_FrequentQuestion(
      id: json['id'] as String?,
      title: json['title'] as String,
      content: json['content'] as String,
      createdById: json['createdById'] as String?,
    );

Map<String, dynamic> _$$_FrequentQuestionToJson(_$_FrequentQuestion instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'createdById': instance.createdById,
    };
