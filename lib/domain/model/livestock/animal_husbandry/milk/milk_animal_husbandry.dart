/// {@category Domain}
/// This file defines the PigFarming class, which represents a permanent farming entity.
/// It contains properties such as id, createDate, farmName, descriptionType, expensiveType,
/// format, numberAnimals, amount, value, uidOwner, comment, costsAndExpenses, and production.
/// It also includes methods for JSON serialization and deserialization, as well as a method
/// to calculate the total cost and expense.
library;

/// Imports of Bookstores and Resources
import 'package:amca/domain/model/cost_expense.dart';
import 'package:amca/domain/model/cost_expense_report_extension.dart';
import 'package:amca/domain/model/livestock/animal_husbandry/milk/milk_production.dart';
import 'package:amca/domain/model/livestock/animal_husbandry/milk/milk_production_report_extension.dart';
import 'package:amca/domain/model/reportable_entity.dart';
import 'package:amca/ui/utils/amca_words.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

part 'milk_animal_husbandry.freezed.dart';

part 'milk_animal_husbandry.g.dart';

@unfreezed
class MilkAnimalHusbandry
    with _$MilkAnimalHusbandry
    implements ReportableEntity {
  const MilkAnimalHusbandry._();

  factory MilkAnimalHusbandry({
    String? id,
    required DateTime createDate,
    required String totalProfit,
    required String farmName,
    required String numberAnimals,
    required String value,
    String? uidOwner,
    String? comment,
    List<CostAndExpense>? costsAndExpenses,
    //Production? production,
    List<Production>? production,
  }) = _AnimalHusbandry;

  factory MilkAnimalHusbandry.fromJson(Map<String, Object?> json) =>
      _$MilkAnimalHusbandryFromJson(json);

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

  @override
  Map<String, dynamic> toReportData() => {
        AmcaWords.livestockType: AmcaWords.milk,
        AmcaWords.name: farmName,
        AmcaWords.creationDate: DateFormat('dd/MM/yyyy').format(createDate),
        AmcaWords.animalNumber: numberAnimals,
        AmcaWords.creationValue: value,
        if (null != costsAndExpenses && costsAndExpenses!.isNotEmpty)
          AmcaWords.costsAndExpenses:
              costsAndExpenses?.map((ce) => ce.toReportData()).toList(),
        if (null != production && production!.isNotEmpty)
          AmcaWords.productions:
              production?.map((ce) => ce.toReportData()).toList(),
      };
}
