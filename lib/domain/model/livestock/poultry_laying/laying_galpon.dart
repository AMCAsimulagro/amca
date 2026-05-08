/// {@category Models}
/// Domain representation of a laying house (galpón ponedor).
library;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class LayingGalpon {
  LayingGalpon({
    this.id,
    required this.name,
    required this.startDate,
    required this.populationInitial,
    this.state = LayingGalponState.active,
    this.userId,
  });

  final String? id;
  final String name;
  final DateTime startDate;
  final int populationInitial;
  final String? userId;
  LayingGalponState state;

  LayingGalpon copyWith({
    String? id,
    String? name,
    DateTime? startDate,
    int? populationInitial,
    LayingGalponState? state,
    String? userId,
  }) {
    return LayingGalpon(
      id: id ?? this.id,
      name: name ?? this.name,
      startDate: startDate ?? this.startDate,
      populationInitial: populationInitial ?? this.populationInitial,
      state: state ?? this.state,
      userId: userId ?? this.userId,
    );
  }

  factory LayingGalpon.fromMap(Map<String, dynamic> map, String id) {
    final timestamp = map['startDate'];
    return LayingGalpon(
      id: id,
      name: map['name'] as String? ?? '',
      startDate: timestamp is Timestamp ? timestamp.toDate() : DateTime.tryParse(map['startDate'] ?? '') ?? DateTime.now(),
      populationInitial: map['populationInitial'] as int? ?? 0,
      state: (map['state'] as String?) == 'finalizado'
          ? LayingGalponState.finalized
          : LayingGalponState.active,
      userId: map['userId'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'startDate': Timestamp.fromDate(startDate),
      'populationInitial': populationInitial,
      'state': state == LayingGalponState.finalized ? 'finalizado' : 'activo',
      'userId': userId,
    };
  }
}

@immutable
enum LayingGalponState { active, finalized }
