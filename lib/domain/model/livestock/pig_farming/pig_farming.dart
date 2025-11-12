/// {@category Domain}
/// This file defines the PigFarming class, which represents a permanent farming entity.
/// It contains properties such as id, createDate, farmName, cropType, crop, sownArea, sownType,
/// format, amountSown, value, uidOwner, comment, costsAndExpenses, and production. It also includes
/// methods for JSON serialization and deserialization, as well as a method to calculate the total
/// cost and expense.
library;

/// Imports of Bookstores and Resources
import 'package:amca/domain/model/cost_expense.dart';
import 'package:amca/domain/model/cost_expense_report_extension.dart';
import 'package:amca/domain/model/livestock/pig_farming/production_report_extension.dart';
import 'package:amca/domain/model/reportable_entity.dart';
import 'package:amca/ui/utils/amca_words.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';
import 'production.dart';

part 'pig_farming.freezed.dart';

part 'pig_farming.g.dart';

@unfreezed
abstract class PigFarming 
with _$PigFarming 
    implements ReportableEntity {
  const PigFarming._();

  factory PigFarming({
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
  }) = _PigFarming;

  factory PigFarming.fromJson(Map<String, Object?> json) =>
      _$PigFarmingFromJson(json);

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
  Map<String, dynamic> toReportData() {
    return {
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
}
