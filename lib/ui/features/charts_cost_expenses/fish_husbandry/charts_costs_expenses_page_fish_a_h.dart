/// {@category Features ChartCost}
/// Este archivo implementa el widget `ChartsCostsExpensesFishHusbandryPage` que muestra
/// gráficos de costos y gastos para el módulo de piscicultura.
library;

import 'package:amca/domain/model/bar_data_ui.dart'; //
import 'package:amca/domain/model/pie_data_ui.dart'; //
import 'package:amca/ui/features/charts_cost_expenses/fish_husbandry/charts_costs_expenses_vm_fish_a_h.dart'; //
import 'package:amca/ui/features/charts_cost_expenses/widgets/chart_card.dart'; //
import 'package:amca/ui/features/charts_cost_expenses/widgets/chart_card_vm.dart'; //
import 'package:amca/ui/features/charts_cost_expenses/widgets/pie_indicator.dart'; //
import 'package:amca/ui/utils/amca_palette.dart'; //
import 'package:amca/ui/utils/amca_words.dart'; //
import 'package:amca/ui/utils/extensions/string_extensions.dart'; //
import 'package:fl_chart/fl_chart.dart'; //
import 'package:flutter/material.dart'; //
import 'package:provider/provider.dart'; //

/// Widget para mostrar gráficos de costos y gastos de piscicultura.
class ChartsCostsExpensesFishHusbandryPage extends StatefulWidget {
  const ChartsCostsExpensesFishHusbandryPage._(
      {super.key, required this.fishHusbandryId});

  static ChangeNotifierProvider<ChartsCostExpensesVMFishHusbandry> create({
    Key? key,
    required String fishHusbandryId,
  }) =>
      ChangeNotifierProvider(
        lazy: false,
        create: (context) =>
            ChartsCostExpensesVMFishHusbandry()..init(fishHusbandryId),
        child: ChartsCostsExpensesFishHusbandryPage._(
          key: key,
          fishHusbandryId: fishHusbandryId,
        ),
      );

  final String fishHusbandryId;

  @override
  State<ChartsCostsExpensesFishHusbandryPage> createState() =>
      _ChartsCostsExpensesFishHusbandryPageState();
}

