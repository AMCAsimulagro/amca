/// {@category Utils}
/// Class that provides error messages associated with API exception codes.
library;
import 'package:amca/ui/utils/amca_words.dart';

/// Gets the error message associated with an exception code.
///
/// If no message is found associated with the given code, a general error message is returned.

class ApiExceptionsCode {
  static String getAuthMessage(String code) {
    final errorCode = {
      ///AUTH
      /// Authentication exceptions
      'user-disabled': AmcaWords.operationNotAllowed,
      'user-not-found': AmcaWords.yourEmailOrPasswordIsIncorrect,
      'wrong-password': AmcaWords.yourEmailOrPasswordIsIncorrect,
      'already_exist_identification':
          AmcaWords.thisIdentificationNumberIsAlreadyInUse,

      ///REGISTER_ERRORS
      'email-already-in-use': AmcaWords.emailAlreadyInUse,
      'invalid-email': AmcaWords.enterAValidEmail,
      'weak-password': AmcaWords.weakPassword,
      'operation-not-allowed': AmcaWords.operationNotAllowed,

      ///GENERAL_ERROR
      'Constants.generalError': AmcaWords.upsError,
    };
    return errorCode[code] ?? AmcaWords.upsError;
  }
}
