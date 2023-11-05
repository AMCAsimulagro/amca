import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

class ChartCardVM extends ChangeNotifier {

  String currentDateFormatted = '';
  DateTime currentDateTime = DateTime.now();


  void init() {
    DateFormat dateFormat = DateFormat.yMMMM();
    String formattedDate = dateFormat.format(currentDateTime);
    currentDateFormatted = formattedDate;
    notifyListeners();
  }

  void increaseDate(){
    var jiffy = Jiffy.;
  }
}
