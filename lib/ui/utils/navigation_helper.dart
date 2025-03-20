/// {@category Utils}
library;

import 'package:flutter/material.dart';

/// Navigate to a new screen and stack the current screen into the navigation stack.
///
/// [page] is the widget of the page you want to navigate to.
/// [context] is the application context.
class NavigationHelper {
  static void push(Widget page, BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => page,
      ),
    );
  }

  /// Navigate to a new screen and remove all screens from the navigation stack,
  /// leaving only the new screen as the main page.
  ///
  /// [page] is the widget of the page you want to navigate to.
  /// [context] is the application context.
  static void pushAndRemoveUntil(Widget page, BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => page,
      ),
      ModalRoute.withName('/'),
    );
  }
}
