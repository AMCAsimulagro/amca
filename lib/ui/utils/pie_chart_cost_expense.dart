import 'package:amca/ui/utils/amca_words.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PieChartCostVsGasto extends StatelessWidget {
  const PieChartCostVsGasto({
    super.key,
    required this.costs,
    required this.expense,
  });

  final double costs;
  final double expense;

  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
        sections: [
          PieChartSectionData(
            value: costs,
            title: AmcaWords.costs,
            color: Colors.green.shade900,
          ),
          PieChartSectionData(
            value: expense,
            title: AmcaWords.expense,
            color: Colors.red.shade700,
          ),
        ],
      ),
    );
  }
}
