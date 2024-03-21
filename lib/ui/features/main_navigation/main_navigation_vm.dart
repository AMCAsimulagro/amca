/// {@category Navigation}
import 'package:flutter/cupertino.dart';

class MainNavigationVM extends ChangeNotifier {
  /// Current selected page index (0-based)
  int currentPage = 0;

  /// Function to change the current page
  void changePage(int index) {
    currentPage = index;
    notifyListeners();
  }
}
