/// {@category Features ChartCost}
/// Este archivo contiene la definición de la clase `ChartsCostExpensesVMFishHusbandry`, que sirve como ViewModel
/// para administrar datos de gráficos de costos y gastos en piscicultura.
library;

import 'dart:async';

import 'package:amca/data/repository/livestock/fish_husbandry_repository.dart';
import 'package:amca/dependecy_injection.dart';
import 'package:amca/domain/model/bar_data_ui.dart';
import 'package:amca/domain/model/chart_data.dart';
import 'package:amca/domain/model/cost_expense.dart';
import 'package:amca/domain/model/pie_data_ui.dart';
import 'package:amca/ui/utils/extensions/jiffy_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:jiffy/jiffy.dart';
import 'package:rxdart/rxdart.dart';

/// Tipo de datos para el gráfico
enum ChartTypeData {
  costs,
  expenses,
}

/// Extensión de utilidades para ChartTypeData
extension ChartTypeUtils on ChartTypeData {
  bool get isCost => this == ChartTypeData.costs;
  bool get isExpenses => this == ChartTypeData.expenses;
}

/// ViewModel para gestionar los datos de gráficos de costos y gastos en piscicultura.
class ChartsCostExpensesVMFishHusbandry extends ChangeNotifier {
  final FishHusbandryRepository fishHusbandryRepository =
      locator<FishHusbandryRepository>();
  List<ChartDataYear> chartDataUI = [];

  final pieDataSubject = BehaviorSubject<List<PieDataUI>>();
  ValueStream<List<PieDataUI>> get pieData => pieDataSubject.stream;

  final barCostDataSubject = BehaviorSubject<List<BarDataUI>>();
  ValueStream<List<BarDataUI>> get barCostData => barCostDataSubject.stream;

  final barExpenseDataSubject = BehaviorSubject<List<BarDataUI>>();
  ValueStream<List<BarDataUI>> get barExpenseData =>
      barExpenseDataSubject.stream;

  bool isLoading = true;
  final Map<String, List<ChartDataMonth>> cacheSemesterData = {};

  /// Inicializa el ViewModel con los datos del registro de piscicultura especificado.
  Future<void> init(String fishHusbandryId) async {
    try {
      isLoading = true;
      final costAndExpenses = await fishHusbandryRepository
          .getCostsAndExpensesByFish(fishHusbandryId);

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
    } catch (e) {
      // Aquí podrías implementar un manejo más específico del error
      debugPrint('Error al inicializar los datos: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// Genera los datos para los gráficos a partir de la lista de costos y gastos.
  ///
  /// Organiza los datos por año y mes para facilitar la creación de gráficos.
  void generateChartData(List<CostAndExpense> costAndExpenses) {
    try {
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

        ChartDataMonth? existingMesData =
            existingPieData.monthsData?.firstWhere(
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
    } catch (e) {
      debugPrint('Error al generar datos del gráfico: $e');
    }
  }

  /// Crea el gráfico circular para la fecha seleccionada.
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

        pieDataSubject.add([pieDataUICost, pieDataUIExpenses]);
      }
    } catch (e) {
      debugPrint('Error al crear gráfico circular: $e');
      pieDataSubject.addError(e);
    }
  }

  /// Crea el gráfico de barras para el período y tipo de datos especificados.
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

        bool hasData = barSemesterDataSelected.any((element) =>
            chartTypeData.isCost ? element.hasCosts : element.hasExpenses);

        _updateBarDataStream(chartTypeData, hasData ? dataUI : []);
      } else {
        _updateBarDataStream(chartTypeData, []);
      }
    } catch (e) {
      debugPrint('Error al crear gráfico de barras: $e');
      _handleBarChartError(chartTypeData, e);
    }
  }

  /// Actualiza el stream de datos del gráfico de barras según el tipo.
  void _updateBarDataStream(ChartTypeData type, List<BarDataUI> data) {
    if (type.isCost) {
      barCostDataSubject.add(data);
    } else {
      barExpenseDataSubject.add(data);
    }
  }

  /// Maneja errores en la creación del gráfico de barras.
  void _handleBarChartError(ChartTypeData type, dynamic error) {
    if (type.isCost) {
      barCostDataSubject.addError(error);
    } else {
      barExpenseDataSubject.addError(error);
    }
  }

  /// Obtiene los datos del semestre seleccionado.
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

  /// Obtiene los datos de barras por semestre.
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

  /// Obtiene el total de costo o gasto según el tipo de datos.
  double? _getTotalCost(
      ChartTypeData chartTypeData, ChartDataMonth monthBySemester) {
    return chartTypeData.isCost
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
