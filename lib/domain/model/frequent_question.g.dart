// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'frequent_question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FrequentQuestionImpl _$$FrequentQuestionImplFromJson(
        Map<String, dynamic> json) =>
    _$FrequentQuestionImpl(
      id: json['id'] as String?,
      title: json['title'] as String,
      content: json['content'] as String,
      createdById: json['createdById'] as String?,
    );

Map<String, dynamic> _$$FrequentQuestionImplToJson(
        _$FrequentQuestionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'createdById': instance.createdById,
    };
