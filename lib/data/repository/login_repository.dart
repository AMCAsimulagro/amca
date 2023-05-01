import 'package:amca/data/api/login_api.dart';
import 'package:amca/dependecy_injection.dart';
import 'package:amca/domain/model/amca_user.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginRepository {
  Future<UserCredential> createUserWithEmailAndPassword(
      AmcaUser user, String password);

  Future<UserCredential> signInWithIdentificationAndPassword(
      String identification, String password);

  Future<void> sendPasswordResetEmail(String email);

  Future<bool> isLogged();

  Future<void> signOut();
}

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
}
