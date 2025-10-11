/// {@category Login}
/// Remember password
library;
import 'package:amca/data/repository/login_repository.dart';
// import 'package:amca/data/repository/state_repository.dart';
import 'package:amca/dependecy_injection.dart';
// import 'package:amca/domain/model/amca_user.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
// import 'package:amca/domain/model/state.dart' as state_colombia;

class ForgotPasswordVM extends ChangeNotifier {
  final LoginRepository loginRepository = locator<LoginRepository>();


  Future<void> recoverPassword(String email) async {
    try {
      await loginRepository.recoverPassword(email);
      return;
    } catch (e) {
      rethrow;
    }
  }
}
