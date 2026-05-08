/// {@category Models}
/// Represents a daily production/operation record for laying galpón.
library;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class LayingDailyRecord {
  LayingDailyRecord({
    this.id,
    required this.galponId,
    required this.date,
    this.eggsAAA = 0,
    this.eggsAA = 0,
    this.eggsA = 0,
    this.eggsB = 0,
    this.eggsC = 0,
    this.brokenEggs = 0,
    this.dirtyEggs = 0,
    this.foodConsumedKg = 0,
    this.mortality = 0,
  });

  final String? id;
  final String galponId;
  final DateTime date;
  int eggsAAA;
  int eggsAA;
  int eggsA;
  int eggsB;
  int eggsC;
  int brokenEggs;
  int dirtyEggs;
  double foodConsumedKg;
  int mortality;

  int get totalProduction =>
      eggsAAA + eggsAA + eggsA + eggsB + eggsC;

  LayingDailyRecord copyWith({
    String? id,
    String? galponId,
    DateTime? date,
    int? eggsAAA,
    int? eggsAA,
    int? eggsA,
    int? eggsB,
    int? eggsC,
    int? brokenEggs,
    int? dirtyEggs,
    double? foodConsumedKg,
    int? mortality,
  }) {
    return LayingDailyRecord(
      id: id ?? this.id,
      galponId: galponId ?? this.galponId,
      date: date ?? this.date,
      eggsAAA: eggsAAA ?? this.eggsAAA,
      eggsAA: eggsAA ?? this.eggsAA,
      eggsA: eggsA ?? this.eggsA,
      eggsB: eggsB ?? this.eggsB,
      eggsC: eggsC ?? this.eggsC,
      brokenEggs: brokenEggs ?? this.brokenEggs,
      dirtyEggs: dirtyEggs ?? this.dirtyEggs,
      foodConsumedKg: foodConsumedKg ?? this.foodConsumedKg,
      mortality: mortality ?? this.mortality,
    );
  }

  factory LayingDailyRecord.fromMap(Map<String, dynamic> map, String id) {
    final dateValue = map['date'];
    return LayingDailyRecord(
      id: id,
      galponId: map['galponId'] as String? ?? '',
      date: dateValue is Timestamp
          ? dateValue.toDate()
          : DateTime.tryParse(map['date'] ?? '') ?? DateTime.now(),
      eggsAAA: map['eggsAAA'] as int? ?? 0,
      eggsAA: map['eggsAA'] as int? ?? 0,
      eggsA: map['eggsA'] as int? ?? 0,
      eggsB: map['eggsB'] as int? ?? 0,
      eggsC: map['eggsC'] as int? ?? 0,
      brokenEggs: map['brokenEggs'] as int? ?? 0,
      dirtyEggs: map['dirtyEggs'] as int? ?? 0,
      foodConsumedKg: (map['foodConsumedKg'] as num?)?.toDouble() ?? 0,
      mortality: map['mortality'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'galponId': galponId,
      'date': Timestamp.fromDate(date),
      'eggsAAA': eggsAAA,
      'eggsAA': eggsAA,
      'eggsA': eggsA,
      'eggsB': eggsB,
      'eggsC': eggsC,
      'brokenEggs': brokenEggs,
      'dirtyEggs': dirtyEggs,
      'foodConsumedKg': foodConsumedKg,
      'mortality': mortality,
      'totalProduction': totalProduction,
    };
  }
}
