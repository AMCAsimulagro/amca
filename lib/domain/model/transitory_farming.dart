/// {@category Domain}
/// This file defines the TransitoryFarming class, which represents a transitory farming entity.
/// It contains properties such as id, createDate, partName, cropType, crop, sownArea, sownType,
/// format, amountSown, value, uidOwner, comment, costsAndExpenses, and production. It also includes
/// methods for JSON serialization and deserialization, as well as a method to calculate the total
/// cost and expense.
library;

/// Imports of Bookstores and Resources
import 'package:amca/domain/model/cost_expense.dart';
import 'package:amca/domain/model/cost_expense_report_extension.dart';
import 'package:amca/domain/model/production.dart';
import 'package:amca/domain/model/production_report_extension.dart';
import 'package:amca/domain/model/reportable_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

import '../../ui/utils/amca_words.dart';

part 'transitory_farming.freezed.dart';

part 'transitory_farming.g.dart';

@unfreezed
abstract class TransitoryFarming with _$TransitoryFarming implements ReportableEntity {
  const TransitoryFarming._();

  factory TransitoryFarming({
    String? id,
    required DateTime createDate,
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
    Production? production,
  }) = _TransitoryFarming;

  factory TransitoryFarming.fromJson(Map<String, Object?> json) =>
      _$TransitoryFarmingFromJson(json);

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
        AmcaWords.name: partName,
        AmcaWords.cropType: cropType,
        AmcaWords.crop: crop,
        AmcaWords.sownArea: sownArea,
        AmcaWords.sownType: sownType,
        AmcaWords.format: format,
        AmcaWords.amountSown: amountSown,
        AmcaWords.creationDate: DateFormat('dd/MM/yyyy').format(createDate),
        AmcaWords.creationValue: value,
        if (null != costsAndExpenses && costsAndExpenses!.isNotEmpty)
          AmcaWords.costsAndExpenses:
              costsAndExpenses?.map((ce) => ce.toReportData()).toList(),
        if (null != production)
          AmcaWords.production: production?.toReportData(),
      };
}
