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
import 'package:amca/domain/model/livestock/fish_husbandry/production.dart';
import 'package:amca/domain/model/livestock/fish_husbandry/production_report_extension.dart';
import 'package:amca/domain/model/reportable_entity.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

import '../../../../../ui/utils/amca_words.dart';

part 'fish_husbandry.freezed.dart';

part 'fish_husbandry.g.dart';

@unfreezed
abstract class FishHusbandry with _$FishHusbandry implements ReportableEntity {
  const FishHusbandry._();

  factory FishHusbandry({
    String? id,
    required DateTime createDate,
    required String totalProfit,
    required String farmName,
    required String numberAnimals,
    required String value,
    String? uidOwner,
    String? comment,
    String? fishType,
    String? pondLength,
    String? pondWidth,
    String? pondDepth,
    String? pondVolume,
    List<CostAndExpense>? costsAndExpenses,
    Production? production,
  }) = _FishHusbandry;

  factory FishHusbandry.fromJson(Map<String, Object?> json) =>
      _$FishHusbandryFromJson(json);

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

  /// Calcula el volumen a partir de tres valores de string (largo y ancho)
  String _calculateAreaFromStrings(String? length, String? width, String? depth) {
    if (length == null || width == null) return '';
    final lengthDouble = double.tryParse(length) ?? 0;
    final widthDouble = double.tryParse(width) ?? 0;
    final depthDouble = double.tryParse(depth!) ?? 0;
    final area = lengthDouble * widthDouble * depthDouble;
    return area > 0 ? area.toStringAsFixed(2) : '';
  }

  @override
  Map<String, dynamic> toReportData() => {
        AmcaWords.livestockType: AmcaWords.fish,
        AmcaWords.name: farmName,
        AmcaWords.creationDate: DateFormat('dd/MM/yyyy').format(createDate),
        AmcaWords.fishNumber: numberAnimals,
        if (fishType != null) 'Tipo de pez': fishType,
        if (pondLength != null) AmcaWords.alongThePond: pondLength,
        if (pondWidth != null) AmcaWords.pondWidth: pondWidth,
        if (pondLength != null && pondWidth != null && pondDepth != null)
          '${AmcaWords.pondVolume} (${AmcaWords.fishCM})': _calculateAreaFromStrings(pondLength, pondWidth, pondDepth),
        if (pondDepth != null) AmcaWords.pondDepth: pondDepth,
        AmcaWords.creationValue: value,
        if (null != costsAndExpenses && costsAndExpenses!.isNotEmpty)
          AmcaWords.costsAndExpenses:
              costsAndExpenses?.map((ce) => ce.toReportData()).toList(),
        if (null != production) AmcaWords.production: production?.toReportData()
      };
}
