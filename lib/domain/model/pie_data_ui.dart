/// {@category Domain}
/// This file contains the definition of the PieDataUI class.
/// The PieDataUI class represents data for displaying a pie chart segment.
/// It includes properties for the value, percentage in the pie, and whether it represents a cost or expense.
/// This class also provides methods to get the percentage as a formatted string and the color based on the type.

/// Imports of Bookstores and Resources
import 'package:amca/ui/utils/amca_palette.dart';
import 'package:flutter/material.dart';

/// Represents data for displaying a pie chart segment.
class PieDataUI {
  final double value;// Value of the segment.

  final double percentageInThePie;// Percentage of the segment in the pie.
  final bool? isCost;// Indicates whether the segment represents a cost or expense.

  /// Constructor for PieDataUI.
  /// Takes the value, percentage in the pie, and optional parameter isCost.
  PieDataUI({
    required this.value,
    this.isCost = false,
    required this.percentageInThePie,
  });

  /// Gets the percentage as a formatted string with two decimal places.
  String get percentage => '${percentageInThePie.toStringAsFixed(2)}%';

  /// Gets the color based on whether the segment represents a cost or expense.
  Color get color =>
      isCost! ? AmcaPalette.pieCostColor : AmcaPalette.pieExpenseColor;
}
