import 'package:amca/ui/utils/amca_words.dart';

class ApiExceptionsCode {
  static String getAuthMessage(String code) {
    final errorCode = {
      ///AUTH
      'user-disabled': AmcaWords.operationNotAllowed,
      'user-not-found': AmcaWords.yourEmailOrPasswordIsIncorrect,
      'wrong-password': AmcaWords.yourEmailOrPasswordIsIncorrect,
      ///REGISTER_ERRORS
      'email-already-in-use': AmcaWords.emailAlreadyInUse,
      'invalid-email': AmcaWords.enterAValidEmail,
      'weak-password': AmcaWords.weakPassword,
      'operation-not-allowed': AmcaWords.operationNotAllowed,
      ///GENERAL_ERROR
      'Constants.generalError':AmcaWords.upsError,
    };
    return errorCode[code] ?? AmcaWords.upsError;
  }
}