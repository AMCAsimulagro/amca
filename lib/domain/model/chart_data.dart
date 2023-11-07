import 'package:amca/domain/model/cost_expense.dart';

class ChartDataYear {
  final int year;
  final List<ChartDataMonth>? monthsData;

  ChartDataYear({
    required this.year,
    this.monthsData,
  });
}

class ChartDataMonth {
  final int? month;
  final List<CostAndExpense>? costAndExpense;

  ChartDataMonth({
    this.month,
    this.costAndExpense,
  });

  List<CostAndExpense> get costs =>
      costAndExpense?.where((element) => element.isCost).toList() ?? [];

  List<CostAndExpense> get expenses =>
      costAndExpense?.where((element) => !element.isCost).toList() ?? [];

  double get totalCost => costs.isNotEmpty
      ? costs
          .map((cost) => cost.priceDouble)
          .reduce((valorAnterior, valorActual) => valorAnterior + valorActual)
      : 0.0;

  double get totalExpense => expenses.isNotEmpty
      ? expenses
          .map((cost) => cost.priceDouble)
          .reduce((valorAnterior, valorActual) => valorAnterior + valorActual)
      : 0.0;
}
