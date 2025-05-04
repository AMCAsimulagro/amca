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

part 'meat_animal_husbandry.freezed.dart';

part 'meat_animal_husbandry.g.dart';

@unfreezed
class MeatAnimalHusbandry
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
    print(
        'calculateTotalCostAndExpense -> $totalCostAndExpense'); // TODO eliminar
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
    print('profit -> $totalCostAndExpense'); // TODO eliminar
    return totalCostAndExpense;
  }

  @override
  Map<String, dynamic> toReportData() => {
        'Ganadería de': 'Carne',
        'Nombre': farmName,
        'Fecha de creación': DateFormat('dd/MM/yyyy').format(createDate),
        'Número de animales': numberAnimals,
        'Valor invertido en la creación': value,
        if (null != costsAndExpenses && costsAndExpenses!.isNotEmpty)
          'Costos y gastos':
              costsAndExpenses?.map((ce) => ce.toReportData()).toList(),
        if (null != production) 'Producción': production?.toReportData()
      };
}
