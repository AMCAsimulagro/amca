import 'package:amca/domain/model/cost_expense.dart';
import 'package:amca/domain/model/production.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'transitory_farming.freezed.dart';

part 'transitory_farming.g.dart';

@unfreezed
class TransitoryFarming with _$TransitoryFarming {
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
    return totalCostAndExpense;
  }
}
