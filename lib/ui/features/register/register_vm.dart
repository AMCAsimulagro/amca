import 'package:amca/data/repository/login_repository.dart';
import 'package:amca/data/repository/state_repository.dart';
import 'package:amca/dependecy_injection.dart';
import 'package:amca/domain/model/amca_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:amca/domain/model/state.dart' as state_colombia;

class RegisterVM extends ChangeNotifier {
  final StateRepository stateRepository = locator<StateRepository>();
  final LoginRepository loginRepository = locator<LoginRepository>();

  List<state_colombia.State> states = [];
  List<String> towns = [];

  bool _acceptPolicies = false;

  bool get acceptPolicies => _acceptPolicies;

  set acceptPolicies(bool value) {
    _acceptPolicies = value;
    notifyListeners();
  }

  Future<void> loadStatesAndCities() async {
    states = await stateRepository.getStates();
    notifyListeners();
  }

  void setState(String state) {
    towns = states
        .firstWhere((element) => element.departamento == state)
        .ciudades!
        .toList();
    notifyListeners();
  }

  Future<UserCredential?> createUser(AmcaUser user, String password) async {
    try {
      final result = await loginRepository.createUserWithEmailAndPassword(user, password);
      return result;
    } catch (e) {
      rethrow;
    }
  }
}
