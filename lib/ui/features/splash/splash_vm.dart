import 'package:amca/data/repository/login_repository.dart';
import 'package:amca/dependecy_injection.dart';
import 'package:flutter/cupertino.dart';

class SplashVM extends ChangeNotifier {
  final LoginRepository loginRepository = locator<LoginRepository>();

  Future<bool> isLogged(){
    return loginRepository.isLogged();
  }
}