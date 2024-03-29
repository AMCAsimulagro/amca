/// {@category Repository}
/// This file contains the implementation of an interface `LoginRepository` and its adapter `LoginRepositoryAdapter`
/// 
/// which provide methods to interact with the Login API in a Flutter application for managing user authentication and account-related actions.

/// Imports of Bookstores and Resources
import 'package:amca/data/api/login_api.dart';
import 'package:amca/dependecy_injection.dart';
import 'package:amca/domain/model/amca_user.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Abstract class defining methods to interact with the Login API for user authentication and account-related actions.
abstract class LoginRepository {
  Future<UserCredential> createUserWithEmailAndPassword(
      AmcaUser user, String password);/// Creates a new user account with email and password.

  Future<UserCredential> signInWithIdentificationAndPassword(
      String identification, String password);/// Signs in an existing user with identification (e.g., email) and password.

  Future<void> sendPasswordResetEmail(String email);/// Sends a password reset email to the specified email address.

  Future<bool> isLogged();/// Checks if a user is currently logged in.

  Future<void> signOut();/// Signs out the current user.

  Future<AmcaUser> getUserCurrentlyLogged();/// Retrieves the user currently logged in.

  Future<void> recoverPassword(String email);/// Sends a password recovery email to the specified email address.

  Future<void> deleteAccount();/// Deletes the current user account.
}

/// Implementation of the `LoginRepository` interface.
class LoginRepositoryAdapter extends LoginRepository {
  final LoginApi _api = locator<LoginApi>();

  @override
  Future<UserCredential> createUserWithEmailAndPassword(
      AmcaUser user, String password) {
    return _api.createUserWithEmailAndPassword(user, password);
  }

  @override
  Future<UserCredential> signInWithIdentificationAndPassword(
      String identification, String password) {
    return _api.signInWithIdentificationAndPassword(identification, password);
  }

  @override
  Future<void> sendPasswordResetEmail(String email) {
    return _api.sendPasswordResetEmail(email);
  }

  @override
  Future<bool> isLogged() {
    return _api.isLogged();
  }

  @override
  Future<void> signOut() {
    return _api.signOut();
  }

  @override
  Future<AmcaUser> getUserCurrentlyLogged() {
    return _api.getUserCurrentlyLogged();
  }

  @override
  Future<void> recoverPassword(String email) {
    return _api.recoverPassword(email);
  }

  @override
  Future<void> deleteAccount() {
    return _api.deleteAccount();
  }
}
