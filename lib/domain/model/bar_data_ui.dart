import 'package:amca/domain/model/chart_data.dart';

class BarDataUI {
  final int month;

  double? totalCost;

  BarDataUI({
    required this.month,
    this.totalCost,
  });

  String get monthName {
    final months = {
      1: 'Ene',
      2: 'Feb',
      3: 'Mar',
      4: 'Abr',
      5: 'May',
      6: 'Jun',
      7: 'Jul',
      8: 'Ago',
      9: 'Sep',
      10: 'Oct',
      11: 'Nov',
      12: 'Dic'
    };
    return months[month] ?? '';
  }
}
