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
import 'package:amca/domain/model/livestock/animal_husbandry/meat/production.dart';
import 'package:amca/domain/model/livestock/animal_husbandry/meat/production_report_extension.dart';
import 'package:amca/domain/model/reportable_entity.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

import '../../../../../ui/utils/amca_words.dart';

part 'meat_animal_husbandry.freezed.dart';

part 'meat_animal_husbandry.g.dart';

@unfreezed
abstract class MeatAnimalHusbandry
    with _$MeatAnimalHusbandry
    implements ReportableEntity {
  const MeatAnimalHusbandry._();

  factory MeatAnimalHusbandry({
    String? id,
    required DateTime createDate,
    required String totalProfit,
    required String farmName,
    required String numberAnimals,
    required String value,
    String? uidOwner,
    String? comment,
    List<CostAndExpense>? costsAndExpenses,
    Production? production,
  }) = _MeetAnimalHusbandry;

  factory MeatAnimalHusbandry.fromJson(Map<String, Object?> json) =>
      _$MeatAnimalHusbandryFromJson(json);

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

  int profit() {
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

  @override
  Map<String, dynamic> toReportData() => {
        AmcaWords.livestockType: AmcaWords.meat,
        AmcaWords.name: farmName,
        AmcaWords.creationDate: DateFormat('dd/MM/yyyy').format(createDate),
        AmcaWords.animalNumber: numberAnimals,
        AmcaWords.creationValue: value,
        if (null != costsAndExpenses && costsAndExpenses!.isNotEmpty)
          AmcaWords.costsAndExpenses:
              costsAndExpenses?.map((ce) => ce.toReportData()).toList(),
        if (null != production) AmcaWords.production: production?.toReportData()
      };
}
