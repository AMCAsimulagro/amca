import 'package:amca/data/repository/login_repository.dart';
import 'package:amca/dependecy_injection.dart';
import 'package:amca/domain/model/amca_user.dart';
import 'package:flutter/cupertino.dart';

class ProfileVM extends ChangeNotifier {
  final LoginRepository loginRepository = locator<LoginRepository>();
  AmcaUser? currentUser;

  void init() async {
    try {
      currentUser = await loginRepository.getUserCurrentlyLogged();
    } catch (e) {
    } finally {
      notifyListeners();
    }
  }

  Future<void> signOut() {
    return loginRepository.signOut();
  }
  Future<void> deleteAccount() {
    return loginRepository.deleteAccount();
  }
}
