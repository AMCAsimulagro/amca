/// {@category Domain}
/// This file defines a Production class using Freezed and JsonSerializable annotations.
/// The Production class represents a production with properties for various details such as owner UID, part name,
/// transitory farming ID, creation date, unit of measurement, quantity, price, total value, and ID.
/// It is designed to be immutable and provides methods for JSON serialization and deserialization.
/// This file includes both the definition of the Production class and the generated code for JSON serialization/deserialization.
/// Freezed annotations are used to generate constructors and equality checks for the class, while JsonSerializable annotations
/// are used to generate toJson() and fromJson() methods for serialization and deserialization.
library;

/// Imports of Bookstores and Resources
import 'package:freezed_annotation/freezed_annotation.dart';

part 'production.freezed.dart';

part 'production.g.dart';

/// Represents a production.
@unfreezed
abstract class Production with _$Production {
  /// Default constructor for Production.
  factory Production({
    String? uidOwner,// Owner UID of the production.
    String? partName,// Part name of the production.
    required String transitoryFarmingId,// Transitory farming ID of the production.
    required DateTime createDate,// Creation date of the production.
    required String unitOfMeasurement,// Unit of measurement of the production.
    required String quantity,// Quantity of the production.
    required String price,// Price of the production.
    String? average,
    String? totalValue,// Total value of the production.
    String? id,//ID of the production.
  }) = _Production;

  /// Factory constructor to create Production object from JSON.
  factory Production.fromJson(Map<String, Object?> json) =>
      _$ProductionFromJson(json);
}
