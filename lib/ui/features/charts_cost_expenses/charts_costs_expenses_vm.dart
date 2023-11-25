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
import 'package:rxdart/rxdart.dart';

enum ChartTypeData {
  costs,
  expenses,
}

extension ChartTypeUtils on ChartTypeData {
  bool get isCost => this == ChartTypeData.costs;

  bool get isExpenses => this == ChartTypeData.expenses;
}

class ChartsProfileVM extends ChangeNotifier {
  final FarmingRepository farmingRepository = locator<FarmingRepository>();
  List<ChartDataYear> chartDataUI = [];

  final pieDataSubject = BehaviorSubject<List<PieDataUI>>();

  ValueStream<List<PieDataUI>> get pieData => pieDataSubject.stream;

  final barCostDataSubject= BehaviorSubject<List<BarDataUI>>();

  ValueStream<List<BarDataUI>> get barCostData => barCostDataSubject.stream;

  final barExpenseDataSubject = BehaviorSubject<List<BarDataUI>>();

  ValueStream<List<BarDataUI>> get barExpenseData => barExpenseDataSubject.stream;


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
        final totalCost = pieMonthSelected.totalCost ?? 0.0;
        final totalExpense = pieMonthSelected.totalExpense ?? 0.0;
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
        pieDataSubject.add([
          pieDataUICost,
          pieDataUIExpenses,
        ]);
      }
    } catch (_) {
      pieDataSubject.addError(Exception());
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
      if (barSemesterDataSelected.isNotEmpty) {
        var dataUI = _getBarDataBySemester(
          dateSelected,
          barSemesterDataSelected,
          chartTypeData,
        );
        bool hasData = false;

        for (var element in barSemesterDataSelected) {
          if (chartTypeData.isCost && element.hasCosts) {
            hasData = true;
            break;
          }
          if (chartTypeData.isExpenses && element.hasExpenses) {
            hasData = true;
            break;
          }
        }

        if (chartTypeData.isCost) {
          barCostDataSubject.add(hasData ? dataUI : []);
        }
        if (chartTypeData.isExpenses) {
          barExpenseDataSubject.add(hasData ? dataUI : []);
        }
      } else {
        if (chartTypeData.isCost) {
          barCostDataSubject.add([]);
        } else {
          barExpenseDataSubject.add([]);
        }
      }
    } catch (_) {
      if (chartTypeData.isCost) {
        barCostDataSubject.addError(Exception());
      } else {
        barExpenseDataSubject.addError(Exception());
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
    final limit = dateSelected.isFirstSemester ? 6 : 12;
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

  double? _getTotalCost(
      ChartTypeData chartTypeData, ChartDataMonth monthBySemester) {
    return (chartTypeData.isCost)
        ? monthBySemester.totalCost
        : monthBySemester.totalExpense;
  }

  @override
  void dispose() {
    pieDataSubject.close();
    barCostDataSubject.close();
    barExpenseDataSubject.close();
    super.dispose();
  }
}
