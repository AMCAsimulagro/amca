import 'package:flutter/material.dart';

class NavigationHelper {
  static void push(Widget page, BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => page,
      ),
    );
  }

  static void pushAndRemoveUntil(Widget page, BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) =>
        page,
      ),
      ModalRoute.withName('/'),
    );
  }
}