/// {@category splash}
/// Class that models the ViewModel for the Splash screen.
///
/// Is responsible for:
/// - Manage user login status.
/// - Notify the UI about changes to the login state.
library;

import 'package:amca/data/repository/login_repository.dart';
import 'package:amca/dependecy_injection.dart';
import 'package:flutter/cupertino.dart';

class SplashVM extends ChangeNotifier {
  /// Repository that handles login-related operations.
  ///
  /// Obtained through the dependency injection system.
  final LoginRepository loginRepository = locator<LoginRepository>();

  /// Checks the user's login status.
  ///
  /// Returns a Future that will be populated with a boolean indicating whether the user is logged in.
  Future<bool> isLogged() {
// Notify listeners of the login state change.
    return loginRepository.isLogged();
  }
}
