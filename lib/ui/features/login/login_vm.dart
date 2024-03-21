import 'package:amca/data/repository/login_repository.dart';
import 'package:amca/dependecy_injection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginVM extends ChangeNotifier {
  final LoginRepository loginRepository = locator<LoginRepository>();

  String identification = '';
  String password = '';

  Future<UserCredential?> doLogin() async {
    try {
      final result = await loginRepository.signInWithIdentificationAndPassword(
        identification,
        password,
      );
      return result;
    } catch (e) {
      rethrow;
    }
  }
}
