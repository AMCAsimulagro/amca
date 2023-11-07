import 'dart:async';

import 'package:amca/data/repository/farming_repository.dart';
import 'package:amca/dependecy_injection.dart';
import 'package:amca/domain/model/bar_data_ui.dart';
import 'package:amca/domain/model/cost_expense.dart';
import 'package:amca/domain/model/chart_data.dart';
import 'package:amca/domain/model/pie_data_ui.dart';
import 'package:amca/ui/utils/extensions/jiffy_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:jiffy/jiffy.dart';

enum ChartTypeData {
  costs,
  expenses,
}

extension ChartTypeUtils on ChartTypeData {
  bool get isCost => this == ChartTypeData.costs;
}

class ChartsProfileVM extends ChangeNotifier {
  final FarmingRepository farmingRepository = locator<FarmingRepository>();
  List<ChartDataYear> chartDataUI = [];

  final StreamController<List<PieDataUI>> pieDataStream =
      StreamController<List<PieDataUI>>();

  final StreamController<List<BarDataUI>> barCostDataStream =
      StreamController<List<BarDataUI>>();

  final StreamController<List<BarDataUI>> barExpenseDataStream =
      StreamController<List<BarDataUI>>();
  bool isLoading = true;

  final Map<String, List<ChartDataMonth>> cacheSemesterData = {};

  Future<void> init(String transitoryFarmingId) async {
    isLoading = true;
    final costAndExpenses = await farmingRepository
        .getCostsAndExpensesByFarming(transitoryFarmingId);

    if (costAndExpenses.isNotEmpty) {
      final currentDate = Jiffy.now();
      generateChartData(costAndExpenses);
      createPieChart(currentDate);
      createBarChart(
        currentDate.dateBySemester(),
        ChartTypeData.costs,
      );
      createBarChart(
        currentDate.dateBySemester(),
        ChartTypeData.expenses,
      );
    }
    isLoading = false;
    notifyListeners();
  }

  void generateChartData(List<CostAndExpense> costAndExpenses) {
    for (var costExpense in costAndExpenses) {
      int year = costExpense.year;
      int month = costExpense.month;

      ChartDataYear existingPieData = chartDataUI.firstWhere(
        (pieData) => pieData.year == year,
        orElse: () {
          var newPieData = ChartDataYear(
            year: year,
            monthsData: [],
          );
          chartDataUI.add(newPieData);
          return newPieData;
        },
      );

      ChartDataMonth? existingMesData = existingPieData.monthsData?.firstWhere(
        (mesData) => mesData.month == month,
        orElse: () {
          var newMesData = ChartDataMonth(
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
      final pieDataByYear = chartDataUI
          .firstWhere((element) => element.year == dateSelected.year);
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

  void createBarChart(
    Jiffy dateSelected,
    ChartTypeData chartTypeData,
  ) {
    try {
      final cacheSemesterKey = '${dateSelected.semester}-${dateSelected.year}';
      late List<ChartDataMonth> barSemesterDataSelected;

      if (cacheSemesterData.containsKey(cacheSemesterKey)) {
        barSemesterDataSelected = cacheSemesterData[cacheSemesterKey]!;
      } else {
        barSemesterDataSelected = _getBarSemesterDateSelected(dateSelected);
        cacheSemesterData[cacheSemesterKey] = barSemesterDataSelected;
      }

      var dataUI = _getBarDataBySemester(
        dateSelected,
        barSemesterDataSelected,
        chartTypeData,
      );
      dataUI = dataUI.reversed.toList();

      if (chartTypeData.isCost) {
        barCostDataStream.add(dataUI);
      } else {
        barExpenseDataStream.add(dataUI);
      }
    } catch (_) {
      if (chartTypeData.isCost) {
        barCostDataStream.addError(Exception());
      } else {
        barExpenseDataStream.addError(Exception());
      }
    }
  }

  List<ChartDataMonth> _getBarSemesterDateSelected(Jiffy dateSelected) {
    final barDataByYear =
        chartDataUI.firstWhere((element) => element.year == dateSelected.year);
    final List<ChartDataMonth> barSemesterDataSelected = [];

    barDataByYear.monthsData?.forEach((element) {
      if (dateSelected.isFirstSemester && element.month! < 7) {
        barSemesterDataSelected.add(element);
      }
      if (dateSelected.isSecondSemester && element.month! >= 7) {
        barSemesterDataSelected.add(element);
      }
    });
    return barSemesterDataSelected;
  }

  List<BarDataUI> _getBarDataBySemester(
    Jiffy dateSelected,
    List<ChartDataMonth> barSemesterDataSelected,
    ChartTypeData chartTypeData,
  ) {
    final List<BarDataUI> dataList = [];
    var index = dateSelected.isFirstSemester ? 1 : 7;
    final limit = dateSelected.isFirstSemester ? 7 : 12;
    for (index; index <= limit; index++) {
      dataList.add(BarDataUI(month: index));
    }
    for (var dataItem in dataList) {
      for (var monthBySemester in barSemesterDataSelected) {
        if (dataItem.month == monthBySemester.month) {
          dataItem.totalCost = _getTotalCost(chartTypeData, monthBySemester);
        }
      }
    }
    return dataList;
  }

  double _getTotalCost(
      ChartTypeData chartTypeData, ChartDataMonth monthBySemester) {
    return (chartTypeData.isCost)
        ? monthBySemester.totalCost
        : monthBySemester.totalExpense;
  }

  @override
  void dispose() {
    pieDataStream.close();
    barCostDataStream.close();
    barExpenseDataStream.close();
    super.dispose();
  }
}
