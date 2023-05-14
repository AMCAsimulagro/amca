import 'package:amca/domain/model/cost_expense.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

part 'transitory_farming.freezed.dart';

part 'transitory_farming.g.dart';

@freezed
class TransitoryFarming with _$TransitoryFarming {
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
    @Default([]) List<CostAndExpense>? costsAndExpenses,
  }) = _TransitoryFarming;

  factory TransitoryFarming.fromJson(Map<String, Object?> json) =>
      _$TransitoryFarmingFromJson(json);

  factory TransitoryFarming.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return TransitoryFarming(
      createDate: DateFormat('yyyy-MM-dd').parse(data?['created']),
      partName: data?['partName'],
      cropType: data?['cropType'],
      crop: data?['crop'],
      sownArea: data?['sownArea'],
      sownType: data?['sownType'],
      format: data?['format'],
      amountSown: data?['amountSown'],
      value: data?['value'],
      uidOwner: data?['uidOwner'],
      comment: data?['comment'],
      costsAndExpenses: data?['costsAndExpenses'],
    );
  }
}
