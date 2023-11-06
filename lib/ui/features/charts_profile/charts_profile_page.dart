import 'package:amca/domain/model/pie_data_ui.dart';
import 'package:amca/ui/features/charts_profile/charts_profile_vm.dart';
import 'package:amca/ui/features/charts_profile/widgets/chart_card.dart';
import 'package:amca/ui/features/charts_profile/widgets/pie_indicator.dart';
import 'package:amca/ui/utils/amca_palette.dart';
import 'package:amca/ui/utils/amca_words.dart';
import 'package:amca/ui/utils/extensions/string_extensions.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ChartsProfilePage extends StatefulWidget {
  const ChartsProfilePage._({super.key, required this.transitoryFarmingId});

  static ChangeNotifierProvider<ChartsProfileVM> create({
    Key? key,
    required String transitoryFarmingId,
  }) =>
      ChangeNotifierProvider(
        lazy: false,
        create: (context) => ChartsProfileVM()..init(transitoryFarmingId),
        child: ChartsProfilePage._(
          key: key,
          transitoryFarmingId: transitoryFarmingId,
        ),
      );

  final String transitoryFarmingId;

  @override
  State<ChartsProfilePage> createState() => _ChartsProfilePageState();
}

class _ChartsProfilePageState extends State<ChartsProfilePage> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AmcaWords.chart),
        backgroundColor: AmcaPalette.lightGreen,
      ),
      body: Consumer<ChartsProfileVM>(
        builder: (BuildContext context, vm, Widget? child) {
          if (vm.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            children: [
              ChartCard(
                title: '${AmcaWords.costsAndExpenses} ${AmcaWords.pieChart}',
                dateSelected: (dateSelected) {
                  vm.createPieChart(dateSelected);
                },
                child: StreamBuilder<List<PieDataUI>>(
                  stream: vm.pieDataStream.stream,
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
                      margin: const EdgeInsets.symmetric(horizontal: 24,vertical: 15),
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
}
