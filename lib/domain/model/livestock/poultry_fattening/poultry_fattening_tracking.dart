/// {@category Domain}
/// Model for poultry fattening weekly tracking records.
library;

import 'package:cloud_firestore/cloud_firestore.dart';

class PoultryFatteningTracking {
  final String? id;
  final DateTime recordDate;
  final int weekNumber;
  final String recordType;
  final double feedConsumed;
  final int mortality;
  final double? finalAverageWeight;
  final String? notes;

  const PoultryFatteningTracking({
    this.id,
    required this.recordDate,
    required this.weekNumber,
    required this.recordType,
    required this.feedConsumed,
    required this.mortality,
    this.finalAverageWeight,
    this.notes,
  });

  factory PoultryFatteningTracking.fromJson(Map<String, dynamic> json) {
    return PoultryFatteningTracking(
      id: json['id'] as String?,
      recordDate: _parseDate(json['recordDate']),
      weekNumber: (json['weekNumber'] as num?)?.toInt() ?? 0,
      recordType: (json['recordType'] ?? '') as String,
      feedConsumed: (json['feedConsumed'] as num?)?.toDouble() ?? 0,
      mortality: (json['mortality'] as num?)?.toInt() ?? 0,
      finalAverageWeight: (json['finalAverageWeight'] as num?)?.toDouble(),
      notes: json['notes'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'recordDate': Timestamp.fromDate(recordDate),
        'weekNumber': weekNumber,
        'recordType': recordType,
        'feedConsumed': feedConsumed,
        'mortality': mortality,
        'finalAverageWeight': finalAverageWeight,
        'notes': notes,
      };

  PoultryFatteningTracking copyWith({
    String? id,
    DateTime? recordDate,
    int? weekNumber,
    String? recordType,
    double? feedConsumed,
    int? mortality,
    double? finalAverageWeight,
    String? notes,
  }) {
    return PoultryFatteningTracking(
      id: id ?? this.id,
      recordDate: recordDate ?? this.recordDate,
      weekNumber: weekNumber ?? this.weekNumber,
      recordType: recordType ?? this.recordType,
      feedConsumed: feedConsumed ?? this.feedConsumed,
      mortality: mortality ?? this.mortality,
      finalAverageWeight: finalAverageWeight ?? this.finalAverageWeight,
      notes: notes ?? this.notes,
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
}
