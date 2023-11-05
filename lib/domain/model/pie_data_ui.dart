import 'package:amca/domain/model/cost_expense.dart';

class PieDataUI {
  final int year;
  final List<PieDataMonth>? monthsData;

  PieDataUI({
    required this.year,
    this.monthsData,
  });
}

class PieDataMonth {
  final int? month;
  final List<CostAndExpense>? costAndExpense;

  PieDataMonth({
    this.month,
    this.costAndExpense,
  });
}