class _ChartsCostsExpensesFishHusbandryPageState
    extends State<ChartsCostsExpensesFishHusbandryPage> {
  int touchedIndex = -1;
  int touchedCostsIndex = -1;
  int touchedExpensesIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AmcaWords.chart),
        backgroundColor: AmcaPalette.lightGreen,
      ),
      body: Consumer<ChartsCostExpensesVMFishHusbandry>(
        builder: (BuildContext context, vm, Widget? child) {
          if (vm.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            padding: const EdgeInsets.only(bottom: 100),
            children: [
              ChartCard(
                title: '${AmcaWords.costsAndExpenses} ${AmcaWords.pieChart}',
                dateSelected: (piedDateSelected) {
                  vm.createPieChart(piedDateSelected);
                },
                child: StreamBuilder<List<PieDataUI>>(
                  stream: vm.pieData,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          Expanded(
                            child: PieChart(
                              PieChartData(
                                pieTouchData: PieTouchData(
                                  touchCallback:
                                      (FlTouchEvent event, pieTouchResponse) {
                                    setState(
                                      () {
                                        if (!event
                                                .isInterestedForInteractions ||
                                            pieTouchResponse == null ||
                                            pieTouchResponse.touchedSection ==
                                                null) {
                                          touchedIndex = -1;
                                          return;
                                        }
                                        touchedIndex = pieTouchResponse
                                            .touchedSection!
                                            .touchedSectionIndex;
                                      },
                                    );
                                  },
                                ),
                                borderData: FlBorderData(
                                  show: false,
                                ),
                                sectionsSpace: 0,
                                centerSpaceRadius: 40,
                                sections: showingSections(
                                  snapshot.data ?? [],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Indicator(
                                  color: AmcaPalette.pieCostColor,
                                  text:
                                      '${AmcaWords.totalCost}: \$${(snapshot.data?[0].value ?? 0).toInt().toString().formatNumberToColombianPesos()}',
                                  isSquare: true,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Indicator(
                                  color: AmcaPalette.pieExpenseColor,
                                  text:
                                      '${AmcaWords.totalExpense}: \$${(snapshot.data?[1].value ?? 0).toInt().toString().formatNumberToColombianPesos()}',
                                  isSquare: true,
                                ),
                              ],
                            ),
                          )
                        ],
                      );
                    }
                    if (snapshot.hasError) {
                      const Text('Error');
                    }
                    return Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AmcaWords.youDontHaveCostOrExpensesRegistered,
                            style: Theme.of(context).textTheme.bodyLarge,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 15),
                          Text(
                            AmcaWords.allYourCostOrExpenses,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              ChartCard(
                title: '${AmcaWords.costs} ${AmcaWords.barChart}',
                dateSelectedType: DateSelectedType.semester,
                dateSelected: (barCostDateSelected) {
                  vm.createBarChart(
                    barCostDateSelected,
                    ChartTypeData.costs,
                  );
                },
                child: StreamBuilder<List<BarDataUI>>(
                  stream: vm.barCostData,
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                      final dataList = snapshot.data!
                          .map((e) => _BarData(
                                AmcaPalette.pieCostColor,
                                e.totalCost ?? 0.0,
                                0,
                              ))
                          .toList();
                      final double maxValue = dataList
                          .map((barItem) => barItem.value)
                          .reduce((valor1, valor2) =>
                              valor1 > valor2 ? valor1 : valor2);
                      return Padding(
                        padding: const EdgeInsets.all(24),
                        child: AspectRatio(
                          aspectRatio: 1.4,
                          child: BarChart(
                            BarChartData(
                              alignment: BarChartAlignment.spaceBetween,
                              borderData: FlBorderData(
                                show: true,
                                border: Border.symmetric(
                                  horizontal: BorderSide(
                                    color: Colors.blue
                                        .withValues(alpha: (0.2 * 255)),
                                  ),
                                ),
                              ),
                              titlesData: FlTitlesData(
                                show: true,
                                leftTitles: AxisTitles(
                                  // drawBehindEverything: true,
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    reservedSize: 80,
                                    getTitlesWidget: (value, meta) {
                                      return Text(
                                        '\$${value.toInt().toString().formatNumberToColombianPesos()}',
                                        textAlign: TextAlign.left,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      );
                                    },
                                  ),
                                ),
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    reservedSize: 36,
                                    getTitlesWidget: (value, meta) {
                                      final index = value.toInt();
                                      final month =
                                          snapshot.data![index].monthName;
                                      return SideTitleWidget(
                                        meta: meta,
                                        // axisSide: meta.axisSide,
                                        child: Text(
                                          month,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                rightTitles: AxisTitles(),
                                topTitles: AxisTitles(),
                              ),
                              gridData: FlGridData(
                                show: true,
                                drawVerticalLine: false,
                                getDrawingHorizontalLine: (value) => FlLine(
                                  color: Colors.black
                                      .withValues(alpha: (0.2 * 255)),
                                  strokeWidth: 1,
                                ),
                              ),
                              barGroups: dataList.asMap().entries.map((e) {
                                final index = e.key;
                                final data = e.value;
                                return generateBarGroup(
                                  index,
                                  data.color,
                                  data.value,
                                  data.shadowValue,
                                  ChartTypeData.costs,
                                );
                              }).toList(),
                              maxY: maxValue,
                              barTouchData: BarTouchData(
                                enabled: true,
                                handleBuiltInTouches: false,
                                touchTooltipData: BarTouchTooltipData(
                                  // tooltipBgColor: Colors.transparent,
                                  tooltipMargin: 0,
                                  getTooltipItem: (
                                    BarChartGroupData group,
                                    int groupIndex,
                                    BarChartRodData rod,
                                    int rodIndex,
                                  ) {
                                    return BarTooltipItem(
                                      rod.toY.toString(),
                                      TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: rod.color,
                                        fontSize: 12,
                                        shadows: const [
                                          Shadow(
                                            color: Colors.black26,
                                            blurRadius: 12,
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                ),
                                touchCallback: (event, response) {
                                  if (event.isInterestedForInteractions &&
                                      response != null &&
                                      response.spot != null) {
                                    setState(() {
                                      touchedCostsIndex =
                                          response.spot!.touchedBarGroupIndex;
                                    });
                                  } else {
                                    setState(() {
                                      touchedCostsIndex = -1;
                                    });
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      );
                    }

                    if (snapshot.hasError) {
                      const Text('Error');
                    }

                    return Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AmcaWords.youDontHaveCostOrExpensesRegistered,
                            style: Theme.of(context).textTheme.bodyLarge,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 15),
                          Text(
                            AmcaWords.allYourCostOrExpenses,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              ChartCard(
                title: '${AmcaWords.expense} ${AmcaWords.barChart}',
                dateSelectedType: DateSelectedType.semester,
                dateSelected: (barCostDateSelected) {
                  vm.createBarChart(
                    barCostDateSelected,
                    ChartTypeData.expenses,
                  );
                },
                child: StreamBuilder<List<BarDataUI>>(
                  stream: vm.barExpenseData,
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                      final dataList = snapshot.data!
                          .map((e) => _BarData(
                                AmcaPalette.pieCostColor,
                                e.totalCost ?? 0.0,
                                0,
                              ))
                          .toList();
                      final double maxValue = dataList
                          .map((barItem) => barItem.value)
                          .reduce((valor1, valor2) =>
                              valor1 > valor2 ? valor1 : valor2);
                      return Padding(
                        padding: const EdgeInsets.all(24),
                        child: AspectRatio(
                          aspectRatio: 1.4,
                          child: BarChart(
                            BarChartData(
                              alignment: BarChartAlignment.spaceBetween,
                              borderData: FlBorderData(
                                show: true,
                                border: Border.symmetric(
                                  horizontal: BorderSide(
                                    color: Colors.blue
                                        .withValues(alpha: (0.2 * 255)),
                                  ),
                                ),
                              ),
                              titlesData: FlTitlesData(
                                show: true,
                                leftTitles: AxisTitles(
                                  // drawBehindEverything: true,
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    reservedSize: 80,
                                    getTitlesWidget: (value, meta) {
                                      return Text(
                                        '\$${value.toInt().toString().formatNumberToColombianPesos()}',
                                        textAlign: TextAlign.left,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      );
                                    },
                                  ),
                                ),
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    reservedSize: 36,
                                    getTitlesWidget: (value, meta) {
                                      final index = value.toInt();
                                      final month =
                                          snapshot.data![index].monthName;
                                      return SideTitleWidget(
                                        meta: meta,
                                        // axisSide: meta.axisSide,
                                        child: Text(
                                          month,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                rightTitles: AxisTitles(),
                                topTitles: AxisTitles(),
                              ),
                              gridData: FlGridData(
                                show: true,
                                drawVerticalLine: false,
                                getDrawingHorizontalLine: (value) => FlLine(
                                  color: Colors.black
                                      .withValues(alpha: (0.2 * 255)),
                                  strokeWidth: 1,
                                ),
                              ),
                              barGroups: dataList.asMap().entries.map((e) {
                                final index = e.key;
                                final data = e.value;
                                return generateBarGroup(
                                  index,
                                  data.color,
                                  data.value,
                                  data.shadowValue,
                                  ChartTypeData.expenses,
                                );
                              }).toList(),
                              maxY: maxValue,
                              barTouchData: BarTouchData(
                                enabled: true,
                                handleBuiltInTouches: false,
                                touchTooltipData: BarTouchTooltipData(
                                  // tooltipBgColor: Colors.transparent,
                                  tooltipMargin: 0,
                                  getTooltipItem: (
                                    BarChartGroupData group,
                                    int groupIndex,
                                    BarChartRodData rod,
                                    int rodIndex,
                                  ) {
                                    return BarTooltipItem(
                                      rod.toY.toString(),
                                      TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: rod.color,
                                        fontSize: 12,
                                        shadows: const [
                                          Shadow(
                                            color: Colors.black26,
                                            blurRadius: 12,
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                ),
                                touchCallback: (event, response) {
                                  if (event.isInterestedForInteractions &&
                                      response != null &&
                                      response.spot != null) {
                                    setState(() {
                                      touchedExpensesIndex =
                                          response.spot!.touchedBarGroupIndex;
                                    });
                                  } else {
                                    setState(() {
                                      touchedExpensesIndex = -1;
                                    });
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      );
                    }

                    if (snapshot.hasError) {
                      const Text('Error');
                    }

                    return Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AmcaWords.youDontHaveCostOrExpensesRegistered,
                            style: Theme.of(context).textTheme.bodyLarge,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 15),
                          Text(
                            AmcaWords.allYourCostOrExpenses,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  List<PieChartSectionData> showingSections(List<PieDataUI> pieData) {
    return List.generate(
      pieData.length,
      (i) {
        final isTouched = i == touchedIndex;
        final fontSize = isTouched ? 20.0 : 12.0;
        final radius = isTouched ? 60.0 : 50.0;
        const shadows = [Shadow(color: Colors.black, blurRadius: 3)];
        final pieItem = pieData[i];
        return PieChartSectionData(
          color: pieItem.color,
          value: pieItem.value,
          title: pieItem.percentage,
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: shadows,
          ),
        );
      },
    );
  }

  BarChartGroupData generateBarGroup(
    int x,
    Color color,
    double value,
    double shadowValue,
    ChartTypeData typeData,
  ) {
    final touchIndex =
        typeData.isCost ? touchedCostsIndex : touchedExpensesIndex;
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: value,
          color: color,
          width: 6,
        ),
        BarChartRodData(
          toY: shadowValue,
          color: Colors.transparent,
          width: 6,
        ),
      ],
      showingTooltipIndicators: touchIndex == x ? [0] : [],
    );
  }
}

class _BarData {
  const _BarData(this.color, this.value, this.shadowValue);

  final Color color;
  final double value;
  final double shadowValue;
}
