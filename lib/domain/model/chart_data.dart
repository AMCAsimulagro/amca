/// {@category Domain}
// This file defines classes related to chart data representation, including monthly and yearly data.

/// Imports of Bookstores and Resources
library;
import 'package:amca/domain/model/cost_expense.dart';

// This class represents data for a specific year in a chart, containing information about
// monthly cost and expense data.
class ChartDataYear {
  final int year;// Represents the year.
  final List<ChartDataMonth>? monthsData;// Contains monthly data for the year.

  /// Constructs a [ChartDataYear] object with the given [year] and optional [monthsData].
  ChartDataYear({
    required this.year,
    this.monthsData,
  });
}

// This class represents data for a specific month in a chart, containing information about
// costs and expenses.
class ChartDataMonth {
  final int? month;// Represents the month number.
  final List<CostAndExpense>? costAndExpense;// Contains cost and expense data for the month.

  /// Constructs a [ChartDataMonth] object with the given [month] and optional [costAndExpense].
  ChartDataMonth({
    this.month,
    this.costAndExpense,
  });

  // Returns a list of costs from the [costAndExpense] list.
  List<CostAndExpense> get costs =>
      costAndExpense?.where((element) => element.isCost).toList() ?? [];

  // Returns a list of expenses from the [costAndExpense] list.
  List<CostAndExpense> get expenses =>
      costAndExpense?.where((element) => !element.isCost).toList() ?? [];

  // Checks if there are any costs in the [costAndExpense] list.
  bool get hasCosts => costs.isNotEmpty;

  // Checks if there are any expenses in the [costAndExpense] list.
  bool get hasExpenses => expenses.isNotEmpty;

  // Calculates the total cost for the month.
  double? get totalCost => costs.isNotEmpty
      ? costs
          .map((cost) => cost.priceDouble)
          .reduce((valorAnterior, valorActual) => valorAnterior + valorActual)
      : null;

  // Calculates the total expense for the month.
  double? get totalExpense => expenses.isNotEmpty
      ? expenses
          .map((cost) => cost.priceDouble)
          .reduce((valorAnterior, valorActual) => valorAnterior + valorActual)
      : null;
}
