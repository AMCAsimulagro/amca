import 'package:flutter/cupertino.dart';

class MainNavigationVM extends ChangeNotifier {

  int currentPage = 0;

  void changePage(int index){
    currentPage = index;
    notifyListeners();
  }
}
