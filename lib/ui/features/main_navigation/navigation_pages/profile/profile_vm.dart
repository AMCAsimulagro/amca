import 'package:amca/data/repository/login_repository.dart';
import 'package:amca/dependecy_injection.dart';
import 'package:flutter/cupertino.dart';

class ProfileVM extends ChangeNotifier{
  final LoginRepository loginRepository = locator<LoginRepository>();

  Future<void> signOut() {
    return loginRepository.signOut();
  }
}