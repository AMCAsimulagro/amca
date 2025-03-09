/// {@category Extensions}
///
/// This file contains the `EmailValidator` extension, which provides utility methods
/// for validating email addresses, formatting numbers to Colombian pesos, and capitalizing
/// the first letter of a string.
///
library;
import 'package:intl/intl.dart';

extension EmailValidator on String {
  static const _locale = 'en';

  /// Validates whether the string is a valid email address.
  ///
  /// Returns `true` if the string is a valid email address, otherwise `false`.
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }

  /// Formats the string as a number in Colombian pesos format.
  ///
  /// Returns the string formatted as a number in Colombian pesos.
  String formatNumberToColombianPesos() =>
      NumberFormat.decimalPattern(_locale).format(int.parse(this));

  /// Capitalizes the first letter of the string.
  ///
  /// Returns the string with the first letter capitalized.
  String firstLetterInCapitalize() => this[0].toUpperCase() + substring(1);
}
