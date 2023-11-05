import 'package:amca/domain/model/description.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'cost_expense.freezed.dart';

part 'cost_expense.g.dart';

@unfreezed
class CostAndExpense with _$CostAndExpense {
  factory CostAndExpense({
    String? uidOwner,
    String? partName,
    required String transitoryFarmingId,
    required DateTime createDate,
    required String productOrService,
    required Description description,
    required String quantity,
    required String price,
    required String comment,
    String? id,
  }) = _CostAndExpense;

  factory CostAndExpense.fromJson(Map<String, Object?> json) =>
      _$CostAndExpenseFromJson(json);
}

extension CostAndExpenseExtension on CostAndExpense {
  bool get isCost => description.costOrExpense == 'Costos';

  int get year => createDate.year;

  int get month => createDate.month;
}
