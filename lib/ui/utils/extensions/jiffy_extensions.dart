import 'package:amca/ui/utils/constants.dart';
import 'package:jiffy/jiffy.dart';

extension JiffyUtils on Jiffy {
  int get semester =>
      month < 7 ? Constants.firstSemester : Constants.secondSemester;

  bool get isFirstSemester => semester == Constants.firstSemester;
  bool get isSecondSemester => !isFirstSemester;

  Jiffy dateBySemester() {
    final currentSemesterDateTime =
        isFirstSemester ? DateTime(year, 1) : DateTime(year, 7);
    return Jiffy.parseFromDateTime(currentSemesterDateTime);
  }
}
