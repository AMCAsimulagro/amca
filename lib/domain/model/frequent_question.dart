/// {@category Domain}
/// This file defines a FrequentQuestion class using Freezed and JsonSerializable annotations.
/// The FrequentQuestion class represents a frequently asked question with properties for ID, title, content, and creator ID.
/// It is designed to be immutable and provides methods for JSON serialization and deserialization.
/// This file includes both the definition of the FrequentQuestion class and the generated code for JSON serialization/deserialization.
library;

/// Imports of Bookstores and Resources
import 'package:freezed_annotation/freezed_annotation.dart';

part 'frequent_question.freezed.dart';

part 'frequent_question.g.dart';

/// Represents a frequently asked question.
@unfreezed
abstract class FrequentQuestion with _$FrequentQuestion {
  /// Default constructor for FrequentQuestion.
  factory FrequentQuestion({
    String? id,// ID of the question.
    required String title,// Title of the question.
    required String content,// Content of the question.
    String? createdById,// ID of the creator.
  }) = _FrequentQuestion;

  /// Factory constructor to create FrequentQuestion object from JSON.
  factory FrequentQuestion.fromJson(Map<String, Object?> json) =>
      _$FrequentQuestionFromJson(json);
}
