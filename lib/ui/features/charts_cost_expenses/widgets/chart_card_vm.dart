import 'package:amca/ui/utils/amca_words.dart';
import 'package:amca/ui/utils/extensions/jiffy_extensions.dart';
import 'package:amca/ui/utils/extensions/string_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:jiffy/jiffy.dart';

enum DateSelectedType {
  month,
  semester,
  year,
}

class ChartCardVM extends ChangeNotifier {
  late Jiffy currentDateTime;

  ChartCardVM({
    required this.dateSelectedType,
  }) {
    currentDateTime = _initCurrentDateTime();
  }

  DateSelectedType dateSelectedType;

  String get currentDateFormatted => _currentDateBySelectedType();

  void increaseDate() {
    if (dateSelectedType == DateSelectedType.month) {
      currentDateTime = currentDateTime.add(months: 1);
    }
    if (dateSelectedType == DateSelectedType.semester) {
      currentDateTime = currentDateTime.add(months: 6);
    }

    notifyListeners();
  }

  void decreaseDate() {
    if (dateSelectedType == DateSelectedType.month) {
      currentDateTime = currentDateTime.subtract(months: 1);
    }
    if (dateSelectedType == DateSelectedType.semester) {
      currentDateTime = currentDateTime.subtract(months: 6);
    }

    notifyListeners();
  }

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

  void setFilterDate(String format) {
    currentDateTime = Jiffy.parse(format);
    notifyListeners();
  }
}
