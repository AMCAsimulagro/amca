import 'package:amca/ui/features/charts_profile/charts_profile_vm.dart';
import 'package:amca/ui/features/charts_profile/widgets/chart_card.dart';
import 'package:amca/ui/utils/amca_palette.dart';
import 'package:amca/ui/utils/amca_words.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
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
      body: Column(
        children: [
          ChartCard(
            title: 'Costos y gastos',
            child: PieChart(
              PieChartData(
                pieTouchData: PieTouchData(
                  touchCallback: (FlTouchEvent event, pieTouchResponse) {
                    setState(() {
                      if (!event.isInterestedForInteractions ||
                          pieTouchResponse == null ||
                          pieTouchResponse.touchedSection == null) {
                        touchedIndex = -1;
                        return;
                      }
                      touchedIndex = pieTouchResponse
                          .touchedSection!.touchedSectionIndex;
                    });
                  },
                ),
                borderData: FlBorderData(
                  show: false,
                ),
                sectionsSpace: 0,
                centerSpaceRadius: 40,
                sections: showingSections(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(
      4,
      (i) {
        final isTouched = i == touchedIndex;
        final fontSize = isTouched ? 25.0 : 16.0;
        final radius = isTouched ? 60.0 : 50.0;
        const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
        switch (i) {
          case 0:
            return PieChartSectionData(
              color: Colors.blue,
              value: 40,
              title: '40%',
              radius: radius,
              titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                shadows: shadows,
              ),
            );
          case 1:
            return PieChartSectionData(
              color: Colors.yellow,
              value: 30,
              title: '30%',
              radius: radius,
              titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                shadows: shadows,
              ),
            );
          case 2:
            return PieChartSectionData(
              color: Colors.purple,
              value: 15,
              title: '15%',
              radius: radius,
              titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                shadows: shadows,
              ),
            );
          case 3:
            return PieChartSectionData(
              color: Colors.green,
              value: 15,
              title: '15%',
              radius: radius,
              titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                shadows: shadows,
              ),
            );
          default:
            throw Error();
        }
      },
    );
  }
}
