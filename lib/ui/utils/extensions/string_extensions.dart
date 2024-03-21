import 'package:intl/intl.dart';

extension EmailValidator on String {
  static const _locale = 'en';

  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }

  String formatNumberToColombianPesos() =>
      NumberFormat.decimalPattern(_locale).format(int.parse(this));

  String firstLetterInCapitalize() => this[0].toUpperCase() + substring(1);
}
