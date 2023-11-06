import 'package:amca/ui/utils/extensions/string_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:jiffy/jiffy.dart';

class ChartCardVM extends ChangeNotifier {
  Jiffy currentDateTime = Jiffy.now();

  String get currentDateFormatted {
    return '${currentDateTime.MMMM.firstLetterInCapitalize()} ${currentDateTime.year}';
  }

  void increaseDate() {
    currentDateTime = currentDateTime.add(months: 1);
    notifyListeners();
  }

  void decreaseDate() {
    currentDateTime = currentDateTime.subtract(months: 1);
    notifyListeners();
  }
}
