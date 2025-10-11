/// {@category Domain}
/// This file defines a Description class using Freezed and JsonSerializable annotations.
/// The Description class represents an object with properties for description, cost or expense, and type.
/// It is designed to be immutable and provides methods for JSON serialization and deserialization.
/// This file includes both the definition of the Description class and the generated code for JSON serialization/deserialization.
library;

/// Imports of Bookstores and Resources
import 'package:freezed_annotation/freezed_annotation.dart';

part 'description.freezed.dart';

part 'description.g.dart';

/// Represents a description object.
@freezed
abstract class Description with _$Description {
  /// Default constructor for Description.
  factory Description({
    required String description,// Description of the object.
    required String costOrExpense,// Cost or expense associated with the object.
    required String type,// Type of the object.
  }) = _Description;

  /// Factory constructor to create Description object from JSON.
  factory Description.fromJson(Map<String, Object?> json) =>
      _$DescriptionFromJson(json);
}
