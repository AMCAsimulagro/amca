/// {@category Domain}
///This file defines the [CostAndExpense] class representing both cost and expense items, along with associated helper methods and JSON serialization.

/// Imports of Bookstores and Resources
import 'package:amca/domain/model/description.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'cost_expense.freezed.dart';

part 'cost_expense.g.dart';

/// This class represents a cost or expense item.
@unfreezed
class CostAndExpense with _$CostAndExpense {
  factory CostAndExpense({
    String? uidOwner,// Owner's UID
    String? partName,// Name of the part
    required String transitoryFarmingId,// ID of the transitory farming
    required DateTime createDate,// ID of the transitory farming
    required String productOrService,// Product or service name
    required Description description,// Description object containing cost or expense details
    required String quantity,// Quantity of the product or service
    required String price,// Price of the product or service
    required String comment,// Additional comments
    String? id,// ID of the cost or expense item
  }) = _CostAndExpense;

  factory CostAndExpense.fromJson(Map<String, Object?> json) =>
      _$CostAndExpenseFromJson(json);
}

/// Extension methods for the [CostAndExpense] class.
extension CostAndExpenseExtension on CostAndExpense {
  // Checks if the item is a cost.
  bool get isCost => description.costOrExpense == 'Costos';

  // Retrieves the year from the creation date.
  int get year => createDate.year;

  // Retrieves the month from the creation date.
  int get month => createDate.month;

  // Converts the price string to a double value.
  double get priceDouble => double.parse(price.replaceAll(',', ''));
}
