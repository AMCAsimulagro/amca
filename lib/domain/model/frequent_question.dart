import 'package:freezed_annotation/freezed_annotation.dart';

part 'frequent_question.freezed.dart';

part 'frequent_question.g.dart';

@unfreezed
class FrequentQuestion with _$FrequentQuestion {
  factory FrequentQuestion({
    String? id,
    required String title,
    required String content,
    required String createdById,
  }) = _FrequentQuestion;

  factory FrequentQuestion.fromJson(Map<String, Object?> json) =>
      _$FrequentQuestionFromJson(json);
}
