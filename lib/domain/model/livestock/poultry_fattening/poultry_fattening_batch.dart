/// {@category Domain}
/// Model for poultry fattening batch records.
library;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:amca/domain/model/livestock/poultry_fattening/poultry_fattening_cost_expense.dart';
import 'package:amca/domain/model/livestock/poultry_fattening/poultry_fattening_tracking.dart';

class PoultryFatteningBatch {
  final String? id;
  final String uidOwner;
  final String farmName;
  final String batchName;
  final int initialQuantity;
  final double averageWeight;
  final String productionStage;
  final String breed;
  final String? customBreed;
  final DateTime startDate;
  final DateTime? expectedSaleDate;
  final DateTime creationDate;
  final List<PoultryFatteningTracking> tracking;
  final List<PoultryFatteningCostExpense> costsAndExpenses;

  const PoultryFatteningBatch({
    this.id,
    required this.uidOwner,
    required this.farmName,
    required this.batchName,
    required this.initialQuantity,
    required this.averageWeight,
    required this.productionStage,
    required this.breed,
    this.customBreed,
    required this.startDate,
    this.expectedSaleDate,
    required this.creationDate,
    required this.tracking,
    required this.costsAndExpenses,
  });

  factory PoultryFatteningBatch.fromJson(Map<String, dynamic> json) {
    return PoultryFatteningBatch(
      id: json['id'] as String?,
      uidOwner: (json['uidOwner'] ?? '') as String,
      farmName: (json['farmName'] ?? '') as String,
      batchName: (json['batchName'] ?? '') as String,
      initialQuantity: (json['initialQuantity'] as num?)?.toInt() ?? 0,
      averageWeight: (json['averageWeight'] as num?)?.toDouble() ?? 0,
      productionStage: (json['productionStage'] ?? '') as String,
      breed: (json['breed'] ?? '') as String,
      customBreed: json['customBreed'] as String?,
      startDate: _parseDate(json['startDate']),
      expectedSaleDate: _parseNullableDate(json['expectedSaleDate']),
      creationDate: _parseDate(json['creationDate']),
      tracking: (json['tracking'] as List<dynamic>? ?? [])
          .map((e) => PoultryFatteningTracking.fromJson(
              Map<String, dynamic>.from(e as Map)))
          .toList(),
      costsAndExpenses: (json['costsAndExpenses'] as List<dynamic>? ?? [])
          .map((e) => PoultryFatteningCostExpense.fromJson(
              Map<String, dynamic>.from(e as Map)))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'uidOwner': uidOwner,
        'farmName': farmName,
        'batchName': batchName,
        'initialQuantity': initialQuantity,
        'averageWeight': averageWeight,
        'productionStage': productionStage,
        'breed': breed,
        'customBreed': customBreed,
        'startDate': Timestamp.fromDate(startDate),
        'expectedSaleDate': expectedSaleDate != null
            ? Timestamp.fromDate(expectedSaleDate!)
            : null,
        'creationDate': Timestamp.fromDate(creationDate),
        'tracking': tracking.map((e) => e.toJson()).toList(),
        'costsAndExpenses': costsAndExpenses.map((e) => e.toJson()).toList(),
      };

  PoultryFatteningBatch copyWith({
    String? id,
    String? uidOwner,
    String? farmName,
    String? batchName,
    int? initialQuantity,
    double? averageWeight,
    String? productionStage,
    String? breed,
    String? customBreed,
    DateTime? startDate,
    DateTime? expectedSaleDate,
    DateTime? creationDate,
    List<PoultryFatteningTracking>? tracking,
    List<PoultryFatteningCostExpense>? costsAndExpenses,
  }) {
    return PoultryFatteningBatch(
      id: id ?? this.id,
      uidOwner: uidOwner ?? this.uidOwner,
      farmName: farmName ?? this.farmName,
      batchName: batchName ?? this.batchName,
      initialQuantity: initialQuantity ?? this.initialQuantity,
      averageWeight: averageWeight ?? this.averageWeight,
      productionStage: productionStage ?? this.productionStage,
      breed: breed ?? this.breed,
      customBreed: customBreed ?? this.customBreed,
      startDate: startDate ?? this.startDate,
      expectedSaleDate: expectedSaleDate ?? this.expectedSaleDate,
      creationDate: creationDate ?? this.creationDate,
      tracking: tracking ?? this.tracking,
      costsAndExpenses: costsAndExpenses ?? this.costsAndExpenses,
    );
  }

  static DateTime _parseDate(dynamic value) {
    if (value is Timestamp) {
      return value.toDate();
    }
    if (value is DateTime) {
      return value;
    }
    if (value is String && value.isNotEmpty) {
      return DateTime.tryParse(value) ?? DateTime.now();
    }
    return DateTime.now();
  }

  static DateTime? _parseNullableDate(dynamic value) {
    if (value == null) {
      return null;
    }
    if (value is Timestamp) {
      return value.toDate();
    }
    if (value is DateTime) {
      return value;
    }
    if (value is String && value.isNotEmpty) {
      return DateTime.tryParse(value);
    }
    return null;
  }
}
