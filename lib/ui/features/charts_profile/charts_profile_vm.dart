import 'dart:async';

import 'package:amca/data/repository/farming_repository.dart';
import 'package:amca/dependecy_injection.dart';
import 'package:amca/domain/model/cost_expense.dart';
import 'package:amca/domain/model/pie_data.dart';
import 'package:amca/domain/model/pie_data_ui.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:jiffy/jiffy.dart';

class ChartsProfileVM extends ChangeNotifier {
  final FarmingRepository farmingRepository = locator<FarmingRepository>();
  List<PieChartSectionData> pieData = [];

  List<PieDataYear> pieDataUI = [];

  final StreamController<List<PieDataUI>> pieDataStream =
      StreamController<List<PieDataUI>>();
  bool isLoading = true;

  Future<void> init(String transitoryFarmingId) async {
    isLoading = true;
    final costAndExpenses = await farmingRepository
        .getCostsAndExpensesByFarming(transitoryFarmingId);

    if (costAndExpenses.isNotEmpty) {
      generatePieData(costAndExpenses);
      createPieChart(Jiffy.now());
    }
    isLoading = false;
    notifyListeners();
  }

  void generatePieData(List<CostAndExpense> costAndExpenses) {
    for (var costExpense in costAndExpenses) {
      int year = costExpense.year;
      int month = costExpense.month;

      PieDataYear existingPieData = pieDataUI.firstWhere(
        (pieData) => pieData.year == year,
        orElse: () {
          var newPieData = PieDataYear(
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

  void createPieChart(Jiffy dateSelected) {
    try {
      final pieDataByYear =
          pieDataUI.firstWhere((element) => element.year == dateSelected.year);
      final pieMonthSelected = pieDataByYear.monthsData
          ?.firstWhere((element) => element.month == dateSelected.month);
      if (pieMonthSelected != null) {
        final totalCost = pieMonthSelected.totalCost;
        final totalExpense = pieMonthSelected.totalExpense;
        final total = totalCost + totalExpense;
        final PieDataUI pieDataUICost = PieDataUI(
          value: totalCost,
          isCost: true,
          percentageInThePie: (totalCost * 100) / total,
        );
        final PieDataUI pieDataUIExpenses = PieDataUI(
          value: totalExpense,
          isCost: false,
          percentageInThePie: (totalExpense * 100) / total,
        );
        pieDataStream.add([
          pieDataUICost,
          pieDataUIExpenses,
        ]);
      }
    } catch (_) {
      pieDataStream.addError(Exception());
    }
  }

  @override
  void dispose() {
    pieDataStream.close();
    super.dispose();
  }
}
