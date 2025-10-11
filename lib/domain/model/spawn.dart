/// {@category Domain}
/// This file defines a Spawn class using Freezed and JsonSerializable annotations.
/// The Spawn class represents a spawn with a list of types.
/// It is designed to be immutable and provides methods for JSON serialization and deserialization.
/// This file includes both the definition of the Spawn class and the generated code for JSON serialization/deserialization.
library;

/// Imports of Bookstores and Resources
import 'package:freezed_annotation/freezed_annotation.dart';
part 'spawn.freezed.dart';

part 'spawn.g.dart';

/// Represents a spawn.
@freezed
class Spawn with _$Spawn {
  /// Default constructor for Spawn.
  factory Spawn({
    required List<String> tipo,
  }) = _Spawn;

  /// Factory constructor to create Spawn object from JSON.
  factory Spawn.fromJson(Map<String, Object?> json) =>
      _$SpawnFromJson(json);
}
