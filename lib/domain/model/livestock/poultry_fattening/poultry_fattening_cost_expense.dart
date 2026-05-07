/// {@category Domain}
/// Model for poultry fattening cost/expense records.
library;

import 'package:cloud_firestore/cloud_firestore.dart';

class PoultryFatteningCostExpense {
  final String? id;
  final DateTime recordDate;
  final String productOrService;
  final String description;
  final String costOrExpense;
  final String type;
  final String quantity;
  final String price;
  final String? comment;

  const PoultryFatteningCostExpense({
    this.id,
    required this.recordDate,
    required this.productOrService,
    required this.description,
    required this.costOrExpense,
    required this.type,
    required this.quantity,
    required this.price,
    this.comment,
  });

  factory PoultryFatteningCostExpense.fromJson(Map<String, dynamic> json) {
    return PoultryFatteningCostExpense(
      id: json['id'] as String?,
      recordDate: _parseDate(json['recordDate']),
      productOrService: (json['productOrService'] ?? '') as String,
      description: (json['description'] ?? '') as String,
      costOrExpense: (json['costOrExpense'] ?? '') as String,
      type: (json['type'] ?? '') as String,
      quantity: (json['quantity'] ?? '') as String,
      price: (json['price'] ?? '') as String,
      comment: json['comment'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'recordDate': Timestamp.fromDate(recordDate),
        'productOrService': productOrService,
        'description': description,
        'costOrExpense': costOrExpense,
        'type': type,
        'quantity': quantity,
        'price': price,
        'comment': comment,
      };

  PoultryFatteningCostExpense copyWith({
    String? id,
    DateTime? recordDate,
    String? productOrService,
    String? description,
    String? costOrExpense,
    String? type,
    String? quantity,
    String? price,
    String? comment,
  }) {
    return PoultryFatteningCostExpense(
      id: id ?? this.id,
      recordDate: recordDate ?? this.recordDate,
      productOrService: productOrService ?? this.productOrService,
      description: description ?? this.description,
      costOrExpense: costOrExpense ?? this.costOrExpense,
      type: type ?? this.type,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      comment: comment ?? this.comment,
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
