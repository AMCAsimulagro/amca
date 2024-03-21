/// {@category Register}
/// Class that models the view model (ViewModel) for the Register screen.
///
/// It is responsible for:
///  - Loading states and cities from the repository.
///  - Managing user selections for state and town.
///  - Handling user registration through the LoginRepository.
import 'package:amca/data/repository/login_repository.dart';
import 'package:amca/data/repository/state_repository.dart';
import 'package:amca/dependecy_injection.dart';
import 'package:amca/domain/model/amca_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:amca/domain/model/state.dart' as state_colombia;

class RegisterVM extends ChangeNotifier {
  /// Repository that handles operations related to obtaining states.
  final StateRepository stateRepository = locator<StateRepository>();

  /// Repositorio que maneja la lógica de registro de usuarios.
  final LoginRepository loginRepository = locator<LoginRepository>();

 /// List to store the available states retrieved from the repository.
  List<state_colombia.State> states = [];

  /// List to store the available cities according to the selected state.
  List<String> towns = [];

  /// Internal variable to track the user's acceptance of the policies.
  bool _acceptPolicies = false;

  /// Gets if the user has accepted the policies.
  bool get acceptPolicies => _acceptPolicies;

  /// Establishes whether the user has accepted the policies, notifies listeners of the change.
  set acceptPolicies(bool value) {
    _acceptPolicies = value;
    notifyListeners();
  }

  /// Function to load states and cities from the repository.
  Future<void> loadStatesAndCities() async {
    /// Gets the states of the StateRepository.
    states = await stateRepository.getStates();

    /// Notifies listeners about changes to the status list.
    notifyListeners();
  }

  void setState(String state) {
    towns = states
        .firstWhere((element) => element.departamento == state)
        .ciudades!
        .toList();
    notifyListeners();
  }

  /// Function to create a user account with the LoginRepository.
  Future<UserCredential?> createUser(AmcaUser user, String password) async {
    try {
      final result =
          await loginRepository.createUserWithEmailAndPassword(user, password);
      return result;
    } catch (e) {
      rethrow;
    }
  }
}
