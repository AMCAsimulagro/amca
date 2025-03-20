/// {@category Domain}
/// This file defines the PermanentFarming class, which represents a permanent farming entity.
/// It contains properties such as id, createDate, partName, cropType, crop, sownArea, sownType,
/// format, amountSown, value, uidOwner, comment, costsAndExpenses, and production. It also includes
/// methods for JSON serialization and deserialization, as well as a method to calculate the total
/// cost and expense.
library;

/// Imports of Bookstores and Resources
import 'package:amca/domain/model/cost_expense.dart';
import 'package:amca/domain/model/production_permanent.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'permanent_farming.freezed.dart';

part 'permanent_farming.g.dart';

@unfreezed
class PermanentFarming with _$PermanentFarming {
  const PermanentFarming._();

  factory PermanentFarming({
    String? id,
    required DateTime createDate,
    required String totalProfit,
    required String partName,
    required String cropType,
    required String crop,
    required String sownArea,
    required String sownType,
    required String format,
    required String amountSown,
    required String value,
    String? uidOwner,
    String? comment,
    List<CostAndExpense>? costsAndExpenses,
    //Production? production,
    List<Production>? production,
  }) = _PermanentFarming;

  factory PermanentFarming.fromJson(Map<String, Object?> json) =>
      _$PermanentFarmingFromJson(json);

  int calculateTotalCostAndExpense() {
    int totalCostAndExpense = 0;
    if ((costsAndExpenses ?? []).isNotEmpty) {
      totalCostAndExpense = costsAndExpenses?.map((e) {
            final price = int.parse(e.price.replaceAll(',', ''));
            return price;
          }).reduce((value, element) => value + element) ??
          0;
    }
    return totalCostAndExpense;
  }

  int profitCrop() {
    int totalCostAndExpense = 0;
    if ((costsAndExpenses ?? []).isNotEmpty) {
      totalCostAndExpense = costsAndExpenses?.map((e) {
            final price = int.parse(e.price.replaceAll(',', ''));
            return price;
          }).reduce((value, element) => value + element) ??
          0;
    }
    totalCostAndExpense =
        totalCostAndExpense + int.parse(value.replaceAll(',', ''));
    return totalCostAndExpense;
  }

  int totalPrice() {
    int total = 0;

    if ((production ?? []).isNotEmpty) {
      total = production?.map((e) {
            final price = int.parse(e.price.replaceAll(',', ''));
            return price;
          }).reduce((value, element) => value + element) ??
          0;
    }
    return total;
  }
}
