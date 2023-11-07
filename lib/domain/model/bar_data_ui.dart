import 'package:amca/domain/model/chart_data.dart';

class BarDataUI {
  final int month;

  double? totalCost;

  BarDataUI({
    required this.month,
    this.totalCost,
  });
}
