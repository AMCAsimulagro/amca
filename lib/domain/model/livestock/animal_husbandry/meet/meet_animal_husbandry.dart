/// {@category Domain}
/// This file defines the PigFarming class, which represents a permanent farming entity.
/// It contains properties such as id, createDate, farmName, descriptionType, expensiveType,
/// format, numberAnimals, amount, value, uidOwner, comment, costsAndExpenses, and production.
/// It also includes methods for JSON serialization and deserialization, as well as a method
/// to calculate the total cost and expense.
library;

/// Imports of Bookstores and Resources
import 'package:amca/domain/model/cost_expense.dart';
import 'package:amca/domain/model/livestock/animal_husbandry/meet/production.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'meet_animal_husbandry.freezed.dart';

part 'meet_animal_husbandry.g.dart';

@unfreezed
class MeetAnimalHusbandry with _$MeetAnimalHusbandry {
  const MeetAnimalHusbandry._();

  factory MeetAnimalHusbandry({
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
    Production? production,
  }) = _MeetAnimalHusbandry;

  factory MeetAnimalHusbandry.fromJson(Map<String, Object?> json) =>
      _$MeetAnimalHusbandryFromJson(json);

  int calculateTotalCostAndExpense() {
    int totalCostAndExpense = 0;
    if ((costsAndExpenses ?? []).isNotEmpty) {
      totalCostAndExpense = costsAndExpenses?.map((e) {
            final price = int.parse(e.price.replaceAll(',', ''));
            return price;
          }).reduce((value, element) => value + element) ??
          0;
    }
    //totalCostAndExpense = totalCostAndExpense + int.parse(value.replaceAll(',', ''));
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
}
