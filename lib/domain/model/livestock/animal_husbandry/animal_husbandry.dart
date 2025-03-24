/// {@category Domain}
/// This file defines the PigFarming class, which represents a permanent farming entity.
/// It contains properties such as id, createDate, farmName, descriptionType, expensiveType,
/// format, numberAnimals, amount, value, uidOwner, comment, costsAndExpenses, and production.
/// It also includes methods for JSON serialization and deserialization, as well as a method
/// to calculate the total cost and expense.
library;

/// Imports of Bookstores and Resources
import 'package:amca/domain/model/cost_expense.dart';
import 'package:amca/domain/model/livestock/production.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'animal_husbandry.freezed.dart';

part 'animal_husbandry.g.dart';

@unfreezed
class AnimalHusbandry with _$AnimalHusbandry {
  const AnimalHusbandry._();

  factory AnimalHusbandry({
    String? id,
    required DateTime createDate,
    required String totalProfit,
    required String farmName,
    required String productionType,
    required String descriptionType,
    required String expensiveType,
    required String format,
    required String numberAnimals,
    required String amount,
    required String value,
    String? uidOwner,
    String? comment,
    List<CostAndExpense>? costsAndExpenses,
    //Production? production,
    List<Production>? production,
  }) = _AnimalHusbandry;

  factory AnimalHusbandry.fromJson(Map<String, Object?> json) =>
      _$AnimalHusbandryFromJson(json);

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
    //TODO renombrar
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
