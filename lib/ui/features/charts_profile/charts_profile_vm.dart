import 'package:amca/data/repository/farming_repository.dart';
import 'package:amca/dependecy_injection.dart';
import 'package:amca/domain/model/cost_expense.dart';
import 'package:amca/domain/model/pie_data_ui.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';

class ChartsProfileVM extends ChangeNotifier {
  final FarmingRepository farmingRepository = locator<FarmingRepository>();
  List<PieChartSectionData> pieData = [];

  List<PieDataUI> pieDataUI = [];

  Future<void> init(String transitoryFarmingId) async {
    final costAndExpenses = await farmingRepository
        .getCostsAndExpensesByFarming(transitoryFarmingId);

    if (costAndExpenses.isNotEmpty) {
      generatePieData(costAndExpenses);
    }
  }

  void generatePieData(List<CostAndExpense> costAndExpenses) {
    for (var costExpense in costAndExpenses) {
      int year = costExpense.year;
      int month = costExpense.month;

      PieDataUI existingPieData = pieDataUI.firstWhere(
        (pieData) => pieData.year == year,
        orElse: () {
          var newPieData = PieDataUI(
            year: year,
            monthsData: [],
          );
          pieDataUI.add(newPieData);
          return newPieData;
        },
      );

      PieDataMonth? existingMesData = existingPieData.monthsData?.firstWhere(
        (mesData) => mesData.month == month,
        orElse: () {
          var newMesData = PieDataMonth(
            month: month,
            costAndExpense: [],
          );
          existingPieData.monthsData?.add(newMesData);
          return newMesData;
        },
      );

      existingMesData?.costAndExpense?.add(costExpense);
    }
  }
}
