import 'package:amca/domain/model/description.dart';
import 'package:amca/domain/model/product_or_service.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'cost_expense.freezed.dart';

part 'cost_expense.g.dart';

@unfreezed
class CostAndExpense with _$CostAndExpense {
  factory CostAndExpense({
    required String uidOwner,
    String? farmingName,
    String? partName,
    required String transitoryFarmingId,
    required DateTime createDate,
    required String productOrService,
    required Description description,
    required String costOrExpense,
    required String type,
    required String quantity,
    required String price,
    required String comment,
    String? id,
    @Default(false) bool? isAdmin,
  }) = _CostAndExpense;

  factory CostAndExpense.fromJson(Map<String, Object?> json) =>
      _$CostAndExpenseFromJson(json);
}
