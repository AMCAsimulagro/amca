/// {@category Features ChartCost Widgets }
/// This file contains a view model class `ChartCardVM` used for managing date selection and formatting
/// in a chart card widget.

/// Imports of Bookstores and Resources
import 'package:amca/ui/utils/amca_words.dart';
import 'package:amca/ui/utils/extensions/jiffy_extensions.dart';
import 'package:amca/ui/utils/extensions/string_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:jiffy/jiffy.dart';

/// Enum defining different types of date selection.
enum DateSelectedType {
  month,
  semester,
  year,
}

/// ViewModel class for managing date selection and formatting in a chart card widget.
class ChartCardVM extends ChangeNotifier {
  late Jiffy currentDateTime;

/// Constructor initializing the `dateSelectedType` and setting the initial `currentDateTime`.
  ChartCardVM({
    required this.dateSelectedType,
  }) {
    currentDateTime = _initCurrentDateTime();
  }

  DateSelectedType dateSelectedType;/// Current selected date type.

  String get currentDateFormatted => _currentDateBySelectedType();/// Formatted current date based on the selected type.

 /// Increases the current date based on the selected type.
  void increaseDate() {
    if (dateSelectedType == DateSelectedType.month) {
      currentDateTime = currentDateTime.add(months: 1);
    }
    if (dateSelectedType == DateSelectedType.semester) {
      currentDateTime = currentDateTime.add(months: 6);
    }

    notifyListeners();
  }

/// Decreases the current date based on the selected type.
  void decreaseDate() {
    if (dateSelectedType == DateSelectedType.month) {
      currentDateTime = currentDateTime.subtract(months: 1);
    }
    if (dateSelectedType == DateSelectedType.semester) {
      currentDateTime = currentDateTime.subtract(months: 6);
    }

    notifyListeners();
  }

/// Formats the current date based on the selected type.
  String _currentDateBySelectedType() {
    final yearSelected = currentDateTime.year;
    switch (dateSelectedType) {
      case DateSelectedType.month:
        return '${currentDateTime.MMMM.firstLetterInCapitalize()} $yearSelected';
      case DateSelectedType.semester:
        return '${AmcaWords.semester} ${currentDateTime.semester} - $yearSelected ';
      default:
        return '';
    }
  }

/// Initializes the current date based on the selected type.
  Jiffy _initCurrentDateTime() {
    switch (dateSelectedType) {
      case DateSelectedType.month:
        return Jiffy.now();
      case DateSelectedType.semester:
        return Jiffy.now().dateBySemester();
      default:
        return Jiffy.now();
    }
  }

/// Sets the filter date based on the provided format.
  void setFilterDate(String format) {
    currentDateTime = Jiffy.parse(format);
    notifyListeners();
  }
}
