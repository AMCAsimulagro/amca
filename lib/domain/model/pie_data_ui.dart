import 'package:amca/ui/utils/amca_palette.dart';
import 'package:flutter/material.dart';

class PieDataUI {
  final double value;

  final double percentageInThePie;
  final bool? isCost;

  PieDataUI({
    required this.value,
    this.isCost = false,
    required this.percentageInThePie,
  });

  String get percentage => '${percentageInThePie.toStringAsFixed(2)}%';

  Color get color =>
      isCost! ? AmcaPalette.pieCostColor : AmcaPalette.pieExpenseColor;
}
