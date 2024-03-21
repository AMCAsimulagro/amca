/// {@category Extensions}
///
/// This file contains the `JiffyUtils` extension, which provides utility methods
/// for the Jiffy package.
///
import 'package:amca/ui/utils/constants.dart';
import 'package:jiffy/jiffy.dart';

extension JiffyUtils on Jiffy {
  
  /// Returns the semester based on the current month.
  int get semester =>
      month < 7 ? Constants.firstSemester : Constants.secondSemester;

  /// Returns `true` if the current semester is the first semester.
  bool get isFirstSemester => semester == Constants.firstSemester;

  /// Returns `true` if the current semester is the second semester.
  bool get isSecondSemester => !isFirstSemester;

  /// Returns a Jiffy instance representing the start date of the current semester.
  ///
  /// The start date is determined based on whether the current semester is the
  /// first or second semester.
  Jiffy dateBySemester() {
    final currentSemesterDateTime =
        isFirstSemester ? DateTime(year, 1) : DateTime(year, 7);
    return Jiffy.parseFromDateTime(currentSemesterDateTime);
  }
}
